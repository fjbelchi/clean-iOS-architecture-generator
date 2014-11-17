Clean iOS architecture generator
================================
[![Build Status](https://travis-ci.org/fjbelchi/clean-iOS-architecture-generator.svg)](https://travis-ci.org/fjbelchi/clean-iOS-architecture-generator)
[![Coverage Status](https://coveralls.io/repos/fjbelchi/clean-iOS-architecture-generator/badge.png)](https://coveralls.io/r/fjbelchi/clean-iOS-architecture-generator)
[![Code Climate](https://codeclimate.com/github/fjbelchi/clean-iOS-architecture-generator/badges/gpa.svg)](https://codeclimate.com/github/fjbelchi/clean-iOS-architecture-generator)

Ruby gem to generate a clean iOS architecture

Example:

```
$ ./iosgen.rb screen FJB Notifications
[-] Name of ViewModel? FJBNotificationsViewModel
[-] Name API Interactor? FJBNotificationsApiInteractor
[-] Name Database Interactor? FJBNotificationsDbInteractor
[-] Name Route Interactor?
[-] Include a UITableView? [y, n] y
[-] Name of the DataSource: FJBNotificationsDataSource
      create  Interactor/Api/FJBNotificationsApiInteractorProtocol.h
      create  Interactor/Api/FJBNotificationsApiInteractor.h
      create  Interactor/Api/FJBNotificationsApiInteractor.m
      create  ViewModels/FJBNotificationsViewModel/FJBNotificationsViewModelProtocol.h
      create  ViewModels/FJBNotificationsViewModel/FJBNotificationsViewModel.h
      create  ViewModels/FJBNotificationsViewModel/FJBNotificationsViewModel.m
      create  ViewControllers/FJBNotifications/FJBNotifications.h
      create  ViewControllers/FJBNotifications/FJBNotifications.m
```

Example of Spec:

```json
{
  "screens": [
    {
      "UIViewController": {
        "ViewControlerName": "FJBNotificationViewController",
        "TableView": true,
        "Subviews": [
          {
            "Type": "FJBHeaderView",
            "Name": "headerView"
          }
        ]
      },
      "ViewModel": {
        "ViewModelName": "FJBNotificationsViewModel",
        "Properties": [
          {
            "Type": "NSIndexPath",
            "Name": "selectedIndexPath"
          }
        ],
        "Actions": [
          {
            "RetunType": "void",
            "Name": "didTapOnCloseButton"
          },
          {
            "RetunType": "void",
            "Name": "didTapAtIndexPath:",
            "Arguments": [
              {
                "Type": "NSIndexPath",
                "Name": "indexPath"
              }
            ]
          }
        ],
        "Interactors": [
          {
            "InteractorName": "FJBNotificationsApiInteractor",
            "Properties": [],
            "Actions": [
              {
                "ReturnType": "void",
                "Name": "markNotificationAsRead:onCompletionBlock:",
                "Arguments": [
                  {
                    "Type": "NSString",
                    "Name": "notificationsId"
                  },
                  {
                    "Type": "^()",
                    "Name": "completionBlock"
                  }
                ]
              }
            ]
          }
        ]
      }
    }
  ]
}
```
