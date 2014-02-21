//
//  RepeatHorizontalScrollView.h
//  repeatHorizontalScrollviewDemo
//
//  Created by kewei on 2/20/14.
//  Copyright (c) 2014 kewei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RepeatHorizontalScrollViewDelegate;


@interface RepeatHorizontalScrollView : UIView<UIScrollViewDelegate>{
    NSInteger _cellWidth;
    NSInteger _cellHeight;
    CGRect _cellBounds;
    UIScrollView *_scrollView;
    NSTimer *_timer;
    NSInteger _currentIndex;
    NSInteger _currentOffsetIndex;
    NSInteger _total;
    NSMutableDictionary *_dictionaryCells;
    UIPageControl *_pageControl;
    
    
    UIView *_leftView;
    UIView *_rightView;
    UIView *_centerView;
    NSInteger _leftIndex;
    NSInteger _rightIndex;
    NSInteger _centerIndex;
}
@property (nonatomic, weak) id<RepeatHorizontalScrollViewDelegate> delegate;


-(void)run;
@end



@protocol RepeatHorizontalScrollViewDelegate <NSObject>

@required
-(NSInteger )numberOfCellInRepeatHorizontalScrollView:(RepeatHorizontalScrollView *)view;
-(UIView *)repeatHorizontalScrollView:(RepeatHorizontalScrollView *)view cellForIndex:(NSInteger)index;

@end