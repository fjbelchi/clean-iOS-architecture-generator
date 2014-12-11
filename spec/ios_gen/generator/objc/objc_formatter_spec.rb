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

  describe '#Properties ViewModel' do

    view_model = ViewModel.new(description: description,
                               name: name,
                               properties: properties,
                               actions: actions,
                               interactors: interactors)

    formatter = described_class.new
    formatter.view_model = view_model

    it 'has view_model_properties_header' do
      expected_string = '@property (nonatomic, strong) NSIndexPath *selectedIndexPath;'
      expect(formatter.view_model_properties_header).to eq(expected_string)
    end

    it 'has view_model_actions_header' do
      expected_string1 = "// Dismiss the ViewController when the button is tapped\n- (void)didTapOnCloseButton;\n"
      expected_string2 = "// Mark notification as read when the notification is selected\n- (void)didTapAtIndexPath:(NSIndexPath *)indexPath;"
      expected_string = expected_string1 + expected_string2
      expect(formatter.view_model_actions_header).to eq(expected_string)
    end

    it 'has view_model_actions_impl' do
      expected_string = "- (void)didTapOnCloseButton\n{\n}\n- (void)didTapAtIndexPath:(NSIndexPath *)indexPath\n{\n}"
      expect(formatter.view_model_actions_impl).to eq(expected_string)
    end

    it 'has view_model_header_file_name' do
      expect(formatter.view_model_header_file_name).to eq('FJBNotificationsViewModel.h')
    end

    it 'has view_model_impl_file_name' do
      expect(formatter.view_model_impl_file_name).to eq('FJBNotificationsViewModel.m')
    end

    it 'has view_model_protocol_name' do
      expect(formatter.view_model_protocol_name).to eq('FJBNotificationsViewModelProtocol')
    end

    it 'has view_model_protocol_file_name' do
      expect(formatter.view_model_protocol_file_name).to eq('FJBNotificationsViewModelProtocol.h')
    end

    it 'has view_model_protocol_delegate' do
      expect(formatter.view_model_protocol_delegate).to eq('FJBNotificationsViewModelProtocolDelegate')
    end
  end

  describe '#generate_view_model' do
    view_model = ViewModel.new(description: description,
                               name: name,
                               properties: properties,
                               actions: actions,
                               interactors: interactors)

    formatter = described_class.new
    formatter.view_model = view_model

    it 'has to yield 3 times' do
      expect { |b| formatter.generate_view_model(&b) }.to yield_control.exactly(3).times
    end

    file_names = []
    templates = []

    formatter.generate_view_model do |file_name, template|
      file_names << file_name
      templates << template
    end

    it 'has to return protocol file name and template' do
      expect(file_names[0]).to eq(formatter.view_model_protocol_file_name)
      expect(templates[0]).to eq('templates/objc/ViewModelProtocol.h.erb')
    end

    it 'has to return header file name and template' do
      expect(file_names[1]).to eq(formatter.view_model_header_file_name)
      expect(templates[1]).to eq('templates/objc/ViewModel.h.erb')
    end
    it 'has to return implementation file name template' do
      expect(file_names[2]).to eq(formatter.view_model_impl_file_name)
      expect(templates[2]).to eq('templates/objc/ViewModel.m.erb')
    end

  end

end
