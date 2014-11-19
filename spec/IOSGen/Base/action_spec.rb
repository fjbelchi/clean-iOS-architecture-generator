require 'spec_helper'
require 'json'

describe IOSGen::Base::Action do

  describe '#Properties' do

    description = 'Dismiss the ViewController when the button is tapped'
    return_type = 'void'
    name = 'didTapOnCloseButton'
    arguments = [IOSGen::Base::Property.new(type: 'UIButton',
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
      expect(property).to be_kind_of IOSGen::Base::Property
    end

  end
end
