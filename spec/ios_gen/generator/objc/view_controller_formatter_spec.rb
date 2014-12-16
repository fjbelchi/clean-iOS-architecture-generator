require 'spec_helper'

include IOSGen::Generator::Objc

describe IOSGen::Generator::Objc::ViewControllerFormatter do

  name = 'FJBNotificationViewController'
  description = 'ViewController to display notifications'
  view_controller = ViewController.new(name: name,
                                       description: description)
  formatter = described_class.new
  formatter.view_controller = view_controller

  describe 'Properties' do
    it 'has header_file_name' do
      expect(formatter.header_file_name).to eq('FJBNotificationViewController.h')
    end

    it 'has impl_file_name' do
      expect(formatter.impl_file_name).to eq('FJBNotificationViewController.m')
    end

    it 'has a view_model_formatter' do
      expect(formatter.view_model_formatter).to be_a ViewModelFormatter
    end
  end

  describe '#generate' do

    it 'has to yield 2 times' do
      expect { |b| formatter.generate(&b) }.to yield_control.exactly(2).times
    end

    file_names = []
    templates = []

    formatter.generate do |file_name, template|
      file_names << file_name
      templates << template
    end

    it 'has to return header file name and template' do
      expect(file_names[0]).to eq(formatter.header_file_name)
      expect(templates[0]).to eq('templates/objc/UIViewController.h.erb')
    end

    it 'has to return implementation file name and template' do
      expect(file_names[1]).to eq(formatter.impl_file_name)
      expect(templates[1]).to eq('templates/objc/UIViewController.m.erb')
    end
  end
end
