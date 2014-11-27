module IOSGen
  module Base
    # ViewModel class
    class ViewModel
      attr_accessor :description, :name, :properties, :actions, :interactors

      def initialize(params = {})
        @description = params[:description]
        @name = params[:name]
        @properties = params[:properties]
        @actions = params[:actions]
        @interactors = params[:interactors]
      end
    end
  end
end
