//
//  TVCell.h
//  TRProject
//
//  Created by 钟至大 on 16/8/12.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TVCell;
@protocol TVCellDelegate <NSObject>

- (void)playVedioForCell:(TVCell *)cell;
- (void)saveItemForCell:(TVCell *)cell;
- (void)shareItemForCell:(TVCell *)cell;
@end
@interface TVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backgroundIV;
@property (weak, nonatomic) IBOutlet UILabel *durationLb;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *playTimesLb;
@property (weak, nonatomic) IBOutlet UILabel *commentLb;

@property (nonatomic,weak) id<TVCellDelegate> delegate;
@end
