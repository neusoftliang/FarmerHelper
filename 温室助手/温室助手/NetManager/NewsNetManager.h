//
//  NewsNetManager.h
//  BaseProject
//
//  Created by tarena on 15/12/16.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "BaseNetManager.h"

@interface NewsNetManager : BaseNetManager
+(id)getNewsListWithStartIndex:(NSInteger)index completionHandle:(void(^)(id model,NSError *error))completionHandle;
@end
