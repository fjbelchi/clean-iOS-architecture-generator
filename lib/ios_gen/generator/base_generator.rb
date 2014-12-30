require 'erb'
require 'colorize'

module IOSGen
  module Generator
    # Base Generator
    class BaseGenerator
      VIEWCONTROLLER_KEY = 'view_controller'
      VIEWMODEL_KEY = 'view_model'
      INTERACTORS_KEY = 'interactors'

      attr_reader :type, :file_spec, :destination
      attr_reader :view_model, :view_controller
      attr_reader :factory, :formatter, :test_formatter

      def initialize(hash = {})
        @type = hash[:type]
        @file_spec = hash[:file_spec]
        @destination = hash[:destination]
        @factory = IOSGen::Base::BaseFactory.new
        interactor_formatter = Objc::InteractorFormatter.new
        view_model_formatter = Objc::ViewModelFormatter.new(interactor_formatter)
        view_controller_formatter = Objc::ViewControllerFormatter.new(view_model_formatter)
        @formatter = Objc::Formatter.new(view_controller_formatter, view_model_formatter, interactor_formatter)
        @test_formatter = Objc::XctestcaseFormatter.new
        parse
      end

      def generate
        @formatter.generate do |file_name, template|
          generate_template(file_name, template, @destination)
          puts "[+] Created Source File: #{file_name}".green
        end
      end

      def generate_test
        generate_test_object(@view_model)
        @view_model.interactors.each do |interactor|
          generate_test_object(interactor)
        end
      end

      private

      def parse
        file = File.read(@file_spec)
        hash = JSON.parse(file)
        @view_model = @factory.parse_view_model(hash[VIEWMODEL_KEY])
        @view_controller = @factory.parse_view_controller(hash[VIEWCONTROLLER_KEY])
        @view_controller.view_model = @view_model unless @view_controller.nil?
        @formatter.view_model = @view_model unless @view_model.nil?
        @formatter.view_controller = @view_controller unless @view_controller.nil?
      end

      def generate_template(name, template, destination = '.')
        path_template = File.expand_path("../../../#{template}", File.dirname(__FILE__))
        renderer = ERB.new(File.read(path_template))
        destination_path = "#{destination}#{name}"
        File.open(destination_path, 'w') do |f|
          f.write renderer.result(binding)
        end
      end

      def generate_test_object(object)
        @test_formatter.object = object
        @test_formatter.generate do |file_name, template|
          generate_template(file_name, template, @destination)
          puts "[+] Created Test File: #{file_name}".green
        end
      end
    end
  end
end
