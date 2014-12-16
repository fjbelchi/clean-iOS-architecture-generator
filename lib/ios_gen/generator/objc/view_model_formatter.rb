module IOSGen
  module Generator
    module Objc
      # Objetive-C ViewModel Formatter
      class ViewModelFormatter
        # ViewModel and Interactors
        attr_accessor :view_model
        # File Names ViewModel
        attr_reader :header_file_name, :impl_file_name
        attr_reader :protocol_file_name
        # ViewModel Protocol
        attr_reader :protocol_name, :protocol_delegate
        # ViewModel Porperties
        attr_reader :properties_header
        # ViewModel Actions
        attr_reader :actions_header, :actions_impl
        # Interactor Formatter
        attr_reader :interactor_formatter

        def initialize(interactor_formatter = InteractorFormatter.new)
          @interactor_formatter = interactor_formatter
        end

        def header_file_name
          "#{@view_model.name}.h"
        end

        def impl_file_name
          "#{@view_model.name}.m"
        end

        def protocol_file_name
          "#{@view_model.name}Protocol.h"
        end

        def protocol_name
          "#{@view_model.name}Protocol"
        end

        def protocol_delegate
          "#{@view_model.name}ProtocolDelegate"
        end

        def properties_header
          properties = ''
          @view_model.properties.each do |property|
            properties += "@property (nonatomic, strong) #{property.type}#{property.name};\n"
          end
          properties.chop
        end

        def actions_header
          actions = ''
          action_formatter = ActionFormatter.new
          @view_model.actions.each do |action|
            actions += "#{action_formatter.generate_interface(action)}\n"
          end
          actions.chop
        end

        def actions_impl
          actions = ''
          action_formatter = ActionFormatter.new
          @view_model.actions.each do |action|
            actions += "#{action_formatter.generate_implementation(action)}\n"
          end
          actions.chop
        end

        def generate(&block)
          block.call(protocol_file_name, 'templates/objc/ViewModelProtocol.h.erb')
          block.call(header_file_name, 'templates/objc/ViewModel.h.erb')
          block.call(impl_file_name, 'templates/objc/ViewModel.m.erb')
          generate_interactor(&block)
        end

        private

        def generate_interactor(&block)
          @view_model.interactors.each do |interactor|
            @interactor_formatter.interactor = interactor
            @interactor_formatter.generate(&block)
          end unless @view_model.interactors.nil?
        end
      end
    end
  end
end
