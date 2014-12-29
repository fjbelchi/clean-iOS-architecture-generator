#import <UIKit/UIKit.h>
#import "FJBNotificationsViewModelProtocol.h"

@interface FJBNotificationsViewController : UIViewController

- (instancetype)initWithViewModel:(id<FJBNotificationsViewModelProtocol>)viewModel;

@end
