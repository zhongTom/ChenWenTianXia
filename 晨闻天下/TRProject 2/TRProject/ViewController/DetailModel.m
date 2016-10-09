//
//  DetailModel.m
//  TRProject
//
//  Created by 钟至大 on 16/8/20.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "DetailModel.h"

@interface DetailModel()<NSCoding>

@end
@implementation DetailModel
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.url forKey:@"url"];
    [aCoder encodeObject:self.contentText forKey:@"contentText"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.url = [aDecoder decodeObjectForKey:@"url"];
        self.contentText = [aDecoder decodeObjectForKey:@"contentText"];
    }
    return self;
}
@end
