//
//  MeunViewController.m
//  NEWS
//
//  Created by Gene_Ye on 2016/10/31.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import "MeunViewController.h"
#import "HomeViewController.h"

#import "Theme_RootViewController.h"
#import "ViewController.h"
#import "MenuTopView.h"
#import "MenuThemeTitleListTableViewCell.h"
#import "MenuThemeListHomeTitleTableViewCell.h"



#import "Themes_Model.h"
#import "ThemeTitle_Model.h"

#import "AFNetWorking_Request.h"

@interface MeunViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,strong)UITableView *titleList_tableView;

@property (nonatomic,strong)NSMutableArray *themeIdArray;

@property (nonatomic,assign)NSInteger currentIndexPathRow;

@property (nonatomic,strong)MenuTopView *menuTopView;

@property (nonatomic,assign)BOOL isAppear;

@property (nonatomic,strong)UIColor *cellBackgroundColor;
@property (nonatomic,strong)UIColor *cellTextLabelFontColor;

@end

@implementation MeunViewController

- (NSMutableArray *)themeIdArray{
    if (!_themeIdArray) {
        _themeIdArray = [NSMutableArray array];
    }
    return _themeIdArray;
}

- (NSInteger)currentIndexPathRow{
    if (!_currentIndexPathRow) {
        _currentIndexPathRow = 0;
    }
    return _currentIndexPathRow;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        /*
         "color":9699556,
         "thumbnail":"http://pic2.zhimg.com/98d7b4f8169c596efb6ee8487a30c8ee.jpg",
         "description":"把黑客知识科普到你的面前",
         "id":10,
         "name":"互联网安全"
         */
        NSDictionary *homeDic = @{@"color":@"",@"thumbnail":@"",@"description":@"",@"id":@"30",@"name":@"首页"};
      
        [_dataSource addObject:homeDic];
    }
    return _dataSource;
}

- (MenuTopView *)menuTopView{
    if (!_menuTopView) {
        
        _menuTopView = [MenuTopView createMenuTopViewWithFrame:CGRectMake(0, 20, Menu_Width, 110)];
    }
    return _menuTopView;
}

- (MenuBottomView *)menuBottomView{
    if (!_menuBottomView) {
        _menuBottomView = [MenuBottomView createCustomBottomViewWithFrame:CGRectMake(0, Screen_Height - 70, Menu_Width, 70)];

    }
    return _menuBottomView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"changeColor" object:nil];
    
    _isAppear = YES;
    
    self.view.backgroundColor = GYCommonBgColor;

    [self.view addSubview:self.menuTopView];

    [self.view addSubview:self.menuBottomView];
    
    [self getThemeTitleList];
    
    [self createTableView];
    
}

- (void)createTableView{
    
    _titleList_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 130, Menu_Width, Screen_Height - 130 - 60) style:UITableViewStylePlain];
    
    //注册单元格
    [_titleList_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Identifier"];
    //去除单元格下划线
    _titleList_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _titleList_tableView.backgroundColor = [UIColor colorWithRed:35/255.0 green:42/255.0 blue:48/255.0 alpha:1.0];

    _titleList_tableView.delegate = self;
    _titleList_tableView.dataSource = self;
    
    _titleList_tableView.showsVerticalScrollIndicator = NO;
    _titleList_tableView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:_titleList_tableView];
    
}

- (void)getThemeTitleList{
    [AFNetWorking_Request getRequestWithUrl:@"http://news-at.zhihu.com/api/4/themes" Result:^(id result) {
        
        NSArray *array = result[@"others"];
        for (int i = 0 ; i < array.count; i++) {
            
            [self.dataSource addObject:array[i]];

            [_titleList_tableView reloadData];
        }
    }];

}

#pragma mark ----UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
        return self.dataSource.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ThemeTitle_Model *model = [[ThemeTitle_Model alloc] initWithDictionary:self.dataSource[indexPath.row]];
    
    if (indexPath.row == 0) {
        MenuThemeListHomeTitleTableViewCell *cell = [MenuThemeListHomeTitleTableViewCell createMenuThemeListHomeTitleWithTableView:tableView Model:model];
        
        return cell;
    }
    else{
        MenuThemeTitleListTableViewCell *cell = [MenuThemeTitleListTableViewCell createMeunThemeListExceptHomeWithTableView:tableView Model:model];
        cell.backgroundColor = GYCommonBgColor;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

#pragma mark 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //整理个主题日报的id
    ThemeTitle_Model *titleModel = [[ThemeTitle_Model alloc] initWithDictionary:self.dataSource[indexPath.row]];
    //首页View
    UINavigationController *navigationVC = self.parentViewController.childViewControllers[1];
    //主题
    Theme_RootViewController *themeViewController = self.themeViewControllersArray[indexPath.row];
    
    //判断点击的主题是否就是当前的主题
    if (indexPath.row == self.currentIndexPathRow) {
        //动画抽屉效果
        [UIView animateWithDuration:0.4 animations:^{
            self.view.RL_x = -Menu_Width;
            _titleList_tableView.RL_Width = Menu_Width;
            navigationVC.view.RL_x = 0;
        }];
        //如果是，则直接返回
        return;
    }
    else{
        //判断点击的地方是否是首页（因为首页有属于自己的视图控制器，所以不需要到主题日报控制器请求数据）
        if (indexPath.row == 0) {
            
            self.currentIndexPathRow = indexPath.row;
            //首页为navigatonController栈里的第一个元素，所以只能使用pop方法。
            [navigationVC popToViewController:[navigationVC.viewControllers objectAtIndex:0] animated:NO];
            //抽屉动画
            [UIView animateWithDuration:0.4 animations:^{
                self.view.RL_Width = Screen_Width;
                _titleList_tableView.RL_Width = Screen_Width;
                navigationVC.view.RL_x = Screen_Width;
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:0.2 animations:^{
                    self.view.RL_x = -Menu_Width;
                    _titleList_tableView.RL_Width = Menu_Width;
                    navigationVC.view.RL_x = 0;
                }];
            }];
            
        }
        
        else{
            //遍历navigationController的controller栈，查看是否需要跳转的控制器是否已经在栈内
            for (int i = 0; i < navigationVC.viewControllers.count; i++) {
                //如果是，怎使用pop方法;
                if (navigationVC.viewControllers[i] == themeViewController) {
                    _isAppear = YES;
                    [navigationVC popToViewController:themeViewController animated:NO];
                    break;
                }
                else{
                    //如果不是，则传出一个bool值
                    _isAppear = NO;
                }
            }
            //判断bool值，然后使用pop方法
            if (!_isAppear) {

                [navigationVC pushViewController:themeViewController animated:NO];
                
            }
            themeViewController.cellBackgroundColor = _cellBackgroundColor;
            themeViewController.cellTextLabelFontColor = _cellTextLabelFontColor;
            themeViewController.titleId = titleModel.Id;
            themeViewController.titleName = titleModel.name;
            
            self.currentIndexPathRow = indexPath.row;
            //跳转动画
            [UIView animateWithDuration:0.4 animations:^{
                    self.view.RL_x = -Menu_Width;
                _titleList_tableView.RL_Width = Menu_Width;
                    navigationVC.view.RL_x = 0;
                }];
            }
        }
}

- (void)changeColor:(NSNotification *)notification{
    
    _cellBackgroundColor = notification.userInfo[@"backgroundColor"];
    _cellTextLabelFontColor = notification.userInfo[@"fontColor"];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

        
























@end
