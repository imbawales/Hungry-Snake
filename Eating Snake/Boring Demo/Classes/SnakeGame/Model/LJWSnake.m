//
//  LJWSnake.m
//  Boring Demo
//
//  Created by apple on 16/12/23.
//  Copyright © 2016年 wales. All rights reserved.
//

#import "LJWSnake.h"

@interface LJWSnake()

@property(nonatomic, assign)CGFloat speed;
@property(nonatomic, assign)CGPoint lastPoint;

@end


@implementation LJWSnake

-(NSMutableArray *)nodesArr{
    if (!_nodesArr) {
        _nodesArr = [NSMutableArray array];
    }
    return _nodesArr;
}

/* 创建蛇的类方法*/
+(instancetype)snake{
    LJWSnake *snake = [[LJWSnake alloc] init];
    snake.snakeLength = 5;
    [snake setNodes];
    return snake;
}


/* 初始化蛇的节点和移动方向 */
-(void)setNodes{
    [self.nodesArr removeAllObjects];
    self.snakeLength = 5;
    for (int i = _snakeLength; i > 0; i--) {
        CGPoint point = CGPointMake(NODEW * (i + 0.5), NODEH * 0.5);
        LJWNode *node = [LJWNode nodeWithCenterPoint:point];
        [self.nodesArr addObject:node];
    }
    _MoveDirection = kMoveDirectionRight;
    
}

//开始
-(void)start{
    CGFloat time = 0.15 + _speed * 0.02;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(move) userInfo:nil repeats:YES];
}


//移动
-(void)move{
    //取出原蛇头Node的坐标
    CGPoint originHeadCenter = self.nodesArr.firstObject.centerPoint;
    
    
    //取出蛇尾Node
    LJWNode *lastNode = self.nodesArr.lastObject;
    self.lastPoint = lastNode.centerPoint;
    
    //更改蛇尾坐标
    switch (self.MoveDirection) {
        case kMoveDirectionUp:
            originHeadCenter.y -= NODEH;
            break;
        case kMoveDirectionDown:
            originHeadCenter.y += NODEH;
            break;
        case kMoveDirectionLeft:
            originHeadCenter.x -= NODEW;
            break;
        case kMoveDirectionRight:
            originHeadCenter.x += NODEW;
            break;
        default:
            break;
    }
    lastNode.centerPoint = originHeadCenter;
    
    //把node数组最后一个元素(蛇尾)移除, 放到数组第一个元素位置
    [self.nodesArr removeLastObject];
    [self.nodesArr insertObject:lastNode atIndex:0];
    
    //吃食物
    if ([self.snakeDelegate respondsToSelector:@selector(eatFood)]) {
        [self.snakeDelegate eatFood];
    }
    
    //重新绘图
    //要想办法拿到controller
    if ([self.snakeDelegate respondsToSelector:@selector(refreshDrawing)]) {
        [self.snakeDelegate refreshDrawing];
    }
}


/*蛇长大*/
-(void)growUp{
    LJWNode *node = [LJWNode nodeWithCenterPoint:self.lastPoint];
    [self.nodesArr addObject:node];
    self.snakeLength += 1;
}

/*游戏结束*/
-(void)pause{
    [self.timer invalidate];
    self.timer = nil;
}
@end
