//
//  NewsMutiableCell.h
//  Project
//
//  Created by 钟至大 on 16/8/5.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsMutiableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *iconL;
@property (weak, nonatomic) IBOutlet UIImageView *iconM;
@property (weak, nonatomic) IBOutlet UIImageView *iconR;
@property (weak, nonatomic) IBOutlet UILabel *comment;

@end
