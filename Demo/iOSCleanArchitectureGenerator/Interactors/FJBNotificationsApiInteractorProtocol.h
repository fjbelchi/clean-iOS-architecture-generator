#import <Foundation/Foundation.h>

@protocol FJBNotificationsApiInteractorProtocol <NSObject>

// -- Actions
// Perform API request to mark a notification as read
- (void)markNotificationAsRead:(NSString *)notificationId onCompletionBlock:(void(^)())completionBlock;

@end
