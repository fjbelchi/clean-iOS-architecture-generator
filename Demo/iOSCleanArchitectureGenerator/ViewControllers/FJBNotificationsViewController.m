#import "FJBNotificationsViewController.h"

@interface FJBNotificationsViewController () <FJBNotificationsViewModelProtocolDelegate>

@property (nonatomic, strong) id<FJBNotificationsViewModelProtocol> viewModel;

@end

@implementation FJBNotificationsViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (instancetype)initWithViewModel:(id<FJBNotificationsViewModelProtocol>)viewModel
{
    self = [self init];
    if (self) {
        _viewModel = viewModel;
        _viewModel.delegate = self;
    }
    return self;
}

#pragma mark - FJBNotificationsViewModelProtocolDelegate

@end
