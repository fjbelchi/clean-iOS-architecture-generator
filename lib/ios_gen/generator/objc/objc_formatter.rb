module IOSGen
  module Generator
    module Objc
      # Objc Formatter
      class Formatter
        # ViewModel and Interactors
        attr_accessor :view_model, :interactors
        # Formatters
        attr_reader :view_model_formatter, :interactor_formatter

        def initialize(view_model_formatter = ViewModelFormatter.new,
                       interactor_formatter = InteractorFormatter.new)
          @view_model_formatter = view_model_formatter
          @interfactor_formatter = interactor_formatter
        end

        def generate(&block)
          @view_model_formatter.view_model = view_model
          @view_model_formatter.generate(&block)
        end
      end
    end
  end
end
