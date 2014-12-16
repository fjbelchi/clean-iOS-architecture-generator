require 'spec_helper'

describe IOSGen::Base::ViewController do

  name = 'FJBNotificationViewController'
  description = 'ViewController to display notifications'
  view_controller = described_class.new(name: name,
                                        description: description)
  describe '#Properties' do
    it 'has a description' do
      expect(view_controller.description).to eq(description)
    end

    it 'has a name' do
      expect(view_controller.name).to eq(name)
    end
  end
end
