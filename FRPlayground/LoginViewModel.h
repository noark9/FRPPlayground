//
//  LoginViewModel.h
//  FRPlayground
//
//  Created by noark on 14/12/27.
//
//

#import "RVMViewModel.h"

@class RACSignal;
@class RACCommand;

@interface LoginViewModel : RVMViewModel

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong, readonly) RACSignal *loginFinishedSignal;

@property (nonatomic, strong, readonly) RACSignal *loginButtonEnabledSignal;
@property (nonatomic, strong, readonly) RACCommand *loginCommand;
@property (nonatomic, strong, readonly) RACCommand *resetCommand;

@end
