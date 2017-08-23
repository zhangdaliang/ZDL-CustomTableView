//
//  ViewController.m
//  ZDL_CustomTableView
//
//  Created by 张大亮 on 17/8/23.
//  Copyright © 2017年 张大亮. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
// 托管重用数组
@property (nonatomic, strong) NSMutableArray *arr;
// 需要添加到头部子视图的坐标Y值
@property (nonatomic, assign) CGFloat upY;
// 需要添加到尾部子视图的坐标Y
@property (nonatomic, assign) CGFloat downY;
// 拖动时候的偏移量
@property (nonatomic, assign) CGFloat offset;
@end

@implementation ViewController
- (void)loadView {
    [super loadView];
    // 初始化一个ScrollView 宽度为屏幕宽度 可滑动区域为10000
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 10000);
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 添加初始子视图到Scrollview 共10个 可以根据实际情况调控或者算法调控
    NSInteger i = 0;
    for (i = 0; i < 10; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, i * 100 +(i - 1) * 20, 375, 100)];
        switch (i) {
            case 0:{
                view.backgroundColor = [UIColor redColor];
            }
                break;
            case 1:{
                view.backgroundColor = [UIColor greenColor];
            }
                break;
            case 2:{
                view.backgroundColor = [UIColor orangeColor];
            }
                break;
            case 3:{
                view.backgroundColor = [UIColor grayColor];
            }
                break;
            case 4:{
                view.backgroundColor = [UIColor cyanColor];
            }
                break;
            case 5:{
                view.backgroundColor = [UIColor blueColor];
            }
                break;
            case 6:{
                view.backgroundColor = [UIColor magentaColor];
            }
                break;
            case 7:{
                view.backgroundColor = [UIColor greenColor];
            }
                break;
            case 8:{
                view.backgroundColor = [UIColor greenColor];
            }
                break;
            case 9:{
                view.backgroundColor = [UIColor greenColor];
            }
                break;
                
            default:
                break;
        }
        // 添加子视图到scrollview
        [self.scrollView addSubview:view];
        // 添加view到托管的重用数组
        [self.arr addObject:view];
    }
    // 下一个view的y点是
    i++;
    self.downY = i * 100 + (i - 1) * 20;
    self.upY = -120;
    self.offset = 0;
}
// 拖动开始的时候
// scrollView 开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 记录拖动开始的偏移量
    self.offset = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    // 判断上下滑 是否偏移量超出屏幕
    if (scrollView.contentOffset.y < 0 || scrollView.contentOffset.y > (10000 - 667)) {
        // 超出屏幕范围不做任何操作
    } else if ((scrollView.contentOffset.y - self.offset) > 0) {
        // 开始滑动的偏移量如果大于拖动的偏移量 手指拖动屏幕上拉
        // 上滑动
        if ((self.downY - (self.scrollView.contentOffset.y + 667)) < 150) {
            // 在尾部Y坐标距离屏幕底部150的时候
            // 取出数组的第一个元素
            UIView *view = [self.arr objectAtIndex:0];
            // 将头部Y坐标变为view的Y坐标 因为view要添加到尾部
            self.upY = view.frame.origin.y;
            // 移除数组第一个元素
            [self.arr removeObjectAtIndex:0];
            // 改变view的frame
            view.frame = CGRectMake(0, self.downY - 100 - 20, 375, 100);
            // 将view重新添加到数组
            [self.arr addObject:view];
            // 改变下一个的尾部坐标的Y值
            self.downY = self.downY + 100 + 20;
            
        }
        
    } else if((scrollView.contentOffset.y - self.offset) < 0){
        // 开始滑动的偏移量如果大于拖动的偏移量 手指拖动屏幕下拉
        // 下滑动
        if ((self.scrollView.contentOffset.y - self.upY) < 270) {
            // 在头部Y坐标距离屏幕顶端270的时候--》即将添加的头部view的尾部距离屏幕头部150
            // 取出数组的最后一个元素
            UIView *view = [self.arr lastObject];
            // 将尾部Y坐标变为view的Y坐标 因为view要添加到头部部
            self.downY = view.frame.origin.y;
            // 移除数组最后一个元素
            [self.arr removeObject:view];
            // 改变view的frame
            view.frame = CGRectMake(0, self.upY, 375, 100);
            // 将view重新添加到数组的头部
            [self.arr insertObject:view atIndex:0];
            // 改变下一个的头部坐标的Y值
            self.upY = self.upY - 100 - 20;
        }
    }
}
#pragma mark 懒加载
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }
    return _scrollView;
}

- (NSMutableArray *)arr {
    if (_arr == nil) {
        _arr = [[NSMutableArray alloc] init];
    }
    return _arr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
