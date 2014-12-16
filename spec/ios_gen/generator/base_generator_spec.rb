require 'spec_helper'

describe IOSGen::Generator::BaseGenerator do

  file_path = File.dirname(__FILE__) + '/test.json'
  generator = described_class.new(type: :objc,
                                  file_spec: file_path)

  describe '#Intialize' do
    it 'has to be a generator' do
      expect(generator).to be_a described_class
    end
  end

  describe '#Properties' do
    it 'has a formatter' do
      expect(generator.formatter).to be_a IOSGen::Generator::Objc::Formatter
    end

    it 'has ViewModel' do
      expect(generator.view_model).to be_a ViewModel
    end

  end

  describe '#Methods' do

    describe '#Objc' do
      it 'has generate method' do
        expect(generator).to respond_to(:generate)
      end

      context 'No spec file' do
      end

      context 'New files' do
        file_path = File.dirname(__FILE__) + '/test.json'
        generator = described_class.new(type: :objc,
                                        file_spec: file_path)
        puts file_path
        before(:all) do
          generator.generate
        end

        after(:all) do
          FileUtils.rm(File.expand_path('../../../FJBNotificationsViewController.h', File.dirname(__FILE__)))
          FileUtils.rm(File.expand_path('../../../FJBNotificationsViewController.m', File.dirname(__FILE__)))
          FileUtils.rm(File.expand_path('../../../FJBNotificationsViewModel.h', File.dirname(__FILE__)))
          FileUtils.rm(File.expand_path('../../../FJBNotificationsViewModel.m', File.dirname(__FILE__)))
          FileUtils.rm(File.expand_path('../../../FJBNotificationsViewModelProtocol.h', File.dirname(__FILE__)))
          FileUtils.rm(File.expand_path('../../../FJBNotificationsApiInteractor.h', File.dirname(__FILE__)))
          FileUtils.rm(File.expand_path('../../../FJBNotificationsApiInteractor.m', File.dirname(__FILE__)))
          FileUtils.rm(File.expand_path('../../../FJBNotificationsApiInteractorProtocol.h', File.dirname(__FILE__)))
        end

        it 'has to generate ViewController files' do
          file_path_header = File.expand_path('../../../FJBNotificationsViewController.h', File.dirname(__FILE__))
          file_path_impl = File.expand_path('../../../FJBNotificationsViewController.m', File.dirname(__FILE__))
          expect(File).to exist(file_path_header)
          expect(File).to exist(file_path_impl)
        end

        it 'has to generate ViewModels files' do
          file_path_header = File.expand_path('../../../FJBNotificationsViewModel.h', File.dirname(__FILE__))
          file_path_impl = File.expand_path('../../../FJBNotificationsViewModel.m', File.dirname(__FILE__))
          file_path_protocol = File.expand_path('../../../FJBNotificationsViewModelProtocol.h', File.dirname(__FILE__))
          expect(File).to exist(file_path_header)
          expect(File).to exist(file_path_impl)
          expect(File).to exist(file_path_protocol)
        end

        it 'has to generate Interactors files' do
          file_path_header = File.expand_path('../../../FJBNotificationsApiInteractor.h', File.dirname(__FILE__))
          file_path_impl = File.expand_path('../../../FJBNotificationsApiInteractor.m', File.dirname(__FILE__))
          file_path_protocol = File.expand_path('../../../FJBNotificationsApiInteractorProtocol.h', File.dirname(__FILE__))
          expect(File).to exist(file_path_header)
          expect(File).to exist(file_path_impl)
          expect(File).to exist(file_path_protocol)
        end
      end
    end

  end
end
