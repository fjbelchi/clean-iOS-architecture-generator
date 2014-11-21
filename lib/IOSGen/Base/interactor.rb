module IOSGen
  module Base
    # Interactor class
    class Interactor
      attr_accessor :description, :name, :properties, :actions

      def initialize(params = {})
        @description = params[:description] ||= params['description']
        @name = params[:name] ||= params['name']
        @properties = Array.new
        @actions = Array.new
        parse_properties(params[:properties] ||= params['properties'])
        parse_actions(params[:actions] ||= params['actions'])
      end

      private

      def parse_properties(properties)
        properties.each do |property|
          if property.is_a? Property
            @properties.push(property)
          else
            new_property = Property.new(property)
            @properties.push(new_property)
          end
        end
      end

      def parse_actions(actions)
        actions.each do |action|
          if action.is_a? Action
            @actions.push(action)
          else
            new_action = Action.new(action)
            @actions.push(new_action)
          end
        end
      end
    end
  end
end
