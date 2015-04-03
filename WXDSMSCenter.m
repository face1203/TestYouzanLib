//
//  WXDSMSCenter.m
//  WXD
//
//  Created by 赵琦 on 14/11/24.
//  Copyright (c) 2014年 ZJU. All rights reserved.
//

#import "WXDSMSCenter.h"
#import "HTTPManager.h"
#import <AFNetworking.h>
@implementation WXDSMSCenter

//发送验证码
+ (void)sendMeCodeWithPhone:(NSString*)phone biz:(NSString*)biz andDetailBlock:(ResponseDetailBlock)block{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyyMMddHHmm";
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSString *time = [dateFormatter stringFromDate:[NSDate date]];
   // NSString *str1 = [HTTPManager md5:@"youzan_app_iphone6201411141511"];
    NSString *str = @"youzan_app_iphone6";
    str = [str stringByAppendingString:time];
    NSDictionary *param = @{@"mobile":phone,
                            @"biz":biz,
                            @"sms_token":[HTTPManager md5:str],
                            @"app_time":time,
                            @"method":@"kdt.auth.sms.send"};
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    NSDictionary *dic = [HTTPManager buildParam:param];
    
    [manager GET:WXDVerifyUrl parameters:dic
    success:^(AFHTTPRequestOperation *task, id responseObject){
        NSDictionary *jsonResponse = (NSDictionary *) responseObject;
        NSDictionary *response = [jsonResponse objectForKey:@"response"];
        if(response != nil){
            block(response,NO,nil);
        }
        NSDictionary *error_response = [jsonResponse objectForKey:@"error_response"];
        if(error_response != nil) {
            NSString *msg = [error_response objectForKey:@"msg"];
            block(error_response,YES,msg);
        }
    }

    failure:^(AFHTTPRequestOperation *task,NSError *error){
        block(nil,YES,@"failure");
    }];
    
    
}

//用于验证码的验证
+ (void)verifySMSCodeWithPhone:(NSString*)phone code:(NSString*)code biz:(NSString*)biz andDetailBlock:(ResponseDetailBlock)block{
    NSDictionary *param = @{@"sms_code":code,
                          @"mobile":phone,
                          @"biz":biz,
                            @"method":@"kdt.auth.sms.valid"};
    NSDictionary *dic =[HTTPManager buildParam:param];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:WXDVerifyUrl parameters:dic success:^(AFHTTPRequestOperation *operation,id responseObject){
        NSDictionary *json = (NSDictionary *) responseObject;
        id success_response = [json objectForKey:@"response"];
        if (success_response != nil) {
            block(success_response,NO,nil);
        }
        id error_response = [json objectForKey:@"error_response"];
        if (error_response != nil) {
            block(error_response,YES,nil);
        }
    }failure:^(AFHTTPRequestOperation *operation,NSError *error){
        block(nil,YES,@"failure");
    }];
}
@end
