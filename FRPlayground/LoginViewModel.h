//
//  LoginViewModel.h
//  FRPlayground
//
//  Created by noark on 14/12/27.
//
//

#import "RVMViewModel.h"

typedef NS_OPTIONS(NSUInteger, LoginStatus) {
    LoginStatusNone = 0,
    LoginStatusLoading = 1,
    LoginStatusFinished = 2,
    LoginStatusFailed = 3,
};

@class RACSignal;
@class RACCommand;
@class DataTableViewModel;

@interface LoginViewModel : RVMViewModel

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, readonly) LoginStatus status;

@property (nonatomic, strong, readonly) RACSignal *loginButtonEnabledSignal;
@property (nonatomic, strong, readonly) RACCommand *loginCommand;
@property (nonatomic, strong, readonly) RACCommand *resetCommand;

- (DataTableViewModel *)dataTableViewModel;

@end
