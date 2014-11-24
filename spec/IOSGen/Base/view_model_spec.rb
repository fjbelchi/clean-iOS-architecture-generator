require 'spec_helper'

include IOSGen::Base

describe IOSGen::Base::ViewModel do

  describe '#Properties' do

    description = 'State of NotificationViewController and perform bussiness logic'
    name = 'FJBNotificationsViewModel'
    properties = [Property.new(type: 'NSIndexPath', name: 'selectedIndexPath')]
    actions = []
    interactors = []
    it 'has a description' do
    end

    it 'has a name' do
    end

    it 'has properties' do
    end

    it 'has actions' do
    end

    it 'has interactors' do
    end
  end
end
