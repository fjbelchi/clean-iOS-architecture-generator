Clean iOS architecture generator
================================
[![Build Status](https://travis-ci.org/fjbelchi/clean-iOS-architecture-generator.svg)](https://travis-ci.org/fjbelchi/clean-iOS-architecture-generator)
[![Coverage Status](https://coveralls.io/repos/fjbelchi/clean-iOS-architecture-generator/badge.png)](https://coveralls.io/r/fjbelchi/clean-iOS-architecture-generator)
[![Code Climate](https://codeclimate.com/github/fjbelchi/clean-iOS-architecture-generator/badges/gpa.svg)](https://codeclimate.com/github/fjbelchi/clean-iOS-architecture-generator)

Ruby gem to generate a clean iOS architecture

Example of Spec:

```json
{
  "screens": [
    {
      "view_controller": {
        "name": "FJBNotificationViewController",
        "tableView": true,
        "subviews": [
          {
            "type": "FJBHeaderView",
            "name": "headerView"
          }
        ]
      },
      "view_model": {
        "description": "State of NotificationViewController and perform bussiness logic",
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
            "description": "Api Interactions required by Notification ViewModel",
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
      }
    }
  ]
}
```
