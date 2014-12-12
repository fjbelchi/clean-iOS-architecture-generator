module IOSGen
  module Generator
    module Objc
      # Objc Formatter
      class Formatter
        # ViewModel and Interactors
        attr_accessor :view_model, :interactors, :interactor
        # File Names ViewModel
        attr_reader :view_model_header_file_name, :view_model_impl_file_name
        attr_reader :view_model_protocol_file_name
        # File Names Interactors
        attr_reader :interactor_header_file_name, :interactor_impl_file_name
        attr_reader :interactor_protocol_file_name
        # ViewModel Protocol
        attr_reader :view_model_protocol_name, :view_model_protocol_delegate
        # ViewModel Porperties
        attr_reader :view_model_properties_header
        # ViewModel Actions
        attr_reader :view_model_actions_header, :view_model_actions_impl
        # Interactor Protocol
        attr_reader :interactor_protocol_name
        # Interactor Porperties
        attr_reader :interactor_properties_header
        # Interactor Actions
        attr_reader :interactor_actions_header, :interactor_actions_impl

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

        def interactor_protocol_name
          "#{@interactor.name}Protocol"
        end

        def interactor_properties_header
          properties = ''
          @interactor.properties.each do |property|
            properties += "@property (nonatomic, strong) #{property.type}#{property.name};\n"
          end
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

        def generate_view_model(&block)
          block.call(view_model_protocol_file_name, 'templates/objc/ViewModelProtocol.h.erb')
          block.call(view_model_header_file_name, 'templates/objc/ViewModel.h.erb')
          block.call(view_model_impl_file_name, 'templates/objc/ViewModel.m.erb')
          @view_model.interactors.each do |interactor|
            generate_interactor(interactor, &block)
          end
        end

        def generate_interactor(interactor, &block)
          @interactor = interactor
          @interactor_protocol_file_name = "#{interactor.name}Protocol.h"
          @interactor_header_file_name = "#{interactor.name}.h"
          @interactor_impl_file_name = "#{interactor.name}.m"
          block.call(@interactor_protocol_file_name, 'templates/objc/InteractorProtocol.h.erb')
          block.call(@interactor_header_file_name, 'templates/objc/Interactor.h.erb')
          block.call(@interactor_impl_file_name, 'templates/objc/Interactor.m.erb')
        end
      end
    end
  end
end
