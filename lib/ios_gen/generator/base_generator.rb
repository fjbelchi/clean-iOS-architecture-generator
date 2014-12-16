require 'erb'

module IOSGen
  module Generator
    # Base Generator
    class BaseGenerator
      VIEWCONTROLLER_KEY = 'view_controller'
      VIEWMODEL_KEY = 'view_model'
      INTERACTORS_KEY = 'interactors'

      attr_reader :type, :file_spec, :destination
      attr_reader :view_model, :view_controller
      attr_reader :formatter

      def initialize(hash = {})
        @type = hash[:type]
        @file_spec = hash[:file_spec]
        @destination = hash[:destination]
        interactor_formatter = Objc::InteractorFormatter.new
        view_model_formatter = Objc::ViewModelFormatter.new(interactor_formatter)
        @formatter = Objc::Formatter.new(view_model_formatter, interactor_formatter)
        parse
      end

      def generate
        generate_view_model
      end

      private

      def parse
        file = File.read(@file_spec)
        hash = JSON.parse(file)
        factory = IOSGen::Base::BaseFactory.new
        @view_model = factory.parse_view_model(hash[VIEWMODEL_KEY])
        @view_controller = factory.parse_view_controller(hash[VIEWCONTROLLER_KEY])
        @formatter.view_model = @view_model
        @formatter.view_controller = @view_controller
      end

      def generate_view_model
        @formatter.generate do |file_name, template|
          generate_template(file_name, template, @destination)
          puts "Created #{file_name}"
        end
      end

      def generate_template(name, template, destination = '.')
        path_template = File.expand_path("../../../#{template}", File.dirname(__FILE__))
        renderer = ERB.new(File.read(path_template))
        destination_path = "#{destination}#{name}"
        File.open(destination_path, 'w') do |f|
          f.write renderer.result(binding)
        end
      end
    end
  end
end
