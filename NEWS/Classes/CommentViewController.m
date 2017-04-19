//
//  CommentViewController.m
//  NEWS
//
//  Created by Gene_Ye on 2016/11/3.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentBottomToolBarView.h"
#import "AFNetWorking_Request.h"

@interface CommentViewController ()

@property (nonatomic,strong)CommentBottomToolBarView *commentBottomToolBar;

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation CommentViewController

- (UITableView *)tableView{
    if (_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height - 64 -40) style:UITableViewStylePlain];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
        
    }
    return _tableView;
}


- (CommentBottomToolBarView *)commentBottomToolBar{
    if (!_commentBottomToolBar) {
        _commentBottomToolBar = [CommentBottomToolBarView initCustomWithFrame:CGRectMake(0, Screen_Height - 40, Screen_Width, 40)];
        
        _commentBottomToolBar.webViewNavigationController = self.navigationController;
    }
    return _commentBottomToolBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.commentBottomToolBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor cyanColor];
    
    [super viewWillAppear:animated];
    //隐藏导航栏以及"back"item
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:nil]];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationItem.hidesBackButton = YES;
    
}

#pragma mark UITableViewDataSource

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//}

#pragma mark 网络请求

- (void)getComments{
    
}



@end
