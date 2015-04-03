//
//  LayoutButton.h
//  WXD
//
//  Created by 张伟 on 14/11/20.
//  Copyright (c) 2014年 ZJU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonItem : NSObject

@property (readwrite, nonatomic, strong) UIImage *image;
@property (readwrite, nonatomic, strong) NSString *title;
@property (readwrite, nonatomic, weak) id target;
@property (readwrite, nonatomic) SEL action;

+ (instancetype) item:(NSString *) title
                    image:(UIImage *) image
                   target:(id)target
                   action:(SEL) action;

@end

@interface LayoutButton : UIView

@property (strong,nonatomic) NSArray *items;

@property (assign,nonatomic) int imageH;
@property (assign,nonatomic) int textH;
@property (assign,nonatomic) float textFontSize;

- (void)initItem:(NSArray *)items;

@end
