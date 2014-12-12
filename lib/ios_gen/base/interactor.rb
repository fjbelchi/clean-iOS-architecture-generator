module IOSGen
  module Base
    # Interactor class
    class Interactor
      attr_accessor :description, :name, :properties, :actions

      def initialize(params = {})
        @description = params[:description]
        @name = params[:name]
        @properties = params[:properties]
        @actions = params[:actions]
      end
    end
  end
end
