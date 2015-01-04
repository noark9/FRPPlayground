//
//  DataTableViewCell.h
//  FRPlayground
//
//  Created by noark on 15/1/1.
//
//

#import <UIKit/UIKit.h>

@class DataItemViewModel;

@interface DataTableViewCell : UITableViewCell

@property (nonatomic, strong) DataItemViewModel *viewModel;

@end
