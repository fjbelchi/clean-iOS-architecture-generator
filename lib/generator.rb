require 'thor/group'
require 'json'
require_relative 'ios_gen/base/view_model'
require_relative 'ios_gen/base/property'
require_relative 'ios_gen/base/action'
require_relative 'ios_gen/base/interactor'

class Generator < Thor::Group
  include Thor::Actions
  # Define arguments and options
  argument :prefix
  argument :name

  def self.source_root
    File.dirname(__FILE__)
  end

  def ask_viewmodel_properties
    # ask for ViewModel

    json = '{
    "description" : "State of NotificationViewController and perform bussiness logic",
    "name": "FJBNotificationsViewModel",
    "properties": [
      {
        "type": "NSIndexPath",
        "name": "selectedIndexPath"
      }
    ],
    "actions": [
      {
        "description": "Dismiss the ViewController when the button is tapped",
        "return_type": "void",
        "name": "didTapOnCloseButton"
      },
      {
        "description": "Mark notification as read when the notification is selected",
        "return_type": "void",
        "name": "didTapAtIndexPath:",
        "arguments": [
          {
            "type": "NSIndexPath",
            "name": "indexPath"
          }
        ]
      }
    ],
    "interactors": [
      {
        "description" : "Api Interactions required by Notification ViewModel",
        "name": "FJBNotificationsApiInteractor",
        "properties": [],
        "actions": [
          {
            "description": "Perform API request to mark a notification as read",
            "return_type": "void",
            "name": "markNotificationAsRead:onCompletionBlock:",
            "arguments": [
              {
                "type": "NSString",
                "name": "notificationId"
              },
              {
                "type": "^()",
                "name": "completionBlock"
              }
            ]
          }
        ]
      }
    ]
    }'

    hash = JSON.parse(json)
    @view_model = IOSGen::Base::ViewModel.new(hash)

    @viewmodel_name = @view_model.name
    @viewmodel_protocol_name = "#{@viewmodel_name}" + 'Protocol'
    @viewmodel_protocol_delegate = "#{@viewmodel_protocol_name}" + 'Delegate'

    # @viewmodel_name = ask('[-] Name of ViewModel?')
    # @viewmodel_protocol_name = "#{@viewmodel_name}" + 'Protocol'
    # @viewmodel_protocol_delegate = "#{@viewmodel_protocol_name}" + 'Delegate'
  end

  def ask_interactors_properties
    # does the viewModel include api interactor?
    # @api_interactor = ask('[-] Name API Interactor?')
    # @api_protocol_name = "#{@api_interactor}" + 'Protocol'
    # @db_interactor = ask('[-] Name Database Interactor?')
    # @route_interactor = ask('[-] Name Route Interactor?')
  end

  def ask_viewcontroller_properties
    # @viewcontroller_name = "#{prefix}#{name}"
    # @table_view = ask('[-] Include a UITableView?',
    #                  limited_to: %w(y n)) == 'y' ? true : false
    # @data_source = ask('[-] Name of the DataSource:') if @table_view
  end

  def generate_templates
    # generate interactor templates
    # if !@api_interactor.empty?
    #  template('templates/ApiInteractorProtocol.h.erb',
    #  "Interactor/Api/#{@api_protocol_name}.h")
    #  template('templates/ApiInteractor.h.erb',
    #  "Interactor/Api/#{@api_interactor}.h")
    #  template('templates/ApiInteractor.m.erb',
    #  "Interactor/Api/#{@api_interactor}.m")
    # end
    # generate view model templates
    template('../templates/objc/ViewModelProtocol.h.erb',"ViewModels/#{@viewmodel_name}/#{@viewmodel_protocol_name}.h")
    template('../templates/objc/ViewModel.h.erb',"ViewModels/#{@viewmodel_name}/#{@viewmodel_name}.h")
    template('../templates/objc/ViewModel.m.erb',"ViewModels/#{@viewmodel_name}/#{@viewmodel_name}.m")
    # generate view controllers templates
    # template('templates/objc/UIViewController.h.erb',"ViewControllers/#{@viewcontroller_name}/#{@viewcontroller_name}.h")
    # template('templates/objc/UIViewController.m.erb',"ViewControllers/#{@viewcontroller_name}/#{@viewcontroller_name}.m")
  end

end
