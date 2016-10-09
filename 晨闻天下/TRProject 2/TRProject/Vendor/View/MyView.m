//
//  MyView.m
//  TRProject
//
//  Created by 钟至大 on 16/8/19.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "MyView.h"
static MyView *myView = nil;
@implementation MyView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    
    
    NSLog(@"%s",__func__);
    
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    return NO;
}

+ (MyView *)shareView{
    
    if (myView == nil) {
        myView = [[MyView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    }
    return myView;
}
@end
