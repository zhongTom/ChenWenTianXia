//
//  RadioViewModel.m
//  TRProject
//
//  Created by 钟至大 on 16/8/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "RadioViewModel.h"
#import "RadioNetManager.h"
#import "CacheManager.h"
@implementation RadioViewModel
MJCodingImplementation
- (instancetype)init{
    if (self = [super init]) {
        id obj = [CacheManager getModelForRadio];
        if (obj) {
            self = obj;
        }
    }
    return self;
}
//主界面
- (NSInteger)sectionNumber{
    return self.cardList.count;
}
- (NSString *)getBigTitleForSection:(NSInteger)section{
    if (section == 0) {
        return @"独家报道";
    }
    return self.cardList[section].cardTitle;
}

- (NSMutableArray<RadioDataCardlistModel *> *)cardList{
    if (!_cardList) {
        _cardList = [NSMutableArray new];
    }
    return _cardList;
}
- (NSArray *)getIdForSection:(NSInteger)section{
    NSMutableArray *idArr = [NSMutableArray new];
    NSArray *list = self.cardList[section].cardDetails;
    for (RadioDataCardListCarddetailsModel *model in list) {
        [idArr addObject:model.ID];
    }
    return [idArr copy];
}
- (NSArray<NSURL *> *)getURLForSection:(NSInteger)section{
    NSMutableArray *url = [NSMutableArray new];
    NSArray *list = self.cardList[section].cardDetails;
    for (RadioDataCardListCarddetailsModel *model in list) {
        [url addObject:[NSURL URLWithString:model.image]];
    }
    return [url copy];
}
- (NSArray<NSString *> *)getSmallTitleForSection:(NSInteger)section{
    
    NSMutableArray *title = [NSMutableArray new];
    NSArray *list = self.cardList[section].cardDetails;
    for (RadioDataCardListCarddetailsModel *model in list) {
        [title addObject:model.title];
    }
    return [title copy];

}
- (NSArray<NSString *> *)getOriginForSection:(NSInteger)section{
    NSMutableArray *origin = [NSMutableArray new];
    NSArray *list = self.cardList[section].cardDetails;
    for (RadioDataCardListCarddetailsModel *model in list) {
        [origin addObject:model.programName];
    }
    return [origin copy];
}
- (NSString *)getNodeIdForSection:(NSInteger)section{
    return self.cardList[section].nodeId;
}
- (void)getRadioCompletionHandler:(void (^)(NSError *))completionHandler{
    [RadioNetManager getRadioCompletionHandler:^(RadioModel *model, NSError *error) {
        if (!error) {
            self.cardList = [model.data.cardList mutableCopy];
            self.focusList = [model.data.focus mutableCopy];
        }
        [CacheManager saveRadioModel:self];
        completionHandler(error);
    }];
}
//头部试图
- (NSInteger)icNumber{
    return self.focusList.count;
}
- (NSMutableArray<RadioDataFocusModel *> *)focusList{
    if (!_focusList) {
        _focusList = [NSMutableArray new];
    }
    return _focusList;
}
- (NSURL *)getTopIconURLForRow:(NSInteger)row{
    return [NSURL URLWithString:self.focusList[row].image];
}
- (NSString *)getTopTitleForRow:(NSInteger)row{
    return self.focusList[row].bannerTitle;
}
@end
