//
//  ViewController.m
//  FRPlayground
//
//  Created by noark on 14/10/23.
//
//

#import "ViewController.h"
#import <RXCollection.h>
#import <ReactiveCocoa.h>

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UISwitch *aSwitch;

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
    
    self.button.rac_command = [[RACCommand alloc] initWithEnabled:signal signalBlock:^RACSignal *(id input) {
        NSLog(@"Push me");
        return [RACSignal empty];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPushed:(id)sender {
    NSArray *array = [@[@(1), @(2), @(3), @(4)] rx_mapWithBlock:^id(id each) {
        return @(pow([each integerValue], 2));
    }];
    RACSequence *stream = [array rac_sequence];
    NSLog(@"stream %@", stream);
    RACSequence *stream2 = [stream map:^id(id value) {
        return @([value integerValue] * 9);
    }];
    
    NSLog(@"stream after map %@", [stream2 array]);
    
    NSString *string = [stream2 foldLeftWithStart:@"left: " reduce:^id(id accumulator, id value) {
        return [accumulator stringByAppendingString:[NSString stringWithFormat:@"%d", [value integerValue]]];
    }];
    NSLog(@"%@", string);
}

@end
