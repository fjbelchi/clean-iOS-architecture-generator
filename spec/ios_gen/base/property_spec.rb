require 'spec_helper'
require 'json'

describe IOSGen::Base::Property do

  describe '#Properties' do

    type = 'NSIndexPath'
    name = 'selectedIndexPath'
    property = described_class.new(name: name, type: type)

    it 'has to be a property' do
      expect(property).to be_a described_class
    end

    it 'has Type' do
      expect(property.type).to eq(type)
    end

    it 'has Name' do
      expect(property.name).to eq(name)
    end

  end

end
