require 'spec_helper'
require 'json'

include IOSGen::Base

describe IOSGen::Base::Action do

  describe '#Properties' do

    description = 'Dismiss the ViewController when the button is tapped'
    return_type = 'void'
    name = 'didTapOnCloseButton'
    arguments = [Property.new(type: 'UIButton',
                              name: 'closeButton')]
    action = described_class.new(description: description,
                                 return_type: return_type, name: name,
                                 arguments: arguments)

    it 'has description' do
      expect(action.description).to eq(description)
    end

    it 'has return_type' do
      expect(action.return_type).to eq(return_type)
    end

    it 'has name' do
      expect(action.name).to eq(name)
    end

    it 'has arguments' do
      expect(action.arguments.empty?).to be false
      property = action.arguments[0]
      expect(property).to be_kind_of Property
    end

  end

  describe '#JSON' do

    json = '{
      "description": "Dismiss the ViewController when the button is tapped",
      "return_type": "void",
      "name": "didTapOnCloseButton:",
      "arguments": [{
        "type" : "UIButton",
        "name" : "closeButton"
        }]
    }'

    it 'has to parse JSON' do
      hash = JSON.parse(json)
      action = described_class.new(hash)
      expect(action.description).to eq('Dismiss the ViewController when the button is tapped')
      expect(action.return_type).to eq('void')
      expect(action.name).to eq('didTapOnCloseButton:')
      expect(action.arguments.empty?).to be false
      property = action.arguments[0]
      expect(property).to be_kind_of Property
    end

  end

end
