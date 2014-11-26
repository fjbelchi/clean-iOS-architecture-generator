module IOSGen
  module Base
    # Object Property
    class Property
      attr_accessor :type, :name

      def initialize(params = {})
        @type = params[:type] ||= params['type']
        @name = params[:name] ||= params['name']
      end
    end
  end
end
