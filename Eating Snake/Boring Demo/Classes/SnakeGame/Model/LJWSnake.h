//
//  LJWSnake.h
//  Boring Demo
//
//  Created by apple on 16/12/23.
//  Copyright © 2016年 wales. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LJWNode.h"
#import "LJWSnakeView.h"

#define NODEW 10
#define NODEH 10


typedef enum {
    kMoveDirectionUp,
    kMoveDirectionDown,
    kMoveDirectionLeft,
    kMoveDirectionRight,
} MoveDirection;

@protocol LJWSnakeDelegate <NSObject>

-(void)refreshDrawing;

@end

@interface LJWSnake : NSObject

/*节点数组*/
@property(nonatomic, strong)NSMutableArray <LJWNode *>*nodesArr;
/*移动方向*/
@property (nonatomic, assign) MoveDirection MoveDirection;
/*蛇的长度*/
@property(nonatomic, assign)CGFloat snakeLength;

@property(nonatomic, strong)NSTimer *timer;

@property(nonatomic,weak)id<LJWSnakeDelegate>snakeDelegate;

+(instancetype)snake;
-(void)start;
-(void)gameOver;

@end
