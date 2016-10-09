//
//  TRTabBarController.m
//  TRProject
//
//  Created by 钟至大 on 16/8/22.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRTabBarController.h"

@interface TRTabBarController ()

@end

@implementation TRTabBarController

+(instancetype)defaultTabBar{
    static TRTabBarController *tab = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tab = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Tab"];
    });
    
    
    return tab;
}

@end
