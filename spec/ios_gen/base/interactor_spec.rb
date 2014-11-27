require 'spec_helper'
include IOSGen::Base

describe IOSGen::Base::Interactor do

  description = 'Api Interactions required by Notification ViewModel'

  name = 'FJBNotificationsApiInteractor'

  properties = [Property.new(type: 'TestType', name: 'TestName'),
                Property.new(type: 'TestType2', name: 'TestName2')]

  action = Action.new(description: 'Perform API request to mark a notification as read',
                      return_type: 'void',
                      name: 'markNotificationAsRead:onCompletionBlock:',
                      arguments: [Property.new(type: 'NSString', name: 'notificationId'),
                                  Property.new(type: '^()', name: 'completionBlock')])
  actions = [action]

  describe '#Properties' do
    interactor = described_class.new(description: description,
                                     name: name,
                                     properties: properties,
                                     actions: actions)

    it 'has a description' do
      expect(interactor.description).to eq(description)
    end

    it 'has a name' do
      expect(interactor.name).to eq(name)
    end

    it 'has properties' do
      expect(interactor.properties).to be_a Array
      expect(interactor.properties.length).to eq(2)
      property1 = interactor.properties[0]
      property2 = interactor.properties[1]
      expect(property1).to be_a Property
      expect(property2).to be_a Property
    end

    it 'has actions' do
      expect(interactor.actions).to be_a Array
      expect(interactor.actions.length).to eq(1)
      action = interactor.actions[0]
      expect(action).to be_a Action
    end

  end

  describe 'Optional properties' do
    interactor = described_class.new(description: description,
                                     name: name,
                                     actions: actions)
    it 'has not properties' do
      expect(interactor.properties.nil?).to be true
    end
  end
end
