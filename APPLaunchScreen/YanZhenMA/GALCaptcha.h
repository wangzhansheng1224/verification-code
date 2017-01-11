//
//  GALCaptcha.h
//  APPLaunchScreen
//
//  Created by love on 2016/11/25.
//  Copyright © 2016年 love. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GALCaptcha : UIView

@property (nonatomic, retain)NSArray *CatArray;//验证码素材库
@property (nonatomic, retain)NSMutableString *CatString;//验证码字符串

- (void)click;
@end
