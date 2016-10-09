//
//  TVNetManager.h
//  TRProject
//
//  Created by 钟至大 on 16/8/12.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TVModel.h"
@interface TVNetManager : NSObject

+ (id)getTVDataWithTypeId:(NSInteger)typeId page:(NSInteger)page completionHandler:kCompetionHandlerBlock;
@end
