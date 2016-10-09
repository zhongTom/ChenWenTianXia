//
//  RadioPlayerListCell.h
//  TRProject
//
//  Created by 钟至大 on 16/8/18.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RadioPlayerListCell;
@protocol RadioPlayerDelegate <NSObject>

- (void)saveItemForCell:(RadioPlayerListCell *)cell;

@end
@interface RadioPlayerListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (nonatomic,weak) id<RadioPlayerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *date;

@end
