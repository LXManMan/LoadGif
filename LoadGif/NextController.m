
//
//  NextController.m
//  LoadGif
//
//  Created by zhongzhi on 2017/9/1.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import "NextController.h"
#import <YYWebImage.h>
@interface NextController ()
@end

@implementation NextController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    
    YYAnimatedImageView *imageView = [YYAnimatedImageView new];
    imageView.frame = CGRectMake(20, 100, 200, 200);
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    imageView.yy_imageURL = [NSURL URLWithString:@"http://upload-images.jianshu.io/upload_images/1694376-b9646eecf2139f87.gif"];
   
    
    [imageView yy_setImageWithURL:[NSURL URLWithString:@"http://i.imgur.com/8KHKhxI.gif"]
                          placeholder:nil
                              options:YYWebImageOptionProgressiveBlur | YYWebImageOptionShowNetworkActivity | YYWebImageOptionSetImageWithFadeAnimation
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 if (expectedSize > 0 && receivedSize > 0) {

                                 }
                             }
                            transform:nil
                           completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {

                               NSLog(@"%ld",stage);
                           }];
    

}



@end
