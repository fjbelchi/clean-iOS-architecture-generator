module IOSGen
  module Base
    # Object Property
    class Property
      attr_accessor :type, :name

      def initialize(type, name)
        @type = type
        @name = name
      end

      def initialize(params = {})
        @type = params[:type] ||= params['type']
        @name = params[:name] ||= params['name']
      end
    end
  end
end
