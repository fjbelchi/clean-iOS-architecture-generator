module IOSGen
  module Generator
    module Objc
      # Objective-C Interactor Formatter
      class InteractorFormatter
        # File Names Interactors
        attr_reader :header_file_name, :impl_file_name
        attr_reader :protocol_file_name
        # Interactor Protocol
        attr_reader :protocol_name
        # Interactor Porperties
        attr_reader :properties_header
        # Interactor Actions
        attr_reader :actions_header, :actions_impl
        # Property
        attr_accessor :interactor

        def header_file_name
          "#{@interactor.name}.h"
        end

        def impl_file_name
          "#{@interactor.name}.m"
        end

        def protocol_file_name
          "#{@interactor.name}Protocol.h"
        end

        def protocol_name
          "#{@interactor.name}Protocol"
        end

        def properties_header
          properties = ''
          @interactor.properties.each do |property|
            properties += "@property (nonatomic, strong) #{property.type}#{property.name};\n"
          end unless @interactor.properties.nil?
          properties.chop
        end

        def actions_header
          loop_actions do |formatter, action|
            formatter.generate_interface(action)
          end
        end

        def actions_impl
          loop_actions do |formatter, action|
            formatter.generate_implementation(action)
          end
        end

        def generate(&block)
          block.call(protocol_file_name, 'templates/objc/InteractorProtocol.h.erb')
          block.call(header_file_name, 'templates/objc/Interactor.h.erb')
          block.call(impl_file_name, 'templates/objc/Interactor.m.erb')
        end

        private

        def loop_actions
          actions = ''
          action_formatter = ActionFormatter.new
          @interactor.actions.each do |action|
            actions += "#{yield(action_formatter, action)}\n"
          end
          actions.chop
        end
      end
    end
  end
end
