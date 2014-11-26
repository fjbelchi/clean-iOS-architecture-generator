module IOSGen
  module Base
    # ViewModel class
    class ViewModel
      attr_accessor :description, :name, :properties, :actions, :interactors

      def initialize(params = {})
        @description = params[:description] ||= params['description']
        @name = params[:name] ||= params['name']
        @properties = []
        @actions = []
        @interactors = []
        properties = params[:properties] ||= params['properties']
        actions = params[:actions] ||= params['actions']
        interactors = params[:interactors] ||= params['interactors']
        parse_optionals(properties, actions, interactors)
      end

      private

      def parse_optionals(properties, actions, interactors)
        parse_properties(properties) unless properties.nil?
        parse_actions(actions) unless actions.nil?
        parse_interactors(interactors) unless interactors.nil?
      end

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

      def parse_interactors(interactors)
        interactors.each do |interactor|
          if interactor.is_a? Interactor
            @interactors.push(interactor)
          else
            new_interactor = Interactor.new(interactor)
            @interactors.push(new_interactor)
          end
        end
      end
    end
  end
end
