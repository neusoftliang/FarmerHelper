//
//  NewsNetManager.m
//  BaseProject
//
//  Created by tarena on 15/12/16.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "NewsNetManager.h"
#import "NewsPath.h"

//static AFHTTPSessionManager *manager = nil;

@implementation NewsNetManager

/*+ (AFHTTPSessionManager *)sharedAFManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/json",@"text/javascript",@"text/plain", nil];
        manager.requestSerializer.timeoutInterval = 30;
    });
    return manager;
    
}*/

+(id)getNewsListWithStartIndex:(NSInteger)index completionHandle:(void (^)(id, NSError *))completionHandle
{
    //http://c.m.163.com/nc/video/home/1-10.html
    NSString *path = [NSString stringWithFormat:kNewsPath,index];
    /*return  [[self sharedAFManager] GET:path parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        completionHandle(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        completionHandle(nil,error);
    }];*/
    return [self GET:path parameters:nil completionHandle:^(id responseObj, NSError *error) {
        completionHandle(responseObj,error);
    }];
}



@end
