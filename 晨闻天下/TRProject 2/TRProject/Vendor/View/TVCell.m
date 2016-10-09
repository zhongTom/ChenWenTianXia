//
//  TVCell.m
//  TRProject
//
//  Created by 钟至大 on 16/8/12.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TVCell.h"
#import "TVViewController.h"
@implementation TVCell

- (IBAction)playVedio:(id)sender {
    if (self.delegate &&[self.delegate respondsToSelector:@selector(playVedioForCell:)]) {
        [self.delegate playVedioForCell:self];
    }
}
- (IBAction)saveItem:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(saveItemForCell:)]) {
        [self.delegate saveItemForCell:self];
    }
}
- (IBAction)share:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(shareItemForCell:)]) {
        [self.delegate shareItemForCell:self];
    }
}


- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
