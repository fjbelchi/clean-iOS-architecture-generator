#import "FJBNotificationsApiInteractorProtocol.h"

@interface FJBNotificationsApiInteractor : NSObject <FJBNotificationsApiInteractorProtocol>

// -- Actions
// Perform API request to mark a notification as read
- (void)markNotificationAsRead:(NSString *)notificationId onCompletionBlock:(void(^)())completionBlock;

@end
