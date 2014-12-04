module IOSGen
  module Generator
    # Base Generator
    class BaseGenerator
      include Thor::Actions

      attr_reader :type, :file_spec, :destination
      attr_reader :view_model, :interactors
      attr_reader :formatter

      def self.source_root
        File.dirname(__FILE__)
      end

      def initialize(hash = {})
        @type = hash[:type]
        @file_spec = hash[:file_spec]
        @destination = hash[:destination]
        @formatter = Objc::Formatter.new
        parse
      end

      def generate
        template('../../../templates/objc/ViewModelProtocol.h.erb')
        template('../../../templates/objc/ViewModel.h.erb')
        template('../../../templates/objc/ViewModel.m.erb')
      end

      private

      def parse
        file = File.read(@file_spec)
        hash = JSON.parse(file)
        factory = IOSGen::Base::BaseFactory.new
        @interactors = factory.parse_interactors(hash['interactors'])
        @view_model = factory.parse_view_model(hash['view_model'])
      end
    end
  end
end
