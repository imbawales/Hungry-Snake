//
//  LJWSnakeView.m
//  Boring Demo
//
//  Created by apple on 16/12/23.
//  Copyright © 2016年 wales. All rights reserved.
//

#import "LJWSnakeView.h"
#import "LJWSnake.h"

@implementation LJWSnakeView

/* 画蛇 */
-(void)drawRect:(CGRect)rect{
    if (_snake.nodesArr.count == 0) {
        return;
    }
    
    //画蛇头
    CGPoint FirstNodeCenter = _snake.nodesArr.firstObject.centerPoint;
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint headCenter = CGPointMake(FirstNodeCenter.x, FirstNodeCenter.y);
    [self drawSnakeHeadWithPath:path andPoint:headCenter];
    [[UIColor colorWithRed:arc4random_uniform(5) green:arc4random_uniform(5) blue:arc4random_uniform(5) alpha:1] set];
    [path fill];
    
    //画蛇身
    for (int i = 1; i < _snake.snakeLength; i ++) {
        CGPoint center = _snake.nodesArr[i].centerPoint;
        CGRect rectangle = CGRectMake(center.x - NODEW * 0.5 , center.y - NODEH * 0.5, NODEW, NODEH);
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rectangle];
        [[UIColor colorWithRed:arc4random_uniform(3) green:arc4random_uniform(5) blue:arc4random_uniform(15) alpha:1] set];
        [path fill];
        
        
    }
    
}

/*
 *画蛇头
 *param 1 :画笔路径对象
 *param 2 :蛇头Node的中心点坐标
 */
-(void)drawSnakeHeadWithPath:(UIBezierPath *)path andPoint:(CGPoint)center{
    CGFloat halfW = NODEW * 0.5;
    CGFloat halfH = NODEH * 0.5;
    switch (self.snake.MoveDirection) { //根据蛇前进的方向画蛇头三角形的方向
        case kMoveDirectionUp:
            [path moveToPoint:CGPointMake(center.x - halfW, center.y + halfH)];
            [path addLineToPoint:CGPointMake(center.x, center.y - halfH)];
            [path addLineToPoint:CGPointMake(center.x + halfW, center.y + halfH)];
            break;
        case kMoveDirectionDown:
            [path moveToPoint:CGPointMake(center.x - halfW, center.y - halfH)];
            [path addLineToPoint:CGPointMake(center.x, center.y + halfH)];
            [path addLineToPoint:CGPointMake(center.x + halfW, center.y - halfH)];
            break;
        case kMoveDirectionLeft:
            [path moveToPoint:CGPointMake(center.x - halfW, center.y)];
            [path addLineToPoint:CGPointMake(center.x + halfW, center.y - halfH)];
            [path addLineToPoint:CGPointMake(center.x + halfW, center.y + halfH)];
            break;
        case kMoveDirectionRight:
            [path moveToPoint:CGPointMake(center.x - halfW, center.y - halfH)];
            [path addLineToPoint:CGPointMake(center.x + halfW, center.y)];
            [path addLineToPoint:CGPointMake(center.x - halfW, center.y + halfH)];
            break;
        default:
            break;
    }
}

-(void)awakeFromNib{
}
@end
