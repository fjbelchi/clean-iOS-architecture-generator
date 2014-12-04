require 'spec_helper'

describe IOSGen::Generator::Objc::ActionFormatter do

  describe 'Action without arguments' do

    action_json = '{
      "description": "Dismiss the ViewController when the button is tapped",
      "return_type": "void",
      "name": "didTapOnCloseButton"
      }'

    hash = JSON.parse(action_json)
    action = BaseFactory.new.parse_action(hash)
    action_generator = described_class.new

    it 'has to generate interface format' do
      expected_string = "// Dismiss the ViewController when the button is tapped\n- (void)didTapOnCloseButton;"
      result = action_generator.generate_interface(action)
      expect(result).to eq(expected_string)
    end

    it 'has to generate implementation format' do
      expected_string = "- (void)didTapOnCloseButton\n{\n}"
      result = action_generator.generate_implementation(action)
      expect(result).to eq(expected_string)
    end

  end

  describe 'Actions with an argument' do

    action = Action.new(description: 'Dismiss the ViewController when the button is tapped',
                        name: 'didTapOnCloseButton:',
                        return_type: 'void',
                        arguments: [Property.new(type: 'UIButton *',
                                                 name: 'closeButton')])

    action_generator = described_class.new

    it 'has to generate interface format' do
      expected_string = "// Dismiss the ViewController when the button is tapped\n- (void)didTapOnCloseButton:(UIButton *)closeButton;"
      result = action_generator.generate_interface(action)
      expect(result).to eq(expected_string)
    end

    it 'has to generate implementation format' do
      expected_string = "- (void)didTapOnCloseButton:(UIButton *)closeButton\n{\n}"
      result = action_generator.generate_implementation(action)
      expect(result).to eq(expected_string)
    end

  end

  describe 'Actions with multiples arguments' do

    action_json = '{
      "description": "Dismiss the ViewController when the button is tapped",
      "return_type": "void",
      "name": "didTapOnCloseButton:success:",
      "arguments": [{
        "type" : "UIButton *",
        "name" : "closeButton"
        },
        {
          "type" : "BOOL",
          "name" : "success"
        }]
    }'

    hash = JSON.parse(action_json)
    action = BaseFactory.new.parse_action(hash)
    action_generator = described_class.new

    it 'has to generate interface format' do
      expected_string = "// Dismiss the ViewController when the button is tapped\n- (void)didTapOnCloseButton:(UIButton *)closeButton success:(BOOL)success;"
      result = action_generator.generate_interface(action)
      expect(result).to eq(expected_string)
    end

    it 'has to generate implementation format' do
      expected_string = "- (void)didTapOnCloseButton:(UIButton *)closeButton success:(BOOL)success\n{\n}"
      result = action_generator.generate_implementation(action)
      expect(result).to eq(expected_string)
    end
  end

end
