module IOSGen
  module Generator
    module Objc
      # Objc Formatter
      class Formatter
        # ViewModel and Interactors
        attr_accessor :view_model, :interactors
        # File Names
        attr_reader :view_model_header_file_name, :view_model_impl_file_name
        attr_reader :view_model_protocol_file_name
        # ViewModel Protocol
        attr_reader :view_model_protocol_name, :view_model_protocol_delegate
        # ViewModel Porperties
        attr_reader :view_model_properties_header
        # ViewModel Actions
        attr_reader :view_model_actions_header, :view_model_actions_impl

        def view_model_header_file_name
          "#{@view_model.name}.h"
        end

        def view_model_impl_file_name
          "#{@view_model.name}.m"
        end

        def view_model_protocol_file_name
          "#{@view_model.name}Protocol.h"
        end

        def view_model_protocol_name
          "#{@view_model.name}Protocol"
        end

        def view_model_protocol_delegate
          "#{@view_model.name}ProtocolDelegate"
        end

        def view_model_properties_header
          properties = ''
          @view_model.properties.each do |property|
            properties += "@property (nonatomic, strong) #{property.type}#{property.name};\n"
          end
          properties.chop
        end

        def view_model_actions_header
          actions = ''
          action_formatter = ActionFormatter.new
          @view_model.actions.each do |action|
            actions += "#{action_formatter.generate_interface(action)}\n"
          end
          actions.chop
        end

        def view_model_actions_impl
          actions = ''
          action_formatter = ActionFormatter.new
          @view_model.actions.each do |action|
            actions += "#{action_formatter.generate_implementation(action)}\n"
          end
          actions.chop
        end

        def generate_view_model
          yield(view_model_protocol_file_name, 'templates/objc/ViewModelProtocol.h.erb')
          yield(view_model_header_file_name, 'templates/objc/ViewModel.h.erb')
          yield(view_model_impl_file_name, 'templates/objc/ViewModel.m.erb')
        end
      end
    end
  end
end
