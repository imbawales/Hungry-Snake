//
//  LJWSnakeViewController.m
//  Boring Demo
//
//  Created by apple on 16/12/23.
//  Copyright © 2016年 wales. All rights reserved.
//

#import "LJWSnakeViewController.h"

@interface LJWSnakeViewController()<LJWSnakeDelegate>

@end

@implementation LJWSnakeViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    //创建蛇对象
    self.snake = [LJWSnake snake];
    self.snakeView.snake = self.snake;
    self.snake.snakeDelegate = self;
    [self.snake start];

}

/*点击向上按钮*/
- (IBAction)upBtnClick:(id)sender {
    self.snake.MoveDirection = kMoveDirectionUp;
}
/*点击向下按钮*/
- (IBAction)downBtnClick:(id)sender {
    self.snake.MoveDirection = kMoveDirectionDown;
}
/*点击向左按钮*/
- (IBAction)leftBtnClick:(id)sender {
    self.snake.MoveDirection = kMoveDirectionLeft;

}
/*点击向右按钮*/
- (IBAction)rightBtnClick:(id)sender {
    self.snake.MoveDirection = kMoveDirectionRight;

}


//取消状态栏显示
-(BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - LJWSnakeDelegate
-(void)refreshDrawing{
    [self.snakeView setNeedsDisplay];
    LJWNode *node = self.snake.nodesArr.firstObject;
    //如果碰到自己
    CGPoint headPoint = node.centerPoint;
    for (int i = 1; i < self.snake.nodesArr.count; i ++) {
        LJWNode *node = self.snake.nodesArr[i];
        if (CGPointEqualToPoint(headPoint, node.centerPoint)) {
            [self.snake gameOver];
        }
    }
    //如果碰到左右边界
    if (node.centerPoint.x < 5 || node.centerPoint.x > [UIScreen mainScreen].bounds.size.width) {
        [self.snake gameOver];
    }
    //如果碰到上下边界
    if (node.centerPoint.y < 5 || node.centerPoint.y > [UIScreen mainScreen].bounds.size.height - 220) {
        [self.snake gameOver];
    }
}

@end
