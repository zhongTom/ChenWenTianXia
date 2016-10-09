//
//  RadioCell.m
//  TRProject
//
//  Created by 钟至大 on 16/8/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "RadioCell.h"

@implementation RadioCell
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.separatorInset = UIEdgeInsetsZero;
        self.layoutMargins = UIEdgeInsetsZero;
        self.preservesSuperviewLayoutMargins = NO;
    }
    return self;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    CGPoint location = [[touches anyObject] locationInView:self];
    if (location.x<self.contentView.frame.size.width/3) {
        self.pointNumber = 0;
    }else if (location.x<self.contentView.frame.size.width*2/3){
        self.pointNumber = 1;
    }else{
        self.pointNumber = 2;
    }

}
@end
