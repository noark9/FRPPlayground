//
//  FakeDataLoader.h
//  FRPlayground
//
//  Created by noark on 15/1/4.
//
//

#import <Foundation/Foundation.h>

@class RACSignal;

@interface FakeDataLoader : NSObject

- (RACSignal *)loadedDatas;

@end
