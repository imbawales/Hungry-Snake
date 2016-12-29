//
//  LJWSnakeViewController.m
//  Boring Demo
//
//  Created by apple on 16/12/23.
//  Copyright © 2016年 wales. All rights reserved.
//

#import "LJWSnakeViewController.h"

@interface LJWSnakeViewController()<LJWSnakeDelegate>
@property (weak, nonatomic) IBOutlet UILabel *ScoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property(strong, nonatomic)UIImageView *food;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel2;

@end

@implementation LJWSnakeViewController

-(UIImageView *)food{
    if (!_food) {
        _food = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, NODEW, NODEH)];
        _food.image = [UIImage imageNamed:@"caomei"];
        [self.snakeView addSubview:_food];
    }
    return _food;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    //创建蛇对象
    self.snake = [LJWSnake snake];
    self.snakeView.snake = self.snake;
    self.snake.snakeDelegate = self;
    
    
    //改字体
    self.ScoreLabel.font = [UIFont fontWithName:@"Marker Felt" size:25];
    self.scoreLabel2.font = [UIFont fontWithName:@"Marker Felt" size:25];

    
    //改开始暂停按钮
    [self.startBtn setTitle:@"Start" forState:UIControlStateNormal];
    [self.startBtn setTitle:@"Pause" forState:UIControlStateSelected];
    
    
    //创建食物
    [self createFood];

}

/*创建食物*/
-(void)createFood{
    int x = (arc4random() % 20) * NODEW + NODEW * 0.5;
    int y = (arc4random() % 30) * NODEH + NODEH * 0.5;
    CGPoint center = CGPointMake(x, y);
    for (LJWNode *node in _snake.nodesArr) {
        if (CGPointEqualToPoint(center, node.centerPoint)) {
            [self createFood];
            return;
        }
    }
    self.food.center = center;
}

/*点击开始或者暂停*/
- (IBAction)startBtnClick:(UIButton *)btn {
    if (btn.selected == YES) {
        [self.snake.timer invalidate];
        self.snake.timer = nil;
    }else{
        [self.snake start];
    }
    btn.selected = !btn.selected;
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

//蛇吃了食物
-(void)eatFood{  //判断食物的坐标是否和蛇头坐标一样,  一样就表示吃了
    if (CGPointEqualToPoint(self.food.center, self.snake.nodesArr.firstObject.centerPoint)) {
        //分数+1
        NSInteger score = self.scoreLabel2.text.intValue + 1;
        self.scoreLabel2.text = [NSString stringWithFormat:@"%ld", score];
        //重新创建食物
        [self createFood];
        //蛇变长
        [self.snake growUp];
    }
}

//游戏结束
-(void)gameOver{
    [self.snake pause];
    NSString *str = [NSString stringWithFormat:@"你输了!! 你只有%@分!", self.scoreLabel2.text];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示!"message:str preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"重玩" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"我重新玩");
        
        [self.snake setNodes];
        [self.snake start];
        self.scoreLabel2.text = @"0";
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"不玩了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"我不玩了");
        self.startBtn.selected = NO;
        [self.snake setNodes];
        [self refreshDrawing];
        self.scoreLabel2.text = @"0";
    }];
    
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
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
            [self gameOver];
        }
    }
    //如果碰到左右边界
    if (node.centerPoint.x < 5 || node.centerPoint.x > [UIScreen mainScreen].bounds.size.width) {
        [self gameOver];
    }
    //如果碰到上下边界
    if (node.centerPoint.y < 5 || node.centerPoint.y > [UIScreen mainScreen].bounds.size.height - 220) {
        [self gameOver];
    }
}



@end
