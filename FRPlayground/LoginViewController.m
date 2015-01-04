//
//  LoginViewController.m
//  FRPlayground
//
//  Created by noark on 14/12/27.
//
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
#import "DataTableViewController.h"
#import <ReactiveCocoa.h>

@interface LoginViewController ()

@property (nonatomic, weak) IBOutlet UITextField *usernameTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;
@property (nonatomic, weak) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *loadingContainerView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingActivityIndicatorView;

@property (nonatomic, strong) LoginViewModel *viewModel;

@end

@implementation LoginViewController

#pragma mark - view life circle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViewModel];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _viewModel.active = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    _viewModel.active = NO;
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
    RACSignal *loginSignal = RACObserve(_viewModel, status);
    [loginSignal subscribeNext:^(id x) {
        LoginStatus status = [x unsignedIntegerValue];
        switch (status) {
            case LoginStatusNone:
            case LoginStatusFailed:
            case LoginStatusFinished:
                self.loadingContainerView.hidden = YES;
                [self.loadingActivityIndicatorView stopAnimating];
                [self performSegueWithIdentifier:@"Go2Next" sender:nil];
                break;
            case LoginStatusLoading:
                self.loadingContainerView.hidden = NO;
                [self.loadingActivityIndicatorView startAnimating];
                break;
            default:
                break;
        }
    }];
}

#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Go2Next"]) {
        DataTableViewController *dest = segue.destinationViewController;
        dest.viewModel = self.viewModel.dataTableViewModel;
    }
}

@end
