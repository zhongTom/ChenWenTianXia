//
//  NSObject+HUD.m
//  TRProject
//
//  Created by 钟至大 on 16/8/24.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "NSObject+HUD.h"

@implementation NSObject (HUD)
- (void)setHUDWithTitle:(NSString *)title{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kAppdelegate.window animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    
    [hud hide:YES afterDelay:1];
}

@end
