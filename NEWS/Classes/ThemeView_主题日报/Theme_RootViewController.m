//
//  Theme_RootViewController.m
//  NEWS
//
//  Created by Gene_Ye on 2016/11/1.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import "Theme_RootViewController.h"
#import "HomeViewController.h"
#import "MeunViewController.h"
#import "NewsWebView.h"
#import <MJRefreshNormalHeader.h>
#import "GYChouTiXiaoGuo.h"

#import "Content_TableViewCell.h"  //自定义cell
#import "OnlyTextTableViewCell.h"  //自定义cell
#import "EditorsTableViewCell.h"

#import <UIImageView+WebCache.h>
#import "AFNetWorking_Request.h"

#import "Themes_Model.h"           // 主题内容model
#import "Content_Model.h"


@class MeunViewController;
#define bgImageScale  648/768.0
#define bgImageWidth Screen_Width
#define bgImageHeight bgImageWidth * bgImageScale

@interface Theme_RootViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)UIImageView *backgroundView;

@property (nonatomic,strong)NSString *bgcImageUrl;

@property (nonatomic,strong)MeunViewController *menuVC;

@property (nonatomic,strong)UINavigationController *navigationVC;

@end

@implementation Theme_RootViewController


- (UIImageView *)backgroundView{
    if (!_backgroundView) {
//        _backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0,-80, bgImageWidth, bgImageHeight)];
    _backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, bgImageWidth, 64)];
//    _backgroundView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backgroundView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height - 64) style:UITableViewStylePlain];
//        _tableView.backgroundColor = [UIColor whiteColor];
        
        //设置代理属性
        _tableView.delegate =self;
        _tableView.dataSource = self;
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [self getContentDataWithTitleID:self.titleId];
        }];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"changeColor" object:nil];

    _navigationVC = self.navigationController;
    
    _menuVC = _navigationVC.parentViewController.childViewControllers[0];

    [self getContentDataWithTitleID:self.titleId];
    
    [self.view addSubview:self.backgroundView];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.backgroundColor = _cellBackgroundColor;
    
    
}

- (void)changeColor:(NSNotification *)notification{
    
    _cellBackgroundColor = notification.userInfo[@"backgroundColor"];
    _cellTextLabelFontColor = notification.userInfo[@"fontColor"];

    self.tableView.backgroundColor = _cellBackgroundColor;
    
    [self.tableView reloadData];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewWillAppear:(BOOL)animated{
    
    [self addSwipeGestureRecognizer];
    
    self.title = self.titleName;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"config"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
}

- (void)viewWillDisappear:(BOOL)animated{
//    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    view.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:view];
//    [UIView animateWithDuration:0.5 animations:^{
//        view.RL_y = Screen_Height;
//    }];
}

#pragma mark NSNotification
- (void)getContentDataWithTitleID:(NSNumber *)ID{
    
    [self.dataSource removeAllObjects];
    
    NSString *urlStr = @"http://news-at.zhihu.com/api/4/theme";
    //获得主题日报内容请求api
    NSString *urlStrWithId = [urlStr stringByAppendingFormat:@"/%@",ID];

    [AFNetWorking_Request getRequestWithUrl:urlStrWithId Result:^(id result) {
        
        NSArray *editorsArray = [NSArray arrayWithArray:result[@"editors"]];
    
        [self.dataSource addObject:editorsArray];
        //设置背景图
        [self.backgroundView sd_setImageWithURL:[NSURL URLWithString:result[@"background"]]];
        //处理内容数组
        NSArray *array = result[@"stories"];
        [self.dataSource addObjectsFromArray:array];
        
        [_tableView.mj_header endRefreshing];
        
        [_tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *array = [NSArray arrayWithArray:self.dataSource];
    
    if (indexPath.row == 0) {
        EditorsTableViewCell *cell = [EditorsTableViewCell createEditorsTableViewCellWithTableView:tableView EditorsArray:self.dataSource[0]];
        cell.textLabel.textColor = _cellTextLabelFontColor;
        return cell;
    }
        else{
            Themes_Model *model = [[Themes_Model alloc] initWithDictionary:array[indexPath.row]];
            //判断请求回来的数据是否有image
            if (model.images == NULL) {
                
                OnlyTextTableViewCell *cell = [OnlyTextTableViewCell createOnlyTextTableViewCellWithTableView:tableView Model:model];
                cell.titleLabel.textColor = _cellTextLabelFontColor;
                
                return cell;
            }
            else{

                Content_TableViewCell *cell = [Content_TableViewCell createTitleAndImageCellWithTableView:tableView Model:(Content_Model *)model];
                cell.title_Label.textColor = _cellTextLabelFontColor;
                return cell;
            }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 40;
    }
    else{
        return 90;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        NSLog(@"1111");
    }
    else{
    NSArray *array = [NSArray arrayWithArray:self.dataSource];
    Themes_Model *model = [[Themes_Model alloc] initWithDictionary:array[indexPath.row]];
    NSString *urlstr = @"http://news-at.zhihu.com/api/4/news";
    urlstr = [urlstr stringByAppendingFormat:@"/%@",model.Id];
    NewsWebView *newsWebView = [[NewsWebView alloc] init];
    //属性传值
    newsWebView.url = urlstr;
    newsWebView.newsId = model.Id;
    //跳转到webView
    [self.navigationController pushViewController:newsWebView animated:YES];
    //抽屉效果
    [UIView animateWithDuration:0.4 animations:^{
        
        _navigationVC.view.RL_x = 0;
        
        _menuVC.view.frame = CGRectMake(-Menu_Width, 0, Menu_Width, Screen_Height);
    }];
    }
    //设置cell在被点击是变色，松手时返回原来颜色
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark 抽屉效果
- (void)showMenu:(UIBarButtonItem *)sender{
    
    if (_navigationVC.view.center.x != Screen_Width/2) {

        [GYChouTiXiaoGuo chouTiHideWithChouTiView:_menuVC.view homeView:_navigationVC.view];
    }
    else{
        [GYChouTiXiaoGuo chouTiAppearWithChouTiView:_menuVC.view homeView:_navigationVC.view];
    }
}
- (void)addSwipeGestureRecognizer{
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeGestureAction)];
    
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:leftSwipe];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeGestureAction)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:rightSwipe];
}

- (void)rightSwipeGestureAction{
    [GYChouTiXiaoGuo chouTiAppearWithChouTiView:_menuVC.view homeView:_navigationVC.view];
}

- (void)leftSwipeGestureAction{
    [GYChouTiXiaoGuo chouTiHideWithChouTiView:_menuVC.view homeView:_navigationVC.view];
}



#pragma mark UIScrollViewDelegate
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    CGRect bgcImageViewFrame = self.backgroundView.frame;
//    CGRect scrollViewFrame = scrollView.frame;
//    
//    if(scrollView.contentOffset.y < 0){
//        
//        CGFloat offsetY = (scrollView.contentOffset.y ) * -1;
//        
//        bgcImageViewFrame.origin.y = - offsetY * 0.2 - 80;
////        bgcImageViewFrame.origin.y = 0;
////        bgcImageViewFrame.size.height = 64 + offsetY;
//        scrollViewFrame.origin.y = - offsetY * 0.2 - 80;
//        self.backgroundView.frame = bgcImageViewFrame;
//    }
//
//
//}





@end
