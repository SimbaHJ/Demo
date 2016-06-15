//
//  reteatTextField.m
//  reteatText
//
//  Created by apple on 16/4/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "reteatTextField.h"

@implementation reteatTextField


-(instancetype)initWithFrame:(CGRect)frame

{
    self = [super initWithFrame:frame];
    if (self) {
        self.placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, frame.size.height/2-15, frame.size.width/2-30, 30)];
        self.placeholderLabel.textColor = [UIColor colorWithWhite:0.702 alpha:1.000];
        self.placeholderLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.placeholderLabel];
    }
    return self;
}








@end
