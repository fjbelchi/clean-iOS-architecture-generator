module IOSGen
  module Base
    # Action
    class Action
      attr_accessor :description, :name, :return_type, :arguments

      def initialize(params = {})
        @description = params[:description] ||= params['description']
        @name = params[:name] ||= params['name']
        @return_type = params[:return_type] ||= params['return_type']
        @arguments = params[:arguments] ||= params['arguments']
      end
    end
  end
end
