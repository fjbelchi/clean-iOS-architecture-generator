module IOSGen
  module Base
    # ViewController Model
    class ViewController
      attr_reader :name, :description
      attr_accessor :view_model

      def initialize(params = {})
        @name = params[:name]
        @description = params[:description]
        @view_model = params[:view_model]
      end
    end
  end
end
