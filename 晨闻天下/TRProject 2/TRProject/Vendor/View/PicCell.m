//
//  PicCell.m
//  TRProject
//
//  Created by 钟至大 on 16/8/22.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "PicCell.h"

@implementation PicCell
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.separatorInset = UIEdgeInsetsZero;
        self.layoutMargins = UIEdgeInsetsZero;
        self.preservesSuperviewLayoutMargins = NO;
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
//- (IBAction)picAnimate:(id)sender {
//    [UIImageView animateWithDuration:0.2 animations:nil];
//}

@end
