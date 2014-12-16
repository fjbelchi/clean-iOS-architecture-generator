module IOSGen
  module Generator
    module Objc
      # Objective-C Formatter for ViewController
      class ViewControllerFormatter
        # ViewController and ViewModel
        attr_accessor :view_controller, :view_model
        # File Names
        attr_reader :header_file_name, :impl_file_name
        def header_file_name
          "#{view_controller.name}.h"
        end

        def impl_file_name
          "#{view_controller.name}.m"
        end

        def generate(&block)
          block.call(header_file_name, 'templates/objc/UIViewController.h.erb')
          block.call(impl_file_name, 'templates/objc/UIViewController.m.erb')
        end
      end
    end
  end
end
