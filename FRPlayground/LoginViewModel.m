//
//  LoginViewModel.m
//  FRPlayground
//
//  Created by noark on 14/12/27.
//
//

#import "LoginViewModel.h"
#import <ReactiveCocoa.h>

@implementation LoginViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    RACSignal *usernameSignal = RACObserve(self, username);
    RACSignal *passwordSignal = RACObserve(self, password);
    
    _loginButtonEnabledSignal = [RACSignal combineLatest:@[usernameSignal, passwordSignal] reduce:^id(NSString *username, NSString *password){
        if (username.length > 0 && password.length > 0) {
            return @YES;
        } else {
            return @NO;
        }
    }];
    
    _loginCommand = [[RACCommand alloc] initWithEnabled:_loginButtonEnabledSignal signalBlock:^RACSignal *(id input) {
        NSLog(@"login action with %@/%@", _username, _password);
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
