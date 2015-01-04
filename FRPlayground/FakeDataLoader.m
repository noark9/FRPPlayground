//
//  FakeDataLoader.m
//  FRPlayground
//
//  Created by noark on 15/1/4.
//
//

#import "FakeDataLoader.h"
#import <ReactiveCocoa.h>
#import "DataItemViewModel.h"

@interface FakeDataLoader ()

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation FakeDataLoader

- (instancetype)init
{
    if (self = [super init]) {
        _items = [[NSArray alloc] init];
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(timer, ^{
            NSMutableArray *newItems = [[NSMutableArray alloc] init];
            for (int i = 0; i < 10; i++) {
                DataItemViewModel *data = [[DataItemViewModel alloc] init];
                data.title = [NSString stringWithFormat:@"Title %d", i];
                [newItems addObject:data];
            }
            self.items = [self.items arrayByAddingObjectsFromArray:newItems];
        });
        dispatch_resume(timer);
        _timer = timer;
    }
    return self;
}

- (RACSignal *)loadedDatas
{
    return [RACObserve(self, items) deliverOn:[RACScheduler mainThreadScheduler]];
}

@end
