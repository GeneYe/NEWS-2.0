//
//  NewsWebView.m
//  NEWS
//
//  Created by Gene_Ye on 2016/11/2.
//  Copyright © 2016年 Gene. All rights reserved.
//

#import "NewsWebView.h"
#import "WebModel.h"
#import "AFNetWorking_Request.h"
#import "BottomToolBarView.h"
#import "CommentViewController.h"
#import "NewsWebViewTopView.h"
#import <UIImageView+WebCache.h>


@interface NewsWebView ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIWebView *webView;

@property (nonatomic,strong)BottomToolBarView *bottomToolBarView;

@property (nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,strong)NewsWebViewTopView *topView;

@property (nonatomic,strong)NSString *topViewImageUrlString;



@end

@implementation NewsWebView
//懒加载
- (UIWebView *)webView{
    
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - 49)];

        _webView.scrollView.delegate = self;
        
        [self.view addSubview:_webView];

    }
    return _webView;
}

- (BottomToolBarView *)bottomToolBarView{
    if (!_bottomToolBarView) {
        _bottomToolBarView = [BottomToolBarView initCustomWithframe:CGRectMake(0, Screen_Height - 49, Screen_Width, 49)];

        _bottomToolBarView.themeNavigationController = self.navigationController;
        
        CommentViewController *commentViewController = [CommentViewController new];
        _bottomToolBarView.commentViewConroller = commentViewController;
    }
    return _bottomToolBarView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [AFNetWorking_Request getRequestWithUrl:self.url Result:^(id result) {
        WebModel *model = [[WebModel alloc] initWithDict:result];
        NSLog(@"%@",result);
        NSString *html = [self createHTMLWithWebModel:model];
        [self.webView loadHTMLString:html baseURL:nil];
        if (model.image) {
            self.topViewImageUrlString = model.image;
            _topView = [NewsWebViewTopView initCustomNewsWebViewTopViewWithFrame:CGRectMake(0, 0, Screen_Width, (Screen_Height - 49)/3) ImageUrlString:self.topViewImageUrlString Title:self.topViewTitle];
            [self.view addSubview:_topView];
        }
        
    }];
    [self.view addSubview:self.bottomToolBarView];
    //网络请求
    [self netWrokRequest];
    
    

}


//解析HTML
- (NSString *)createHTMLWithWebModel:(WebModel *)model{
    
    NSMutableString *cssLink = [NSMutableString string];
    [model.css enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *css = [NSString stringWithFormat:@"<link type=\"text/css\" rel=\"stylesheet\" href=\"%@\">\n",obj];
        
        [cssLink appendString:css];
    }];
    
    return [NSString stringWithFormat:@"<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"UTF-8\"><meta name=\"viewport\" id=\"viewport\" content=\"width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\">%@<title>%@</title></head><body>%@</body></html>", cssLink, model.title,model.body];
    
}

- (void)netWrokRequest{
    //http://news-at.zhihu.com/api/4/story-extra/#{id}
    NSString *str = @"http://news-at.zhihu.com/api/4/story-extra/";
    
    NSString *urlStr = [str stringByAppendingFormat:@"%@",self.newsId];

    [AFNetWorking_Request getRequestWithUrl:urlStr Result:^(id result) {
        NSString *count = [NSString stringWithFormat:@"%@",result[@"comments"]];
        self.bottomToolBarView.commentCountLabel.text = count;
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //隐藏导航栏以及"back"item
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:nil]];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationItem.hidesBackButton = YES;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y > 1) {
        _topView.RL_y = - scrollView.contentOffset.y ;
    }
    else{
        _topView.RL_Height = (Screen_Height - 49)/3 - scrollView.contentOffset.y;
    }
}



























@end
