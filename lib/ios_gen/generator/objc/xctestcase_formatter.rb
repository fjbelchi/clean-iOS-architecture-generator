module IOSGen
  module Generator
    module Objc
      # Objetive-C XCTestCase Formatter
      class XctestcaseFormatter
        attr_accessor :object
        attr_reader :file_name, :name, :actions_impl
        attr_reader :class_test_name

        def file_name
          "#{@object.name}Tests.m" if @object.respond_to?(:name)
        end

        def name
          "#{@object.name}Tests" if @object.respond_to?(:name)
        end

        def actions_impl
          loop_actions do |formatter, action|
            formatter.generate_test(action)
          end if @object.respond_to?(:actions)
        end

        def class_test_name
          "#{@object.name}.h" if @object.respond_to?(:name)
        end

        def generate(&block)
          block.call(file_name, 'templates/objc/XCTestCase.m.erb')
        end

        private

        def loop_actions
          actions = ''
          action_formatter = ActionFormatter.new
          @object.actions.each do |action|
            actions += "#{yield(action_formatter, action)}\n"
          end
          actions.chop
        end
      end
    end
  end
end
