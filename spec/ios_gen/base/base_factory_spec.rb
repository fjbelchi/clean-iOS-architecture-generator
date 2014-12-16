require 'spec_helper'

describe IOSGen::Base::BaseFactory do

  describe '#Property' do

    json = '{
      "type": "UIButton",
      "name": "button"
    }'

    it 'expect to parse JSON' do
      factory = described_class.new
      hash = JSON.parse(json)
      property = factory.parse_property(hash)
      expect(property).to be_a Property
      expect(property.type).to eq('UIButton')
      expect(property.name).to eq('button')
    end

  end

  describe '#Action' do

    description = 'Dismiss the ViewController when the button is tapped'
    name = 'didTapOnCloseButton:'
    return_type = 'void'
    json = '{
      "description": "Dismiss the ViewController when the button is tapped",
      "return_type": "void",
      "name": "didTapOnCloseButton:",
      "arguments": [{
        "type" : "UIButton",
        "name" : "closeButton"
        }]
    }'

    it 'expect to parse JSON' do
      factory = described_class.new
      hash = JSON.parse(json)
      action = factory.parse_action(hash)
      expect(action.description).to eq(description)
      expect(action.return_type).to eq(return_type)
      expect(action.name).to eq(name)
      expect(action.arguments.nil?).to be false
      property = action.arguments[0]
      expect(property).to be_a Property
    end

  end

  describe '#Interactor' do

    description = 'Api Interactions required by Notification ViewModel'
    name = 'FJBNotificationsApiInteractor'

    json = '{
      "description" : "Api Interactions required by Notification ViewModel",
      "name": "FJBNotificationsApiInteractor",
      "properties": [
        {
          "type": "UIButton",
          "name": "button"
        },
        {
          "type": "UIButton",
          "name": "button2"
        }
      ],
      "actions": [
        {
          "description": "Perform API request to mark a notification as read",
          "return_type": "void",
          "name": "markNotificationAsRead:onCompletionBlock:",
          "arguments": [
            {
              "type": "NSString",
              "name": "notificationId"
            },
            {
              "type": "^()",
              "name": "completionBlock"
            }
          ]
        }
      ]
    }'

    factory = described_class.new
    hash = JSON.parse(json)
    interactor = factory.parse_interactor(hash)

    it 'expect to parse JSON' do
      expect(interactor).to be_a Interactor
    end

    it 'has to match description' do
      expect(interactor.description).to eq(description)
    end

    it 'has to match name' do
      expect(interactor.name).to eq(name)
    end

    it 'has to containt properties' do
      expect(interactor.properties).to be_a Array
      expect(interactor.properties.length).to eq(2)
      property0 = interactor.properties[0]
      property1 = interactor.properties[1]
      expect(property0).to be_a Property
      expect(property1).to be_a Property
    end

    it 'has to containt actions' do
      expect(interactor.actions).to be_a Array
      expect(interactor.actions.length).to eq(1)
      action = interactor.actions[0]
      expect(action).to be_a Action
    end
  end

  describe '#ViewModels' do

    description = 'State of NotificationViewController and perform bussiness logic'
    name = 'FJBNotificationsViewModel'

    json = '{
      "description" : "State of NotificationViewController and perform bussiness logic",
      "name": "FJBNotificationsViewModel",
      "properties": [
        {
          "type": "NSIndexPath",
          "name": "selectedIndexPath"
        }
      ],
      "actions": [
        {
          "description": "Dismiss the ViewController when the button is tapped",
          "retun_type": "void",
          "name": "didTapOnCloseButton"
        },
        {
          "description": "Mark notification as read when the notification is selected",
          "retun_type": "void",
          "name": "didTapAtIndexPath:",
          "arguments": [
            {
              "type": "NSIndexPath",
              "name": "indexPath"
            }
          ]
        }
      ],
      "interactors": [
        {
          "description" : "Api Interactions required by Notification ViewModel",
          "name": "FJBNotificationsApiInteractor",
          "properties": [],
          "actions": [
            {
              "description": "Perform API request to mark a notification as read",
              "return_type": "void",
              "name": "markNotificationAsRead:onCompletionBlock:",
              "arguments": [
                {
                  "type": "NSString",
                  "name": "notificationId"
                },
                {
                  "type": "^()",
                  "name": "completionBlock"
                }
              ]
            }
          ]
        }
      ]
    }'

    factory = described_class.new
    hash = JSON.parse(json)
    view_model = factory.parse_view_model(hash)

    it 'has a description' do
      expect(view_model.description).to eq(description)
    end

    it 'has a name' do
      expect(view_model.name).to eq(name)
    end

    it 'has properties' do
      expect(view_model.properties).to be_a Array
      expect(view_model.properties.length).to eq(1)
      property = view_model.properties[0]
      expect(property).to be_a Property
    end

    it 'has actions' do
      expect(view_model.actions).to be_a Array
      expect(view_model.actions.length).to eq(2)
      action0 = view_model.actions[0]
      action1 = view_model.actions[1]
      expect(action0).to be_a Action
      expect(action1).to be_a Action
    end

    it 'has interactors' do
      expect(view_model.interactors).to be_a Array
      expect(view_model.interactors.length).to eq(1)
      interactor = view_model.interactors[0]
      expect(interactor).to be_a Interactor
    end
  end

  describe '#ViewController' do
    json = '{
      "description": "ViewController to show the list of notifications",
      "name": "FJBNotificationViewController",
      "view_model": "FJBNotificationsViewModel"
    }'

    factory = described_class.new
    hash = JSON.parse(json)
    view_controller = factory.parse_view_controller(hash)

    it 'expect to parse JSON' do
      expect(view_controller).to be_a ViewController
    end

    it 'has name' do
      expect(view_controller.name).to eq('FJBNotificationViewController')
    end
    it 'has description' do
      expect(view_controller.description).to eq('ViewController to show the list of notifications')
    end
  end
end
