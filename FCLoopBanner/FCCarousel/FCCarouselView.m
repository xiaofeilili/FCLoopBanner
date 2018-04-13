//
//  Carousel.m
//  ArrangeOfComponent
//
//  Created by 李晓飞 on 2018/4/12.
//  Copyright © 2018年 xiaofei. All rights reserved.
//

#import "FCCarouselView.h"
#import "UIImageView+WebCache.h"

#define CarouselWidth       self.frame.size.width
#define CarouselHeight      self.frame.size.height

@interface FCCarouselView ()<UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIPageControl *pageControl;

@property (nonatomic, strong)NSTimer *timer;

@end

@implementation FCCarouselView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.backgroundColor = [UIColor lightGrayColor];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pageViewClick:)];
        [_scrollView addGestureRecognizer:tapGesture];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.superview.backgroundColor = [UIColor redColor];
        pageControl.numberOfPages = self.imageArray.count;
        // 默认是0
        pageControl.currentPage = 0;
        //
        CGSize pageSize = [pageControl sizeForNumberOfPages:self.imageArray.count];
        pageControl.bounds = CGRectMake(0, 0, pageSize.width, pageSize.height);
        pageControl.center = CGPointMake(self.center.x, self.frame.size.height - 20);
        pageControl.pageIndicatorTintColor = [UIColor redColor];
        pageControl.currentPageIndicatorTintColor = [UIColor cyanColor];
        [pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
        _pageControl = pageControl;
    }
    return _pageControl;
}


- (void)setImageArray:(NSArray *)imageArray {
    if (_imageArray != imageArray) {
        _imageArray = imageArray;
    }
    
    [self addSubview:self.scrollView];
    
    [self setupImage:_imageArray];
    
    [self addSubview:self.pageControl];
    
    [self startTimer];
}

- (void)setDurationTime:(NSTimeInterval)durationTime {
    _durationTime = durationTime;
    
    [self startTimer];
}

- (void)setupImage:(NSArray *)array {
    CGSize contentSize;
    CGPoint startPoint;
    
    if (array.count) {
        if (array.count > 1) {
            for (int i = 0; i < array.count + 2; i++) {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CarouselWidth * i, 0, CarouselWidth, CarouselHeight)];
                if (i == 0) {
                    NSString *imgName = array[array.count - 1];
                    [imgName hasPrefix:@"http"] ? ([imageView sd_setImageWithURL:[NSURL URLWithString:imgName] placeholderImage:[UIImage imageNamed:@"123"]]) : ([imageView setImage:[UIImage imageNamed:imgName]]);
                }else if (i == array.count + 1) {
                    NSString *imgName = array[0];
                    [imgName hasPrefix:@"http"] ? ([imageView sd_setImageWithURL:[NSURL URLWithString:imgName] placeholderImage:[UIImage imageNamed:@"123"]]) : ([imageView setImage:[UIImage imageNamed:imgName]]);
                }else {
                    NSString *imgName = array[i - 1];
                    [imgName hasPrefix:@"http"] ? ([imageView sd_setImageWithURL:[NSURL URLWithString:imgName] placeholderImage:[UIImage imageNamed:@"123"]]) : ([imageView setImage:[UIImage imageNamed:imgName]]);
                }
                [self.scrollView addSubview:imageView];
            }
            contentSize = CGSizeMake(CarouselWidth * (array.count + 2), CarouselHeight);
            startPoint = CGPointMake(CarouselWidth, 0);
        }else {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CarouselWidth, CarouselHeight)];
            NSString *imgName = array[0];
            [imgName hasPrefix:@"http"] ? ([imageView sd_setImageWithURL:[NSURL URLWithString:imgName] placeholderImage:[UIImage imageNamed:@"123"]]) : ([imageView setImage:[UIImage imageNamed:imgName]]);
            [self.scrollView addSubview:imageView];
            contentSize = CGSizeMake(CarouselWidth, CarouselHeight);
            startPoint = CGPointZero;
        }
        // 开始的偏移量跟内容尺寸
        self.scrollView.contentOffset = startPoint;
        self.scrollView.contentSize = contentSize;
    }else {
        return;
    }
}

#pragma mark - action
// 点击pageControl 小点点
- (void)pageChanged:(UIPageControl *)pageControl {
    NSLog(@"%zd  & %f",pageControl.currentPage,self.bounds.size.width);
    //获取当前页面的宽度
    CGFloat x = pageControl.currentPage * CarouselWidth;
    //通过设置scrollView的偏移量来滚动图像
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}
// 点击图片
- (void)pageViewClick:(UITapGestureRecognizer *)tap {
    if (_pageViewBlock) {
        _pageViewBlock(self.pageControl.currentPage);
    }
}

#pragma mark - Timer
- (void)startTimer {
    [self.timer invalidate];
    
    NSTimeInterval dTime = _durationTime ? _durationTime : 3.0;
    self.timer = [NSTimer timerWithTimeInterval:dTime target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)updateTimer {
    CGPoint newOffset = CGPointMake(self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.frame), 0);
    [self.scrollView setContentOffset:newOffset animated:YES];
}

#pragma mark - scrollView代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x < CarouselWidth) {
        [self.scrollView setContentOffset:CGPointMake(CarouselWidth * (self.imageArray.count + 1), 0) animated:NO];
    }
    //偏移超过
    if (scrollView.contentOffset.x > CarouselWidth * (self.imageArray.count + 1)) {
        [self.scrollView setContentOffset:CGPointMake(CarouselWidth, 0) animated:NO];
    }
    int pageCount = scrollView.contentOffset.x / CarouselWidth;
    
    if (pageCount > self.imageArray.count) {
        pageCount = 0;
    }else if (pageCount == 0){
        pageCount = (int)self.imageArray.count - 1;
    }else{
        pageCount--;
    }
    self.pageControl.currentPage = pageCount;
}
// 开始拖拽时，注销timer
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
}
// 拖拽结束时，开启timer
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startTimer];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
