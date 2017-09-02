//
//  MyCell.m
//  LoadGif
//
//  Created by zhongzhi on 2017/9/1.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import "MyCell.h"
#import "LXCircle.h"
#import "YYImageExampleHelper.h"

#define kCellHeight ceil((Device_Width) * 3.0 / 4.0)

@interface MyCell()<UIGestureRecognizerDelegate>

@property(nonatomic,strong)UIView *topContainer;
@property(nonatomic,strong)LXCircle *pathView;

@end
@implementation MyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.backgroundColor =[UIColor clearColor];
        self.contentView.backgroundColor =[UIColor clearColor];
        
        self.size = CGSizeMake(Device_Width, kCellHeight);
        self.contentView.size = CGSizeMake(Device_Width, kCellHeight);
        
        
       
        [self setup];
        
        self.pathView.progress = 0;
//        self.pathView.progress =  0.5;
    }
    return  self;
}
-(void)setup{
    [self.contentView addSubview:self.webImageView];
    
    [self.webImageView addSubview:self.topContainer];
    [self.topContainer addSubview:self.pathView];
   
}
-(void)setModel:(MyModel *)model{
    _model = model;
    
    self.pathView.progress = model.progress;
    if (model.progress <=1.0) {
       [self delayAction];
    }
    
   
}
-(void)delayAction{
    
    self.topContainer.hidden = NO;
    [self.webImageView yy_setImageWithURL:[NSURL URLWithString:_model.url] placeholder:nil options:YYWebImageOptionProgressiveBlur |YYWebImageOptionShowNetworkActivity progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (receivedSize >0 && expectedSize >0) {
            CGFloat progress = (CGFloat)receivedSize / expectedSize;
                       NSLog(@"%.2f",progress);
            self.pathView.progress = progress;
            self.model.progress = progress;
        }
        
    } transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (stage == YYWebImageStageFinished) {

            self.topContainer.hidden = YES;
            [YYImageExampleHelper addTapControlToAnimatedImageView:self.webImageView];
            [YYImageExampleHelper addPanControlToAnimatedImageView:self.webImageView];
            for (UIGestureRecognizer *g in self.webImageView.gestureRecognizers) {
                g.delegate = self;
            }
        }
        
    }];

}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

-(YYAnimatedImageView *)webImageView{
    if (!_webImageView) {
        _webImageView =[[YYAnimatedImageView alloc]initWithFrame:CGRectMake(0, 0, self.size.width, self.size.height)];
        _webImageView.contentMode = UIViewContentModeScaleAspectFill;
        _webImageView.clipsToBounds = YES;
        _webImageView.backgroundColor = [UIColor whiteColor];
        
    }
    return _webImageView;
}
-(UIView *)topContainer{
    if (!_topContainer) {
        _topContainer =[[UIView alloc]initWithFrame:self.bounds];
        _topContainer.backgroundColor =[[UIColor grayColor]colorWithAlphaComponent:0.2];
    }
    return _topContainer;
}
-(LXCircle *)pathView{
    if (!_pathView) {
        _pathView = [[LXCircle alloc]initWithFrame:CGRectMake(0, 0, self.height *0.5, self.height *0.5) lineWidth:20];
        _pathView.center = self.topContainer.center;
        
        _pathView.backgroundColor =[UIColor clearColor];
    }
    return _pathView;
}
@end
