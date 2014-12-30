#import "FJBNotificationsViewModelProtocol.h"

@interface FJBNotificationsViewModel : NSObject <FJBNotificationsViewModelProtocol>

// -- Properties
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (nonatomic, weak) id<FJBNotificationsViewModelProtocolDelegate> delegate;

@end
