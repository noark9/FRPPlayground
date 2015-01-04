//
//  DataItemViewModel.h
//  FRPlayground
//
//  Created by noark on 15/1/1.
//
//

#import "RVMViewModel.h"

@interface DataItemViewModel : RVMViewModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) DataItemViewModel *innerItem;

@end
