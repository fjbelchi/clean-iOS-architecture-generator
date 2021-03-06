require 'spec_helper'

include IOSGen::Base

describe IOSGen::Base::Action do

  description = 'Dismiss the ViewController when the button is tapped'
  return_type = 'void'
  name = 'didTapOnCloseButton:'
  arguments = [Property.new(type: 'UIButton',
                            name: 'closeButton')]

  describe '#Properties' do
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

  describe 'Optional Properties' do

    action = described_class.new(description: description,
                                 return_type: return_type,
                                 name: name)

    it 'has not arguments' do
      expect(action.arguments.nil?).to be true
    end

  end

end
