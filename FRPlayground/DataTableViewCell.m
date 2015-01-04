//
//  DataTableViewCell.m
//  FRPlayground
//
//  Created by noark on 15/1/1.
//
//

#import "DataTableViewCell.h"

@interface DataTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *addCountButton;


@end

@implementation DataTableViewCell

- (void)awakeFromNib {
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
