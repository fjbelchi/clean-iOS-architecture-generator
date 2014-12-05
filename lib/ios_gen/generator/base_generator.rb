require 'erb'

module IOSGen
  module Generator
    # Base Generator
    class BaseGenerator
      attr_reader :type, :file_spec, :destination
      attr_reader :view_model, :interactors
      attr_reader :formatter

      def initialize(hash = {})
        @type = hash[:type]
        @file_spec = hash[:file_spec]
        @destination = hash[:destination]
        @formatter = Objc::Formatter.new
        parse
      end

      def generate
        generate_view_model
      #  template('../../../templates/objc/ViewModelProtocol.h.erb', "ViewModels/#{@view_model.name}/#{@view_model.name}protocol.h")
      #  template('../../../templates/objc/ViewModel.h.erb', "./ViewModels/#{@view_model.name}/#{@view_model.name}.h")
      #  template('../../../templates/objc/ViewModel.m.erb', "ViewModels/#{@view_model.name}/#{@view_model.name}.m")
      end

      private

      def parse
        file = File.read(@file_spec)
        hash = JSON.parse(file)
        factory = IOSGen::Base::BaseFactory.new
        @interactors = factory.parse_interactors(hash['interactors'])
        @view_model = factory.parse_view_model(hash['view_model'])
        @formatter.view_model = @view_model
      end

      def generate_view_model
        view_model_protocol_path = File.expand_path('templates/objc/ViewModelProtocol.h.erb')
        renderer_protocol = ERB.new(File.read(view_model_protocol_path))
        view_model_header_path = File.expand_path('templates/objc/ViewModel.h.erb')
        renderer_header = ERB.new(File.read(view_model_header_path))
        view_model_impl_path = File.expand_path('templates/objc/ViewModel.m.erb')
        renderer_impl = ERB.new(File.read(view_model_impl_path))

        File.open("#{@view_model.name}-Protocol.h", 'w') do |f|
          f.write renderer_protocol.result(binding)
        end
        File.open("#{@view_model.name}.h", 'w') do |f|
          f.write renderer_header.result(binding)
        end
        File.open("#{@view_model.name}.m", 'w') do |f|
          f.write renderer_impl.result(binding)
        end
      end
    end
  end
end
