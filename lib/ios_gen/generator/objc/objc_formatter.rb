module IOSGen
  module Generator
    module Objc
      # Objc Formatter
      class Formatter
        # ViewModel and Interactors
        attr_accessor :view_controller, :view_model, :interactors
        # Formatters
        attr_reader :view_controller_formatter, :view_model_formatter
        attr_reader :interactor_formatter

        def initialize(view_controller_formatter = ViewControllerFormatter.new,
                       view_model_formatter = ViewModelFormatter.new,
                       interactor_formatter = InteractorFormatter.new)
          @view_controller_formatter = view_controller_formatter
          @view_model_formatter = view_model_formatter
          @interfactor_formatter = interactor_formatter
        end

        def generate(&block)
          @view_controller_formatter.view_controller = @view_controller
          @view_controller_formatter.view_model = @view_model
          @view_model_formatter.view_model = @view_model
          @view_controller_formatter.generate(&block)
          @view_model_formatter.generate(&block)
        end

        def generate_test(&block)
          @view_model_formatter.generate_test(&block)
        end
      end
    end
  end
end
