//
//  LayoutButton.m
//  WXD
//
//  Created by 张伟 on 14/11/20.
//  Copyright (c) 2014年 ZJU. All rights reserved.
//

#define BottomLine 0xC2C2C2

#import "LayoutButton.h"

@implementation ButtonItem


+ (instancetype) item:(NSString *) title
                    image:(UIImage *) image
                   target:(id)target
                   action:(SEL) action
{
    return [[ButtonItem alloc] init:title
                              image:image
                             target:target
                             action:action];
}

- (id) init:(NSString *) title
      image:(UIImage *) image
     target:(id)target
     action:(SEL) action
{
    
    self = [super init];
    if (self) {
        
        _title = title;
        _image = image;
        _target = target;
        _action = action;
    }
    return self;
}
@end


@implementation LayoutButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        _items = [[NSArray alloc] init];
        _imageH = 30;
        _textH = 12;
        _textFontSize = 9.0;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,frame.size.width , .5)];
        imageView.backgroundColor = UIColorFromRGB(BottomLine);
        [self addSubview:imageView];
    }
    return self;
}

- (void)initItem:(NSArray *)items{
    
    if([items count] <= 0){
        return;
    }
    
    self.items = items;
    
    int width = (self.frame.size.width - 20)/items.count;
    int height = self.frame.size.height;
    int i = 0;
    int begin = (height - _imageH - _textH) / 2.0 + 2;
    for(ButtonItem *item in _items) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(width * i + 10, begin, width, height)];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width/2 - _imageH/2, 0, _imageH, _imageH)];
        imageView.image = item.image;
        [button addSubview:imageView];
         imageView.tag = 10001;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, begin + _imageH - 4, width, _textH)];
        label.text = item.title;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:_textFontSize];
        label.textColor = UIColorFromRGB(0x222222);//  0xd13600
        [button addSubview:label];
        label.tag = 10002;
        
        [button addTarget:item.target action:item.action forControlEvents:UIControlEventTouchUpInside];
        i++;
        [self addSubview:button];
    }
}

@end
