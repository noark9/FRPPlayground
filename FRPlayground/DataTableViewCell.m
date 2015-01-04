//
//  DataTableViewCell.m
//  FRPlayground
//
//  Created by noark on 15/1/1.
//
//

#import <ReactiveCocoa.h>
#import "DataTableViewCell.h"
#import "DataItemViewModel.h"

@interface DataTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *addCountButton;

@end

@implementation DataTableViewCell

- (void)awakeFromNib {
    
    // Initialization code
    RAC(_titleLabel, text) = RACObserve(self, viewModel.title);
    RAC(_subtitleLabel, text) = RACObserve(self, viewModel.subtitle);
    RAC(_addCountButton, rac_command) = RACObserve(self, viewModel.addAction);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
