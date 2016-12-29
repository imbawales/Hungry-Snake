//
//  LJWSnakeViewController.h
//  Boring Demo
//
//  Created by apple on 16/12/23.
//  Copyright © 2016年 wales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJWSnakeView.h"
#import "LJWSnake.h"

@interface LJWSnakeViewController : UIViewController
@property (weak, nonatomic) IBOutlet LJWSnakeView *snakeView;
@property(nonatomic, strong)LJWSnake *snake;
@end
