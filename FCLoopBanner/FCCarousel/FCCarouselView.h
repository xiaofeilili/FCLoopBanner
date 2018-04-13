//
//  Carousel.h
//  ArrangeOfComponent
//
//  Created by 李晓飞 on 2018/4/12.
//  Copyright © 2018年 xiaofei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCCarouselView : UIView

@property (nonatomic, copy)void (^pageViewBlock)(NSInteger index);

// 图片数组
@property (nonatomic, copy)NSArray *imageArray;
// 轮播间隔时间
@property (nonatomic, assign)NSTimeInterval durationTime;

@end
