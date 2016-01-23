//
//  NSObject+NetWork.h
//  BaseProject
//
//  Created by tarena on 15/12/16.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NetWork)

+(id)GET:(NSString *)path parameters:(NSDictionary *)params completionHandle:(void(^)(id responseObj,NSError *error))completionHandle;
+(id)POST:(NSString *)path parameters:(NSDictionary *)params completionHandle:(void(^)(id responseObj,NSError *error))completionHandle;

@end
