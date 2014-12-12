require 'spec_helper'

describe IOSGen::Generator::BaseGenerator do

  describe '#Intialize' do
    file_path = File.dirname(__FILE__) + '/test.json'
    generator = described_class.new(type: :objc,
                                    file_spec: file_path,
                                    destination: 'path')
    it 'has to be a generator' do
      expect(generator).to be_a described_class
    end
  end

  describe '#Properties' do
    file_path = File.dirname(__FILE__) + '/test.json'
    generator = described_class.new(type: :objc,
                                    file_spec: file_path,
                                    destination: 'path')
    it 'has a formatter' do
      expect(generator.formatter).to be_a IOSGen::Generator::Objc::Formatter
    end

    it 'has ViewModel' do
      expect(generator.view_model).to be_a ViewModel
    end

    it 'has ViewModel.Interactors' do
      expect(generator.view_model.interactors).to be_a Array
    end

  end

  describe '#Methods' do

    describe '#Objc' do
      it 'has generate method' do
      end
    end

  end
end
