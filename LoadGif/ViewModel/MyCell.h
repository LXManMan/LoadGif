//
//  MyCell.h
//  LoadGif
//
//  Created by zhongzhi on 2017/9/1.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyModel.h"
@interface MyCell : UITableViewCell
@property(nonatomic,strong)YYAnimatedImageView *webImageView;
@property(nonatomic,strong)MyModel *model;
@end
