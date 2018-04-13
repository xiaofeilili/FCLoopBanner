//
//  FCLoopBanner.h
//  Test
//
//  Created by 李晓飞 on 2018/4/12.
//  Copyright © 2018年 xiaofei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCLoopBanner : UIView

/** click action */
@property (nonatomic, copy) void (^clickAction) (NSInteger curIndex) ;

/** data source */
@property (nonatomic, copy) NSArray *imageURLStrings;


- (instancetype)initWithFrame:(CGRect)frame scrollDuration:(NSTimeInterval)duration;


@end
