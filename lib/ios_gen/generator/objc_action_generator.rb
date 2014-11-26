module IOSGen
  module Generator
    # Objective-C Action Generator
    class ObjcActionGenerator
      def generate_interface(action)
        result = ''
        result += "// #{action.description}\n" unless action.description.nil?
        result += "- (#{action.return_type})"
        result += parse_action_arguments(action) + ';'
        result
      end

      def generate_implementation(action)
        result = "- (#{action.return_type})"
        result += parse_action_arguments(action) + "\n{\n}"
        result
      end

      private

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
