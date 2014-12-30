Clean iOS architecture generator
================================
[![Build Status](https://travis-ci.org/fjbelchi/clean-iOS-architecture-generator.svg)](https://travis-ci.org/fjbelchi/clean-iOS-architecture-generator)
[![Coverage Status](https://coveralls.io/repos/fjbelchi/clean-iOS-architecture-generator/badge.png)](https://coveralls.io/r/fjbelchi/clean-iOS-architecture-generator)
[![Code Climate](https://codeclimate.com/github/fjbelchi/clean-iOS-architecture-generator/badges/gpa.svg)](https://codeclimate.com/github/fjbelchi/clean-iOS-architecture-generator)
[![Gem Version](https://badge.fury.io/rb/iosgen.svg)](http://badge.fury.io/rb/iosgen)

Ruby gem to generate a clean iOS architecture based on a spec file written in json format. 
Having the following components, the gem will generate files according and it will add some logic in order to save development time.

In the [roadmap](https://github.com/fjbelchi/clean-iOS-architecture-generator/issues) there are features like estimations and creation of tickets in Github Issues and others management tools.

## Install

```shell
gem install iosgen
```

#### Execute

```shell
$ iosgen generate spec.json -t
spec/ios_gen/generator/spec.json
[+] Created Source File: FJBNotificationsViewController.h
[+] Created Source File: FJBNotificationsViewController.m
[+] Created Source File: FJBNotificationsViewModelProtocol.h
[+] Created Source File: FJBNotificationsViewModel.h
[+] Created Source File: FJBNotificationsViewModel.m
[+] Created Source File: FJBNotificationsApiInteractorProtocol.h
[+] Created Source File: FJBNotificationsApiInteractor.h
[+] Created Source File: FJBNotificationsApiInteractor.m
[+] Created Test File: FJBNotificationsViewModelTests.m
[+] Created Test File: FJBNotificationsApiInteractorTests.m
```
* Add `-t` to generate XCTest files

## Components

#### Property

The property object is composited of two strings, type and name, which repesent variables.
* type : Any Object type
* name : name of the object

```json
{
  "type": "NSIndexPath *",
  "name": "selectedIndexPath"
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

Interactor is an object which perform actions for other components. 
In this example the ViewModel needs to comunicate to the server which notification has been mark as read.

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
