module IOSGen
  module Generator
    module Objc
      # Objc Formatter
      class Formatter
        attr_accessor :view_model, :interactors
        attr_reader :view_model_header_file_name, :view_model_impl_file_name
        attr_reader :view_model_protocol_name, :view_model_protocol_delegate
        attr_reader :view_model_properties_header
        attr_reader :view_model_actions_header, :view_model_actions_impl

        def view_model_header_file_name
          puts @view_model
          "#{@view_model.name}.h"
        end

        def view_model_impl_file_name
          "#{@view_model.name}.m"
        end

        def view_model_protocol_name
          ''
        end

        def view_model_protocol_delegate
          ''
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
      end
    end
  end
end
