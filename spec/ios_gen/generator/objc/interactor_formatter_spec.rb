require 'spec_helper'

describe IOSGen::Generator::Objc::InteractorFormatter do

  interactor = Interactor.new(description: 'Api Interactions required by Notification ViewModel',
                              name: 'FJBNotificationsApiInteractor',
                              actions: [Action.new(description: 'Perform API request to mark a notification as read',
                                                   return_type: 'void',
                                                   name: 'markNotificationAsRead:onCompletionBlock:',
                                                   arguments: [Property.new(type: 'NSString *',
                                                                            name: 'notificationId'),
                                                               Property.new(type: '^()',
                                                                            name: 'completionBlock')
                                                              ])])

  formatter = described_class.new
  formatter.interactor = interactor

  describe 'Properties' do
    it 'has header_file_name' do
      expect(formatter.header_file_name).to eq('FJBNotificationsApiInteractor.h')
    end

    it 'has impl_file_name' do
      expect(formatter.impl_file_name).to eq('FJBNotificationsApiInteractor.m')
    end

    it 'has protocol_file_name' do
      expect(formatter.protocol_file_name).to eq('FJBNotificationsApiInteractorProtocol.h')
    end

    it 'has protocol_name' do
      expect(formatter.protocol_name).to eq('FJBNotificationsApiInteractorProtocol')
    end

    it 'has properties_header' do
      expect(formatter.properties_header).to eq('')
    end

    it 'has actions_header' do
      expected_string = "// Perform API request to mark a notification as read\n- (void)markNotificationAsRead:(NSString *)notificationId onCompletionBlock:(^())completionBlock;"
      expect(formatter.actions_header).to eq(expected_string)
    end

    it 'has actions_impl' do
      expected_string = "- (void)markNotificationAsRead:(NSString *)notificationId onCompletionBlock:(^())completionBlock\n{\n}"
      expect(formatter.actions_impl).to eq(expected_string)
    end
  end

  describe '#generate' do
    it 'has to yield 3 times' do
      expect { |b| formatter.generate(&b) }.to yield_control.exactly(3).times
    end

    file_names = []
    templates = []

    formatter.generate do |file_name, template|
      file_names << file_name
      templates << template
    end

    it 'has to return protocol file name and template' do
      expect(file_names[0]).to eq(formatter.protocol_file_name)
      expect(templates[0]).to eq('templates/objc/InteractorProtocol.h.erb')
    end

    it 'has to return header file name and template' do
      expect(file_names[1]).to eq(formatter.header_file_name)
      expect(templates[1]).to eq('templates/objc/Interactor.h.erb')
    end

    it 'has to return implementation file name and template' do
      expect(file_names[2]).to eq(formatter.impl_file_name)
      expect(templates[2]).to eq('templates/objc/Interactor.m.erb')
    end
  end
end
