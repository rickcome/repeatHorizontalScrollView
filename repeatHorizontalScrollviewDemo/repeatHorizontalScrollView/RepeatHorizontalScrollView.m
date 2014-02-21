//
//  RepeatHorizontalScrollView.m
//  repeatHorizontalScrollviewDemo
//
//  Created by kewei on 2/20/14.
//  Copyright (c) 2014 kewei. All rights reserved.
//

#import "RepeatHorizontalScrollView.h"
#define RATEMODEL 5

@implementation RepeatHorizontalScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initUI];
    }
    return self;
}
-(void)initUI{
    
}
-(void)run{
    _cellBounds = self.bounds;
    _cellWidth = _cellBounds.size.width;
    _cellHeight = _cellBounds.size.height;
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:_cellBounds];
    [self addSubview:_scrollView];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.scrollsToTop = NO;
    _scrollView.delegate = self;

    
    _total= [_delegate numberOfCellInRepeatHorizontalScrollView:self];

    
    
    _currentIndex = 0;
    
    _dictionaryCells = [NSMutableDictionary dictionary];
    _scrollView.contentSize = CGSizeMake(_cellWidth * (_total * RATEMODEL), _cellHeight);
    
    
//    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0
//                                              target:self
//                                            selector:@selector(scrollToNext)
//                                            userInfo:nil
//                                             repeats:YES];

    
    
    float pageControlWidth=(_total)*10.0f+40.f;
    float pagecontrolHeight=20.0f;
    _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake((self.bounds.size.width-pageControlWidth)/2,self.bounds.size.height-pagecontrolHeight - 10, pageControlWidth, pagecontrolHeight)];
    _pageControl.currentPage=0;
    _pageControl.numberOfPages=_total;
    [self addSubview:_pageControl];
    _pageControl.backgroundColor = [UIColor redColor];
    
    
    _currentOffsetIndex = RATEMODEL/2 * _total;
    
    _scrollView.contentOffset = CGPointMake(_currentOffsetIndex * _cellWidth, 0);
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat x = scrollView.contentOffset.x;
    NSInteger index = floor(x/_cellWidth);
    NSLog(@"scrollview to x:%f and index : %d", x , index);

    [self moveTo:index];
}
-(void)moveTo:(NSInteger)index{
    if(index != _centerIndex){
        _centerIndex = index;
        [self showCell:index];
    }
    if(index - 1>=0 && _leftIndex != index - 1){
        _leftIndex = index - 1;
        _leftView = [self showCell:index - 1];
    }
    if(index + 1<= _total*RATEMODEL - 1 && _rightIndex != index+1){
        _rightIndex = index + 1;
        _rightView = [self showCell:index + 1];
    }
}
-(UIView *)showCell:(NSInteger)index{
    NSInteger indexData = index % _total;
    NSString *sIndexData = [NSString stringWithFormat:@"%d", indexData];
    UIView *view = _dictionaryCells[sIndexData];
    if(view == nil){
        view = [_delegate repeatHorizontalScrollView:self cellForIndex:indexData];
    }
    [_scrollView addSubview:view];
    view.frame = CGRectMake(index * _cellWidth, 0, _cellWidth, _cellHeight);
    return view;
}


















































































































//
//-(void)scrollToNext{
//    _currentIndex ++ ;
//    if(_currentIndex <_total){
//        [self drawcell:_currentIndex];
//    }
//    NSInteger toX = _scrollView.bounds.size.width * (_currentIndex + 1);
//    
//    if(_currentIndex == _total - 1){
//        ((UIView *)_dictionaryCells[@"0"]).frame = CGRectMake((_total + 1)*self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
//    }
//    if(_currentIndex == 0){
//        ((UIView *)_dictionaryCells[[NSString stringWithFormat:@"%d", _total-1]]).frame = CGRectMake(-self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
//    }
//    [UIView animateWithDuration:0.5
//                          delay:0.0
//                        options: UIViewAnimationOptionCurveEaseOut
//                     animations:^{
//                         [_scrollView setContentOffset:CGPointMake(toX, 0) animated:NO];
//                     }
//                     completion:^(BOOL finished){
//                         if(_currentIndex == _total){
//                             _currentIndex = 0;
//                             [_scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:NO];
//                            ((UIView *)_dictionaryCells[@"0"]).frame = CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
//                         }
//                         _pageControl.currentPage = _currentIndex;
//
//                     }
//     ];
//}
//-(void)drawcell:(NSInteger)index{
//    NSString *key = [NSString stringWithFormat:@"%d", index];
//    UIView *view = [_dictionaryCells objectForKey:key];
//    if(view == nil){
//        view = [_delegate repeatHorizontalScrollView:self cellForIndex:index];
//        [_dictionaryCells setValue:view forKey:key];
//        [_scrollView addSubview:view];
//        view.frame = CGRectMake((index + 1) * _scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
//    }
//}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGPoint point = scrollView.contentOffset;
//    NSInteger x = point.x;
//    NSInteger index = floor(x/self.bounds.size.width);
//////    NSLog(@"x:%d,index:%d",x, index);
//    [self drawcell:index];
//    [self drawcell:index+1];
//    [self drawcell:index-1];
//    
//    
//    [self resetFeCell:index];
//}
//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    [_timer invalidate];
//}
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    [_timer fire];
//}
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    CGPoint point = scrollView.contentOffset;
//    NSInteger x = point.x;
//    NSInteger index = floor(x/self.bounds.size.width);
//    _pageControl.currentPage = index - 1;
//    
//    
//    if(index - 1 == _total){
//        _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
//        _pageControl.currentPage = 0;
//    }else if(index == 0){
//        _scrollView.contentOffset = CGPointMake(self.bounds.size.width * (_total), 0);
//        _pageControl.currentPage = _total -1;
//        [self resetCellIndex:_total-1 xIndex:_total];
//        [self resetFeCell:_total-1];
//        NSLog(@"5:%@",NSStringFromCGRect(((UIView *)_dictionaryCells[@"5"]).frame));
//    }else{
//        [self resetFeCell:_pageControl.currentPage];
//    }
//}
//-(void)resetFeCell:(NSInteger) page{//重置开始与结束位置旁边的cell
//    NSInteger index;
//    NSInteger xIndex;
//    BOOL needReset = NO;
//    if(page == 0){
//        index = _total - 1;
//        xIndex = 0;
//        needReset = YES;
//    }
//    if(page == 1){
//        index = 0;
//        xIndex = 1;
//        needReset = YES;
//    }
//    if(page == _total-2){
//        index = _total - 1;
//        xIndex = _total;
//        needReset = YES;
//    }
//    if(page == _total - 1){
//        index = 0;
//        xIndex= _total + 1;
//        needReset = YES;
//    }
//    if(needReset == YES){
//        [self resetCellIndex:index xIndex:xIndex];
//    }
//}
//-(void)resetCellIndex:(NSInteger)index xIndex:(NSInteger)xIndex{
//    CGRect frame = self.bounds;
//    NSString *key = [NSString stringWithFormat:@"%d", index];
//    UIView *view = _dictionaryCells[key];
//    if(view){
//        frame.origin.x = xIndex * self.bounds.size.width;
//        view.frame = frame;
//    }
//}
@end
