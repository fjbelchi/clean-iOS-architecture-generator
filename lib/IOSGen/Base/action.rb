module IOSGen
  module Base
    # Action
    class Action
      attr_accessor :description, :name, :return_type, :arguments

      def initialize(params = {})
        @description = params[:description] ||= params['description']
        @name = params[:name] ||= params['name']
        @return_type = params[:return_type] ||= params['return_type']
        arguments = params[:arguments] ||= params['arguments']
        @arguments = []
        parse_arguments(arguments) unless arguments.nil?
      end

      private

      def parse_arguments(arguments)
        arguments.each do |property|
          if property.is_a? Property
            @arguments.push(property)
          else
            new_property = Property.new(type: property['type'],
                                        name: property['name'])
            arguments.push(new_property)
          end
        end
      end
    end
  end
end
