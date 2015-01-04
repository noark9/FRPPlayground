//
//  DataItemViewModel.m
//  FRPlayground
//
//  Created by noark on 15/1/1.
//
//

#import "DataItemViewModel.h"
#import <ReactiveCocoa.h>

@interface DataItemViewModel ()

@property (nonatomic) NSInteger count;

@end

@implementation DataItemViewModel

- (instancetype)init
{
    if (self = [super init]) {
        [self setupViewModel];
    }
    
    return self;
}

- (void)setupViewModel
{
    _count = 0;
    self.addAction = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        self.count++;
        self.subtitle = [NSString stringWithFormat:@"you pushed add %d times", self.count];
        return [RACSignal empty];
    }];
}

@end
