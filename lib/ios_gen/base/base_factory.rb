module IOSGen
  module Base
    # Create base object from json
    class BaseFactory
      NAME_KEY = 'name'
      TYPE_KEY = 'type'
      DESCRIPTION_KEY = 'description'
      RETURN_KEY = 'return_type'
      ARGUMENTS_KEY = 'arguments'
      PROPERTIES_KEY = 'properties'
      ACTIONS_KEY = 'actions'
      INTERACTORS_KEY = 'interactors'

      def parse_property(hash)
        Property.new(type: hash[TYPE_KEY], name: hash[NAME_KEY])
      end

      def parse_action(hash)
        Action.new(description: hash[DESCRIPTION_KEY],
                   name: hash[NAME_KEY],
                   return_type: hash[RETURN_KEY],
                   arguments: parse_properties(hash[ARGUMENTS_KEY]))
      end

      def parse_interactor(hash)
        Interactor.new(description: hash[DESCRIPTION_KEY],
                       name: hash[NAME_KEY],
                       properties: parse_properties(hash[PROPERTIES_KEY]),
                       actions: parse_actions(hash[ACTIONS_KEY]))
      end

      def parse_view_model(hash)
        ViewModel.new(description: hash[DESCRIPTION_KEY],
                      name: hash[NAME_KEY],
                      properties: parse_properties(hash[PROPERTIES_KEY]),
                      actions: parse_actions(hash[ACTIONS_KEY]),
                      interactors: parse_interactors(hash[INTERACTORS_KEY]))
      end

      def parse_properties(arguments)
        return if arguments.nil?
        arguments_properties = []
        arguments.each do |property|
          arguments_properties.push(parse_property(property))
        end
        arguments_properties
      end

      def parse_actions(actions)
        return if actions.nil?
        actions_array = []
        actions.each do |action|
          actions_array.push(parse_action(action))
        end
        actions_array
      end

      def parse_interactors(interactors)
        return if interactors.nil?
        interactors_array = []
        interactors.each do |interactor|
          interactors_array.push(parse_interactor(interactor))
        end
        interactors_array
      end

      def parse_view_controller(hash)
        ViewController.new(name: hash[NAME_KEY],
                           description: hash[DESCRIPTION_KEY])
      end
    end
  end
end
