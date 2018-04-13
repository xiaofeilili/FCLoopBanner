//
//  ViewController.m
//  FCLoopBanner
//
//  Created by 李晓飞 on 2018/4/13.
//  Copyright © 2018年 xiaofei. All rights reserved.
//

#import "ViewController.h"
#import "FCCarouselView.h"
#import "FCLoopBanner.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
#pragma mark - 根据图片个数 创建imageView
    FCCarouselView *carV = [[FCCarouselView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    carV.imageArray = @[@"http://i1.douguo.net//upload/banner/0/6/a/06e051d7378040e13af03db6d93ffbfa.jpg", @"http://i1.douguo.net//upload/banner/9/3/4/93f959b4e84ecc362c52276e96104b74.jpg", @"http://i1.douguo.net//upload/banner/5/e/3/5e228cacf18dada577269273971a86c3.jpg", @"http://i1.douguo.net//upload/banner/d/8/2/d89f438789ee1b381966c1361928cb32.jpg"];
    //    carV.imageArray = @[@"footer_channel", @"footer_logo", @"footer_channel", @"footer_logo"];
    [self.view addSubview:carV];
#pragma mark - 始终只有三个imageView 我们所看到的imageView始终是在scrollView中间的
    FCLoopBanner *loopBanner = [[FCLoopBanner alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 208) scrollDuration:3.0];
    loopBanner.imageURLStrings = @[@"http://i1.douguo.net//upload/banner/0/6/a/06e051d7378040e13af03db6d93ffbfa.jpg", @"http://i1.douguo.net//upload/banner/9/3/4/93f959b4e84ecc362c52276e96104b74.jpg", @"http://i1.douguo.net//upload/banner/5/e/3/5e228cacf18dada577269273971a86c3.jpg", @"http://i1.douguo.net//upload/banner/d/8/2/d89f438789ee1b381966c1361928cb32.jpg"];
    //    loopBanner.imageURLStrings = @[@"footer_channel", @"footer_logo", @"footer_channel", @"footer_logo"];
    [self.view addSubview:loopBanner];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
