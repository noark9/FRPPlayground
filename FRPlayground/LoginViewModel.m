//
//  LoginViewModel.m
//  FRPlayground
//
//  Created by noark on 14/12/27.
//
//

#import "LoginViewModel.h"
#import "DataTableViewModel.h"
#import <ReactiveCocoa.h>

@interface LoginViewModel ()

@property (nonatomic) BOOL isLoading;

@end

@implementation LoginViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setStatus:(LoginStatus)status
{
    _status = status;
}

- (DataTableViewModel *)dataTableViewModel
{
    DataTableViewModel *dataTableViewModel = [[DataTableViewModel alloc] init];
    return dataTableViewModel;
}

- (void)setup
{
    RACSignal *usernameSignal = RACObserve(self, username);
    RACSignal *passwordSignal = RACObserve(self, password);
    self.status = LoginStatusNone;
    
    _loginButtonEnabledSignal = [RACSignal combineLatest:@[usernameSignal, passwordSignal] reduce:^id(NSString *username, NSString *password){
        if (username.length > 0 && password.length > 0) {
            return @YES;
        } else {
            return @NO;
        }
    }];
    
    _loginCommand = [[RACCommand alloc] initWithEnabled:_loginButtonEnabledSignal signalBlock:^RACSignal *(id input) {
        self.status = LoginStatusLoading;
        NSLog(@"login action with %@/%@", _username, _password);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.status = LoginStatusFinished;
        });
        return [RACSignal empty];
    }];
    
    @weakify(self);
    _resetCommand = [[RACCommand alloc] initWithEnabled:[RACSignal combineLatest:@[usernameSignal, passwordSignal] reduce:^id(NSString *username, NSString *password) {
        return @((username.length + password.length) > 0);
    }] signalBlock:^RACSignal *(id input) {
        @strongify(self);
        self.username = @"";
        self.password = @"";
        return [RACSignal empty];
    }];
}

@end
