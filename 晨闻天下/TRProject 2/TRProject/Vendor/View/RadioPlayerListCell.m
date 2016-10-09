//
//  RadioPlayerListCell.m
//  TRProject
//
//  Created by 钟至大 on 16/8/18.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "RadioPlayerListCell.h"

@implementation RadioPlayerListCell
- (IBAction)saveItem:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(saveItemForCell:)]) {
        [self.delegate saveItemForCell:self];
    }
}

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

@end
