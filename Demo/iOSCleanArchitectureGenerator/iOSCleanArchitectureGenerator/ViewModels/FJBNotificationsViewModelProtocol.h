#import <Foundation/Foundation.h>

@protocol FJBNotificationsViewModelProtocol;
@protocol FJBNotificationsViewModelProtocolDelegate <NSObject>
@end

@protocol FJBNotificationsViewModelProtocol <NSObject>

@property (nonatomic, weak) id<FJBNotificationsViewModelProtocolDelegate> delegate;

// -- Actions
// Dismiss the ViewController when the button is tapped
- (void)didTapOnCloseButton;
// Mark notification as read when the notification is selected
- (void)didTapAtIndexPath:(NSIndexPath *)indexPath;

@end
