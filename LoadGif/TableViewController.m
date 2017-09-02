//
//  TableViewController.m
//  LoadGif
//
//  Created by zhongzhi on 2017/9/1.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import "TableViewController.h"
#import "MyCell.h"
#import "MyModel.h"

#import "NextController.h"

#define kCellHeight ceil((Device_Width) * 3.0 / 4.0)
@interface TableViewController ()
@property(nonatomic,strong)NSMutableArray *dataA;
@end

@implementation TableViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[YYImageCache sharedCache].memoryCache removeAllObjects];
    [[YYImageCache sharedCache].diskCache removeAllObjectsWithBlock:^{}];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.tableFooterView =[UIView new];
    self.tableView.rowHeight = kCellHeight;
 
    [self.tableView registerClass:[MyCell class] forCellReuseIdentifier:@"cell"];

    [self responseData];
}
-(void)responseData{
    NSArray *links = @[
                       /*
                        You can add your image url here.
                        */
                       
                       // progressive jpeg
                       @"https://raw.githubusercontent.com/ibireme/YYWebImage/master/Demo/YYWebImageDemo/mew_progressive.jpg",
                       
                       // animated gif: http://cinemagraphs.com/
                       @"http://i.imgur.com/uoBwCLj.gif",
                       @"http://i.imgur.com/8KHKhxI.gif",
                       @"http://i.imgur.com/WXJaqof.gif",
                       
                       // animated gif: https://dribbble.com/markpear
                       @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1780193/dots18.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1809343/dots17.1.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1845612/dots22.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1820014/big-hero-6.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1819006/dots11.0.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1799885/dots21.gif",
                       
                       // animaged gif: https://dribbble.com/jonadinges
                       @"https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/2025999/batman-beyond-the-rain.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/1855350/r_nin.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/1963497/way-back-home.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/1913272/depressed-slurp-cycle.gif",
                       
                       // jpg: https://dribbble.com/snootyfox
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/2047158/beerhenge.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/2016158/avalanche.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1839353/pilsner.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1833469/porter.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1521183/farmers.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1391053/tents.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1399501/imperial_beer.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1488711/fishin.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1466318/getaway.jpg",
                       
                       @"http://littlesvr.ca/apng/images/BladeRunner.png",
                       ];
    [self.dataA removeAllObjects];
    [links enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        MyModel *model =[[MyModel alloc]init];
        model.url = obj;
        model.progress = 0;
        [self.dataA addObject:model];
    }];
    
    [self.tableView reloadData];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataA.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NextController *nextVc =[[NextController alloc]init];
    [self.navigationController pushViewController:nextVc animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.model = self.dataA[indexPath.section];
    return cell;
}
-(NSMutableArray *)dataA{
    if (!_dataA) {
        _dataA =[NSMutableArray array];
    }
    return _dataA;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat viewHeight = scrollView.height + scrollView.contentInset.top;
    for (MyCell *cell in [self.tableView visibleCells]) {
        CGFloat y = cell.centerY - scrollView.contentOffset.y;
        CGFloat p = y - viewHeight / 2;
        CGFloat scale = cos(p / viewHeight * 0.8) * 0.95;
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
            cell.webImageView.transform = CGAffineTransformMakeScale(scale, scale);
        } completion:NULL];
    }
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    for (MyCell *cell in [self.tableView visibleCells]) {
        [cell.webImageView stopAnimating];
    }
}
//-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
//    
//}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    for (MyCell *cell in [self.tableView visibleCells]) {
        [cell.webImageView startAnimating];
    }
}
@end
