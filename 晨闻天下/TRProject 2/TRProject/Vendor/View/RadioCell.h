//
//  RadioCell.h
//  TRProject
//
//  Created by 钟至大 on 16/8/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RadioCell : UITableViewCell
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *iconIVs;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *smallTitles;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *origins;
@property (nonatomic) NSInteger pointNumber;
@end
