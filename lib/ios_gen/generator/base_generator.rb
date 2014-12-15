require 'erb'

module IOSGen
  module Generator
    # Base Generator
    class BaseGenerator
      VIEWMODEL_KEY = 'view_model'
      INTERACTORS_KEY = 'interactors'

      attr_reader :type, :file_spec, :destination
      attr_reader :view_model, :interactors
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
        @interactors = factory.parse_interactors(hash[INTERACTORS_KEY])
        @view_model = factory.parse_view_model(hash[VIEWMODEL_KEY])
        @formatter.view_model = @view_model
      end

      def generate_view_model
        @formatter.generate do |file_name, template|
          generate_template(file_name, template)
          puts "Created #{file_name}"
        end
      end

      def generate_template(name, template, destination = '')
        path_template = File.expand_path(template)
        renderer = ERB.new(File.read(path_template))
        File.open(name, 'w') do |f|
          f.write renderer.result(binding)
        end
      end
    end
  end
end
