require 'spec_helper'

include IOSGen::Base

describe IOSGen::Base::ViewModel do

  description = 'State of NotificationViewController and perform bussiness logic'

  name = 'FJBNotificationsViewModel'

  properties = [Property.new(type: 'NSIndexPath', name: 'selectedIndexPath')]

  actions = [Action.new(description: 'Dismiss the ViewController when the button is tapped',
                        return_type: 'void',
                        name: 'didTapOnCloseButton'),
             Action.new(description: 'Mark notification as read when the notification is selected',
                        return_type: 'void',
                        name: 'didTapAtIndexPath',
                        arguments: [Property.new(type: 'NSIndexPath',
                                                 name: 'indexPath')])]

  interactors = [Interactor.new(description: 'Api Interactions required by Notification ViewModel',
                                name: 'FJBNotificationsApiInteractor',
                                actions: [Action.new(description: 'Perform API request to mark a notification as read',
                                                     return_type: 'void',
                                                     name: 'markNotificationAsRead:onCompletionBlock:',
                                                     arguments: [Property.new(type: 'NSString',
                                                                              name: 'notificationId'),
                                                                 Property.new(type: '^()',
                                                                              name: 'completionBlock')
                                                                ])])]
  describe '#Properties' do

    view_model = described_class.new(description: description,
                                     name: name,
                                     properties: properties,
                                     actions: actions,
                                     interactors: interactors)
    it 'has a description' do
      expect(view_model.description).to eq(description)
    end

    it 'has a name' do
      expect(view_model.name).to eq(name)
    end

    it 'has properties' do
      properties = view_model.properties
      expect(properties.length).to eq(1)
      property = properties[0]
      expect(property).to be_a Property
    end

    it 'has actions' do
      actions = view_model.actions
      expect(actions.length).to eq(2)
      action0 = actions[0]
      action1 = actions[1]
      expect(action0).to be_a Action
      expect(action1).to be_a Action
    end

    it 'has interactors' do
      interactors = view_model.interactors
      expect(interactors.length).to eq(1)
      interactor = interactors[0]
      expect(interactor).to be_a Interactor
    end
  end
end
