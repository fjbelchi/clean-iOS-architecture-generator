require 'spec_helper'

describe IOSGen::Generator::Objc::ViewModelFormatter do

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

  formatter = described_class.new
  formatter.view_model = view_model

  describe '#Properties ViewModel' do

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

  describe '#generate' do

    it 'has to yield 6 times' do
      expect { |b| formatter.generate(&b) }.to yield_control.exactly(6).times
    end

    file_names = []
    templates = []

    formatter.generate do |file_name, template|
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

    it 'has to return implementation file name and template' do
      expect(file_names[2]).to eq(formatter.view_model_impl_file_name)
      expect(templates[2]).to eq('templates/objc/ViewModel.m.erb')
    end

    it 'has to return interactor protocol file name and template' do
      expect(file_names[3]).to eq(formatter.interactor_formatter.interactor_protocol_file_name)
      expect(templates[3]).to eq('templates/objc/InteractorProtocol.h.erb')
    end

    it 'has to return interactor header file name and template' do
      expect(file_names[4]).to eq(formatter.interactor_formatter.interactor_header_file_name)
      expect(templates[4]).to eq('templates/objc/Interactor.h.erb')
    end

    it 'has to return interactor implementation file name and template' do
      expect(file_names[5]).to eq(formatter.interactor_formatter.interactor_impl_file_name)
      expect(templates[5]).to eq('templates/objc/Interactor.m.erb')
    end

  end
end
