//
//  DataTableViewController.m
//  FRPlayground
//
//  Created by noark on 14/12/29.
//
//

#import "DataTableViewController.h"
#import "DataTableViewModel.h"
#import "DataTableViewCell.h"
#import <ReactiveCocoa.h>

static NSString *kCellIdentifier = @"DataTableViewCell";

@implementation DataTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:kCellIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kCellIdentifier];
    @weakify(self);
    [RACObserve(self, viewModel.items) subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
}

#pragma mark - tableview data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    cell.viewModel = self.viewModel.items[indexPath.row];
    return cell;
}

@end
