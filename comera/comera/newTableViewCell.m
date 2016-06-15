//
//  newTableViewCell.m
//  comera
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "newTableViewCell.h"

@implementation newTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.headimage = [[UIImageView alloc] init];
        self.headimage.frame = CGRectMake(0, 0, 100, 100);
        self.headimage.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.headimage];
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
