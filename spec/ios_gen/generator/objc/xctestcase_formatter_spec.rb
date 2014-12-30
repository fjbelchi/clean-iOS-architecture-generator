require 'spec_helper'

describe IOSGen::Generator::Objc::XctestcaseFormatter do
  context 'Formatter with all object properties' do
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

    view_model = ViewModel.new(description: description,
                               name: name,
                               properties: properties,
                               actions: actions)

    formatter = described_class.new
    formatter.object = view_model

    describe '#Properties' do
      it 'has a name' do
        expect(formatter.name).to eq('FJBNotificationsViewModelTests')
      end

      it 'has file_name' do
        expect(formatter.file_name).to eq('FJBNotificationsViewModelTests.m')
      end

      it 'has actions_impl' do
        expected_string = "// Dismiss the ViewController when the button is tapped\n\n- (void)testdidTapOnCloseButtonShouldPass\n{\n    // given\n    // when\n    // then\n    XCTFail(@\"No implemented test\");\n}\n\n// Mark notification as read when the notification is selected\n\n- (void)testdidTapAtIndexPathShouldPass\n{\n    // given\n    // when\n    // then\n    XCTFail(@\"No implemented test\");\n}\n"
        expect(formatter.actions_impl).to eq(expected_string)
      end
    end

    describe '#generate' do
      it 'has to yield 2 times' do
        expect { |b| formatter.generate(&b) }.to yield_control.exactly(1).times
      end

      file_names = []
      templates = []

      formatter.generate do |file_name, template|
        file_names << file_name
        templates << template
      end

      it 'has to return ViewModel test file name and template' do
        expect(file_names[0]).to eq(formatter.file_name)
        expect(templates[0]).to eq('templates/objc/XCTestCase.m.erb')
      end
    end
  end

  context 'Formatter with no properties' do
    view_model = 'ViewModel.new'

    formatter = described_class.new
    formatter.object = view_model

    describe '#Properties' do
      it 'has a name' do
        expect(formatter.name).to be_nil
      end

      it 'has file_name' do
        expect(formatter.file_name).to be_nil
      end

      it 'has actions_impl' do
        expect(formatter.actions_impl).to be_nil
      end
    end
  end
end
