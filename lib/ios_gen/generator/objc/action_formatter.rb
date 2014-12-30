module IOSGen
  module Generator
    module Objc
      # Objective-C Action Formatter
      class ActionFormatter
        def generate_interface(action)
          result = '' + add_description(action)
          result += "- (#{action.return_type})"
          result += parse_action_arguments(action) + ';'
          result
        end

        def generate_implementation(action)
          result = "- (#{action.return_type})"
          result += parse_action_arguments(action) + "\n{\n}"
          result
        end

        def generate_test(action)
          result = add_description(action) + "\n"
          result += '- (void)test'
          final_name = "#{action.name}".gsub(':', '')
          result += final_name + 'ShouldPass' "\n{\n"
          result += "    // given\n    // when\n    // then\n"
          result += "    XCTFail(@\"No implemented test\");\n}\n"
          result
        end

        private

        def add_description(action)
          "// #{action.description}\n" unless action.description.nil?
        end

        def parse_action_arguments(action)
          index = 0
          final_name = "#{action.name}".gsub(':') do
            argument = action.arguments[index]
            index += 1
            ":(#{argument.type})#{argument.name} "
          end
          final_name = final_name.chop if index > 0
          final_name
        end
      end
    end
  end
end
