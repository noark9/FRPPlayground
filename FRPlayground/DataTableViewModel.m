//
//  DataTableViewModel.m
//  FRPlayground
//
//  Created by noark on 14/12/29.
//
//

#import "DataTableViewModel.h"
#import "FakeDataLoader.h"
#import <ReactiveCocoa.h>

@interface DataTableViewModel ()

@property (nonatomic, strong) FakeDataLoader *dataLoader;

@end

@implementation DataTableViewModel

- (instancetype)init
{
    if (self = [super init]) {
        _dataLoader = [[FakeDataLoader alloc] init];
        RAC(self, items) = _dataLoader.loadedDatas;
    }
    
    return self;
}

@end
