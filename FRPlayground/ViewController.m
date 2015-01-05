//
//  ViewController.m
//  FRPlayground
//
//  Created by noark on 14/10/23.
//
//

#import "ViewController.h"
#import "DataItemViewModel.h"
#import <ReactiveCocoa.h>

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UISwitch *aSwitch;
@property (weak, nonatomic) IBOutlet UILabel *outputLabel;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;

@property (nonatomic, strong) DataItemViewModel *realItem;

@property (nonatomic, strong) DataItemViewModel *item1;
@property (nonatomic, strong) DataItemViewModel *item2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.textField.rac_textSignal subscribeNext:^(id x) {
//        NSLog(@"%@", x);
    } error:^(NSError *error) {
        NSLog(@"Error: %@", error);
    } completed:^{
        NSLog(@"Complete");
    }];
    RACSignal *signal = [self.textField.rac_textSignal map:^id(id value) {
        
        return @([value length] > 5);
    }];
    
    
    RACSignal *switchSignal = [_aSwitch.rac_newOnChannel map:^id(id value) {
        NSNumber *switchOn = value;
        if ([switchOn boolValue]) {
            return [RACEvent completedEvent];
        } else {
            return [RACEvent eventWithError:[NSError errorWithDomain:@"asdf" code:3 userInfo:nil]];
        }
    }];
    
    RACSignal *testSignal = [[self.textField.rac_textSignal takeUntil:switchSignal] combineLatestWith:switchSignal];
    [testSignal subscribeNext:^(id x) {
        NSLog(@"happen %@", x);
    }];
    
    
    RAC(self.textField, textColor) = [signal map:^id(id value) {
        if ([value boolValue]) {
            return [UIColor blueColor];
        } else {
            return [UIColor redColor];
        }
    }];
    
    RAC(_outputLabel, text) = RACObserve(self, realItem.innerItem.title);
    self.realItem = [[DataItemViewModel alloc] init];
    self.realItem.title = @"123adsf";
    self.realItem.innerItem = [[DataItemViewModel alloc] init];
    self.realItem.innerItem.title = @"adsf";
    _item1 = [[DataItemViewModel alloc] init];
    _item1.title = @"adsf";
    _item1.innerItem = [[DataItemViewModel alloc] init];
    _item1.innerItem.title = @"9999";
    _item2 = [[DataItemViewModel alloc] init];
    _item2.title = @"12";
    _item2.innerItem = [[DataItemViewModel alloc] init];
    _item2.innerItem.title = @"3434";
    
    self.button.rac_command = [[RACCommand alloc] initWithEnabled:signal signalBlock:^RACSignal *(id input) {
        NSLog(@"Push me");
        return [RACSignal empty];
    }];
    
    _button1.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        self.realItem = _item1;
        return [RACSignal empty];
    }];
    
    _button2.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        self.realItem.innerItem.title = @"dsfadsf";
        return [RACSignal empty];
    }];
    
    [self addObserver:self forKeyPath:@"realItem.innerItem.title" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"realItem.innerItem.title"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"keypath = %@, object = %@, change = %@", keyPath, object, change);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPushed:(id)sender {
}

@end
