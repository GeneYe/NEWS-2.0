//
//  HomeViewController.m
//  NEWS
//
//  Created by Gene_Ye on 16/10/26.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import "HomeViewController.h"

#import "Content_Model.h"
#import "TopMessageModel.h"

#import "MeunViewController.h"
#import "NewsWebView.h"
#import "RLScrollPic.h"
#import "Content_TableViewCell.h"
#import "SectionTitleView.h"
#import "NewsWebView.h"
#import "GYChouTiXiaoGuo.h"

#import <MJRefreshNormalHeader.h>
#import <MJRefreshAutoNormalFooter.h>
#import "AFNetWorking_Request.h"
#import <UIImageView+WebCache.h>




#define IDENTIFIER @"cell"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,MenuBottomViewDelegate>
{
    BOOL isCreateTopScrollView;
    
    NSDate *_currentDate;
    
    NSInteger day;
    NSInteger month;
    NSInteger year;
    NSInteger weekday;
    
    NSString *_lastNewsUrlStr;
    NSString *_beforeNewsUrlStr;
    
}
@property (nonatomic,strong)NSMutableArray *stories_DataSource;
@property (nonatomic,strong)NSMutableArray *topStroies_DataSource;
@property (nonatomic,strong)NSString *urlStr;
@property (nonatomic,strong)NSMutableArray *topScrollViewPicURL;
@property (nonatomic,strong)NSMutableArray *topTitleData;
@property (nonatomic,strong)NSMutableArray *wholeData;
@property (nonatomic,strong)NSMutableArray *sectionTitleArray;
@property (nonatomic,strong)NSMutableArray *weekdays;

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)RLScrollPic *topScrollPic;
@property (nonatomic,strong)UIView *navigationView;
@property (nonatomic,strong)UIView *bottomNavigationView;

@property (nonatomic,strong)UINavigationController *navigationVC;
@property (nonatomic,strong)MeunViewController *menuViewController;




@end

@implementation HomeViewController

//懒加载dataSource,初始化dataSource
- (NSMutableArray *)weekdays{
    if (!_weekdays) {
        _weekdays = [NSMutableArray arrayWithObjects:@"星期六",@"星期天",@"星期一",@"星期二", @"星期三",@"星期四",@"星期五",nil];
    }
    return _weekdays;
}


- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height/3)];
    }
    return _topView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 , Screen_Width, Screen_Height) style:UITableViewStylePlain];
        _tableView.backgroundColor = GYCommonBgColor;
        
        _tableView.delegate = self;
        
        _tableView.dataSource =self;

        _tableView.tableHeaderView = self.topView;

        _tableView.sectionIndexBackgroundColor = GYNavigationBarColor;
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
            [self getLastContent];
        }];
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self getBeforeContents];
        }];
    }
    return _tableView;
}

- (UIView *)navigationView{
    if (!_navigationView) {
        _navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 20)];
        _navigationView.backgroundColor = GYNavigationBarColor;
        _navigationView.alpha = 0;
    }
    return _navigationView;
}
- (UIView *)bottomNavigationView{
    if (!_bottomNavigationView) {
        _bottomNavigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, Screen_Width, 44)];
        _bottomNavigationView.backgroundColor = GYNavigationBarColor;
        
        _bottomNavigationView.alpha = 0;
    }
    return _bottomNavigationView;
}

- (NSMutableArray *)stories_DataSource{
    
    if (!_stories_DataSource) {
        _stories_DataSource = [NSMutableArray array];
    }
    return _stories_DataSource;
}

- (NSMutableArray *)topStroies_DataSource{
    if (!_topStroies_DataSource) {
        
        _topStroies_DataSource = [NSMutableArray array];
    }
    return _topStroies_DataSource;
}

- (NSMutableArray *)topScrollViewPicURL{
    if (!_topScrollViewPicURL) {
        _topScrollViewPicURL = [NSMutableArray array];
    }
    return _topScrollViewPicURL;
}

- (NSMutableArray *)topTitleData{
    if (!_topTitleData) {
        _topTitleData = [NSMutableArray array];
    }
    return _topTitleData;
}

- (NSMutableArray *)wholeData{
    if (!_wholeData) {
        _wholeData = [NSMutableArray array];
        [_wholeData addObject:self.stories_DataSource];
    }
    return _wholeData;
}

- (NSMutableArray *)sectionTitleArray{
    if (!_sectionTitleArray) {
        _sectionTitleArray = [NSMutableArray array];
    }
    return _sectionTitleArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"changeColor" object:nil];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    _urlStr = @"http://news-at.zhihu.com/api/4/news/latest";
    
    isCreateTopScrollView = YES;
    
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.navigationView];
    [self.view addSubview:self.bottomNavigationView];

    self.title = @"今日热点";
    
    _currentDate = [NSDate date];
    //创建一个NSCalendar(日历牌对象)
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //获取时间的每一部分
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekdayOrdinal|NSWeekdayCalendarUnit;
    NSDateComponents *components = [calendar components:unit fromDate:_currentDate];
    
    weekday = components.weekday;
    day = components.day;
    month = components.month ;
    year = components.year;
    
     _navigationVC = self.navigationController;
    _menuViewController = _navigationVC.parentViewController.childViewControllers[0];
    
    _menuViewController.menuBottomView.delegate = self;
    


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
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"config"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
    
    [self getLastContent];

}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
        NSArray *array = self.wholeData[section];
        
        return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSArray *array = self.wholeData[indexPath.section];
    
    Content_Model *model = [[Content_Model alloc] initWithDictionary:array[indexPath.row]];
        
    Content_TableViewCell *cell = [Content_TableViewCell createTitleAndImageCellWithTableView:tableView Model:model];
    
    cell.title_Label.textColor = _cellTextLabelFontColor;
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.wholeData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section != 0) {
        return 44;
    }
    else{
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = [NSArray arrayWithArray:self.stories_DataSource];
    Content_Model *model = [[Content_Model alloc] initWithDictionary:array[indexPath.row]];
    NSString *urlstr = @"http://news-at.zhihu.com/api/4/news";
    urlstr = [urlstr stringByAppendingFormat:@"/%@",model.Id];
    NewsWebView *newsWebView = [[NewsWebView alloc] init];
    newsWebView.url = urlstr;
    newsWebView.newsId = model.Id;
    
    if (model.images) {
        newsWebView.topViewTitle = model.title;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        _menuViewController.view.frame = CGRectMake(-Menu_Width, 0, Menu_Width, Screen_Height);
        _navigationVC.view.frame = [UIScreen mainScreen].bounds;
    }];
    //跳转到webView
    [self.navigationController pushViewController:newsWebView animated:YES];
    //设置cell在被点击是变色，松手时返回原来颜色
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    SectionTitleView *sectionTitleView = [SectionTitleView initWithSectionViewWithFrame:CGRectMake(0, 0, Screen_Width, 44)];

    sectionTitleView.BeforeNewsTitleLabel.text = self.sectionTitleArray[section - 1];
    return sectionTitleView;
}
#pragma mark 获取最新消息
- (void)getLastContent{
    [AFNetWorking_Request getRequestWithUrl:_urlStr Result:^(id result) {
        [self.stories_DataSource removeAllObjects];
        //顶部滚动视图数据
        [self.topStroies_DataSource addObjectsFromArray:result[@"top_stories"]];
        //结束刷新
        [_tableView.mj_header endRefreshing];
        //内容数据
        [self.stories_DataSource addObjectsFromArray:result[@"stories"]];
        if (isCreateTopScrollView) {
            for (int i = 0; i < self.topStroies_DataSource.count; i++) {
                TopMessageModel *model = [[TopMessageModel alloc] initWithDictionary:self.topStroies_DataSource[i]];
                [self.topScrollViewPicURL addObject:model.image];
                [self.topTitleData addObject:model.title];
            }
            //创建顶部滚动视图
            [self createTopScrollView];
        }
        [_tableView reloadData];
    }];
}

#pragma  mark 获取之前的信息
- (void)getBeforeContents{
    if (day > 1) {
        day -= 1;
        
    }
    else if(day <= 1){
        if (month == 1 && month == 3 && month == 5 && month == 7 && month == 8 && month == 10 && month == 12) {
            day = 31;
            month -= 1;
        }
        else if(month == 2){
            day = 29;
            month -= 1;
        }
        else{
            day = 30;
            month -= 1;
        }
    }
    else if(month == 0){
        month = 12;
        year -= 1;
    }
    weekday -= 1;
    if (weekday < 0) {
        weekday = 6;
    }
    
    NSString *dateStr = [NSString stringWithFormat:@"%ld%ld%.2ld",(long)year,(long)month,(long)day];
    NSString *date = [NSString stringWithFormat:@"%ld月%ld日  %@",(long)month,(long)day,self.weekdays[weekday]];
    
    NSString *urlStr = @"http://news.at.zhihu.com/api/4/news/before";
    
    urlStr = [urlStr stringByAppendingFormat:@"/%@",dateStr];
    
    [AFNetWorking_Request getRequestWithUrl:urlStr Result:^(id result) {
        
        [self.sectionTitleArray addObject:date];

        NSArray *array = result[@"stories"];
        [self.wholeData addObject:array];

        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}
#pragma  mark 创建头部滚动视图
- (void)createTopScrollView{
    _topScrollPic = [[RLScrollPic alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height/3) WithImageName:self.topScrollViewPicURL];
    _topScrollPic.titleData = self.topTitleData;
    _topScrollPic.AutoScrollDelay = 3.0;

    __weak typeof(id) weakself = self;
    _topScrollPic.imageViewTapAtIndex = ^(NSInteger index){
        [weakself clickTopScrollViewWithIndex:index];
    };
    
    [self.tableView addSubview:_topScrollPic];
    
    isCreateTopScrollView = NO;
}

- (void)clickTopScrollViewWithIndex:(NSInteger)index{
    
    NSString *urlstr = @"http://news-at.zhihu.com/api/4/news";
    
    TopMessageModel *model = [[TopMessageModel alloc] initWithDictionary:self.topStroies_DataSource[index]];
    
    urlstr = [urlstr stringByAppendingFormat:@"/%@",model.Id];
    NewsWebView *webView = [[NewsWebView alloc] init];
    webView.url = urlstr;
    webView.newsId = model.Id;
    webView.topViewTitle = model.title;
    webView.topViewImageUrlStr = model.image;
    //跳转到webView
    [self.navigationController pushViewController:webView animated:YES];
}

#pragma mark 抽屉效果
- (void)showMenu:(UIBarButtonItem *)sender{
    if (_navigationVC.view.center.x != Screen_Width/2) {        
        [GYChouTiXiaoGuo chouTiHideWithChouTiView:_menuViewController.view homeView:_navigationVC.view];
    }
    else{
        [GYChouTiXiaoGuo chouTiAppearWithChouTiView:_menuViewController.view homeView:_navigationVC.view];
    }
}

#pragma mark 添加手势
- (void)addSwipeGestureRecognizer{
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeGestureAction)];
    
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:leftSwipe];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeGestureAction)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:rightSwipe];
}

- (void)rightSwipeGestureAction{
    [GYChouTiXiaoGuo chouTiAppearWithChouTiView:_menuViewController.view homeView:_navigationVC.view];
}

- (void)leftSwipeGestureAction{
    [GYChouTiXiaoGuo chouTiHideWithChouTiView:_menuViewController.view homeView:_navigationVC.view];
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat count = 90 * self.stories_DataSource.count + Screen_Height/3 - 20;
    
    if (offsetY > 1) {
        CGFloat alpha = MIN(1, (Screen_Height/3  + offsetY)/Screen_Height);
        self.navigationView.alpha = alpha;
        self.bottomNavigationView.alpha = alpha;
        
        //如果大于成立，则section的header已经到达导航栏位置，这里应该将bottomNavigationView隐藏
        if (offsetY > count) {
            self.bottomNavigationView.alpha = 0;
            self.title = @"";
            self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
            self.tableView.RL_Height = Screen_Height - 20;
        }
        else{
            self.title = @"今日热闻";
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }
    }
    else{
        self.navigationView.alpha = 0;
        self.bottomNavigationView.alpha = 0;
        
        }

}


#pragma mark 


- (void)getCellBackgroundColor:(UIColor *)cellBackgroundColor{
    
    
    self.tableView.backgroundColor = cellBackgroundColor;
    
}


























- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
