//
//  WXDSMSCenter.h
//  WXD
//
//  Created by 赵琦 on 14/11/24.
//  Copyright (c) 2014年 ZJU. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WXDSMSCenter : NSObject


@property (strong,nonatomic) NSDictionary *msg;
+ (void)sendMeCodeWithPhone:(NSString*)phone biz:(NSString*)biz andDetailBlock:(ResponseDetailBlock)block;
+ (void)verifySMSCodeWithPhone:(NSString*)phone code:(NSString*)code biz:(NSString*)biz andDetailBlock:(ResponseDetailBlock)block;
@end
