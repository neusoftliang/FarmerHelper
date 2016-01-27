//
//  NSObject+AFNet.m
//  风味儿
//
//  Created by neusoftliang on 16/1/6.
//  Copyright © 2016年 neusoftliang. All rights reserved.
//

#import "NSObject+AFNet.h"

@implementation NSObject (AFNet)

+(id)GET:(NSString *)path parameters:(NSDictionary *)params completionHandle:(void (^)(id, NSError *))completionHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"cad019fe72bf309b500e493fff396287" forHTTPHeaderField: @"apikey"];
    [manager.requestSerializer setValue:@"text/html"forHTTPHeaderField:@"Content-Type"];
    return [manager GET:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"resp---afnet%@",responseObject);
        completionHandle(responseObject,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionHandle(nil,error);
    }];
}
@end
