module IOSGen
  module Generator
    module Objc
      # Objective-C Interactor Formatter
      class InteractorFormatter
        # File Names Interactors
        attr_reader :interactor_header_file_name, :interactor_impl_file_name
        attr_reader :interactor_protocol_file_name
        # Interactor Protocol
        attr_reader :interactor_protocol_name
        # Interactor Porperties
        attr_reader :interactor_properties_header
        # Interactor Actions
        attr_reader :interactor_actions_header, :interactor_actions_impl
        # Property
        attr_accessor :interactor

        def interactor_header_file_name
          "#{@interactor.name}.h"
        end

        def interactor_impl_file_name
          "#{@interactor.name}.m"
        end

        def interactor_protocol_file_name
          "#{@interactor.name}Protocol.h"
        end

        def interactor_protocol_name
          "#{@interactor.name}Protocol"
        end

        def interactor_properties_header
          properties = ''
          @interactor.properties.each do |property|
            properties += "@property (nonatomic, strong) #{property.type}#{property.name};\n"
          end unless @interactor.properties.nil?
          properties.chop
        end

        def interactor_actions_header
          actions = ''
          action_formatter = ActionFormatter.new
          @interactor.actions.each do |action|
            actions += "#{action_formatter.generate_interface(action)}\n"
          end
          actions.chop
        end

        def interactor_actions_impl
          actions = ''
          action_formatter = ActionFormatter.new
          @interactor.actions.each do |action|
            actions += "#{action_formatter.generate_implementation(action)}\n"
          end
          actions.chop
        end

        def generate(&block)
          block.call(interactor_protocol_file_name, 'templates/objc/InteractorProtocol.h.erb')
          block.call(interactor_header_file_name, 'templates/objc/Interactor.h.erb')
          block.call(interactor_impl_file_name, 'templates/objc/Interactor.m.erb')
        end
      end
    end
  end
end
