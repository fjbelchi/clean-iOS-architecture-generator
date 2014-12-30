require 'spec_helper'

describe IOSGen::Generator::Objc::Formatter do

  description = 'State of NotificationViewController and perform bussiness logic'

  name = 'FJBNotificationsViewModel'

  properties = [Property.new(type: 'NSIndexPath *', name: 'selectedIndexPath')]

  actions = [Action.new(description: 'Dismiss the ViewController when the button is tapped',
                        return_type: 'void',
                        name: 'didTapOnCloseButton'),
             Action.new(description: 'Mark notification as read when the notification is selected',
                        return_type: 'void',
                        name: 'didTapAtIndexPath:',
                        arguments: [Property.new(type: 'NSIndexPath *',
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
  view_model = ViewModel.new(description: description,
                             name: name,
                             properties: properties,
                             actions: actions,
                             interactors: interactors)

  name_view_controller = 'FJBNotificationViewController'
  description_view_controller = 'ViewController to display notifications'

  view_controller = ViewController.new(name: name_view_controller,
                                       description: description_view_controller)

  formatter = described_class.new
  formatter.view_model = view_model
  formatter.view_controller = view_controller

  describe '#generate' do
    it 'has to yield 8 times' do
      expect { |b| formatter.generate(&b) }.to yield_control.exactly(8).times
    end
  end
end
