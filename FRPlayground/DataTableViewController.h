//
//  DataTableViewController.h
//  FRPlayground
//
//  Created by noark on 14/12/29.
//
//

#import <UIKit/UIKit.h>

@class DataTableViewModel;

@interface DataTableViewController : UITableViewController

@property (nonatomic, strong) DataTableViewModel *viewModel;

@end
