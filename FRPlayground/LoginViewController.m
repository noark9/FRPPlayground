//
//  LoginViewController.m
//  FRPlayground
//
//  Created by noark on 14/12/27.
//
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
#import <ReactiveCocoa.h>

@interface LoginViewController ()

@property (nonatomic, weak) IBOutlet UITextField *usernameTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;
@property (nonatomic, weak) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;

@property (nonatomic, strong) LoginViewModel *viewModel;

@end

@implementation LoginViewController

#pragma mark - view life circle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViewModel];
}

#pragma mark - view model bind

- (void)setupViewModel
{
    _viewModel = [[LoginViewModel alloc] init];
    RACChannelTerminal *usernameModelTerminal = RACChannelTo(_viewModel, username);
    RACChannelTerminal *usernameTextFieldTerminal = _usernameTextField.rac_newTextChannel;
    [usernameModelTerminal subscribe:usernameTextFieldTerminal];
    [usernameTextFieldTerminal subscribe:usernameModelTerminal];
    
    RACChannelTerminal *passwordModelTerminal = RACChannelTo(_viewModel, password);
    RACChannelTerminal *passwordTextFieldTerminal = _passwordTextField.rac_newTextChannel;
    [passwordModelTerminal subscribe:passwordTextFieldTerminal];
    [passwordTextFieldTerminal subscribe:passwordModelTerminal];
    
    RAC(_loginButton, rac_command) = RACObserve(_viewModel, loginCommand);
    RAC(_resetButton, rac_command) = RACObserve(_viewModel, resetCommand);
}

@end
