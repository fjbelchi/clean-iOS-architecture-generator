Clean iOS architecture generator
================================
[![Build Status](https://travis-ci.org/fjbelchi/clean-iOS-architecture-generator.svg)](https://travis-ci.org/fjbelchi/clean-iOS-architecture-generator)
[![Coverage Status](https://coveralls.io/repos/fjbelchi/clean-iOS-architecture-generator/badge.png)](https://coveralls.io/r/fjbelchi/clean-iOS-architecture-generator)
[![Code Climate](https://codeclimate.com/github/fjbelchi/clean-iOS-architecture-generator/badges/gpa.svg)](https://codeclimate.com/github/fjbelchi/clean-iOS-architecture-generator)

Ruby script to generate a clean iOS architecture based on a spec file written in json format. 
Having the following components, the script will generate files according and it will add some logic in order to save development time.

In the roadmap there are features like estimations and creation of tickets in Github Issues and others management tools.

Working in progress project

## Components

#### Property
```json
{
  "Type": "NSIndexPath *",
  "Name": "selectedIndexPath"
}
```

#### Action
```json
{
  "description": "Dismiss the ViewController when the button is tapped",
  "return_type": "void",
  "name": "didTapOnCloseButton:",
  "arguments": [{
    "type" : "UIButton *",
    "name" : "closeButton"
    }]
}
```

#### Interactor
```json
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
          "type": "NSString *",
          "name": "notificationId"
        },
        {
          "type": "void(^)()",
          "name": "completionBlock"
        }
      ]
    }
  ]
}
```

#### ViewModel
```json
{
  "description" : "State of NotificationViewController and perform bussiness logic",
  "name": "FJBNotificationsViewModel",
  "properties": [],
  "actions": [],
  "interactors": []
}
```

#### UIViewController
```json
  "view_controller": {
    "description": "ViewController to show the list of notifications",
    "name": "FJBNotificationsViewController"
  }
```

#### Example of Spec.json

```json
{
  "view_controller": {
    "description": "ViewController to show the list of notifications", 
    "name": "FJBNotificationViewController",
    "view_model": {
      "description" : "State of NotificationViewController and perform bussiness logic",
      "name": "FJBNotificationsViewModel",
      "properties": [
        {
          "type": "NSIndexPath *",
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
              "type": "NSIndexPath *",
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
                  "type": "NSString *",
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
    }
  }
}
```

#### Output
```shell
$ ./iosgen.rb spec ../spec/ios_gen/generator/spec.json
../spec/ios_gen/generator/spec.json
[+] Created FJBNotificationsViewController.h
[+] Created FJBNotificationsViewController.m
[+] Created FJBNotificationsViewModelProtocol.h
[+] Created FJBNotificationsViewModel.h
[+] Created FJBNotificationsViewModel.m
[+] Created FJBNotificationsApiInteractorProtocol.h
[+] Created FJBNotificationsApiInteractor.h
[+] Created FJBNotificationsApiInteractor.m

```
