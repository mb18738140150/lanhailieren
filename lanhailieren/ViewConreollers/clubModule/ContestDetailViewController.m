//
//  ContestDetailViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/4/22.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "ContestDetailViewController.h"
#import "TeamContestTableViewCell.h"
#define kTeamContestTableViewCellID @"TeamContestTableViewCellID"
#import "FoodIntroduce_imageTableViewCell.h"
#define kFoodIntroduce_imageTableViewCellID @"FoodIntroduce_imageTableViewCellID"

#import <WebKit/WebKit.h>

@interface ContestDetailViewController ()<UITableViewDelegate,UITableViewDataSource,WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong)UITableView * tableview;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)NSMutableArray * imageArray;// banner

@property (nonatomic, strong)NSMutableArray * foodDetailArray;
@property (nonatomic, assign)float foodDetailColletionHeight;
@property (nonatomic, strong)NSArray * goodSpecificationArray;
@property (nonatomic, strong)NSArray * specsArray;
@property (nonatomic, strong)NSDictionary * goodInfo;// 商品info
@property (nonatomic, strong)WKWebView * webView;
@property (nonatomic, assign)CGFloat webViewHeight;

@end

@implementation ContestDetailViewController

- (NSMutableArray *)foodDetailArray
{
    if (!_foodDetailArray) {
        _foodDetailArray = [NSMutableArray array];
    }
    return _foodDetailArray;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}
- (void)dealloc
{
    [_webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
    [self.webView stopLoading];
    _webView.UIDelegate = nil;
    _webView.navigationDelegate = nil;
    _webView.scrollView.delegate = nil;
    self.webView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self navigationViewSetup];
    
    [self refreshUI_iPhone];
}

#pragma mark - ui
- (void)navigationViewSetup
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}
- (void)loadData
{
    
}

- (void)refreshUI_iPhone
{
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[TeamContestTableViewCell class] forCellReuseIdentifier:kTeamContestTableViewCellID];
    [self.tableview registerClass:[FoodIntroduce_imageTableViewCell class] forCellReuseIdentifier:kFoodIntroduce_imageTableViewCellID];;
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    self.tableview.backgroundColor = UIColorFromRGB(0xf5f5f5);
    
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 45 - kNavigationBarHeight - kStatusBarHeight)];
    
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    _webView.scrollView.delegate = self;
    _webView.scrollView.scrollEnabled = NO;
    
    NSString *headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'><style>img{max-width:100%}</style></header>";
    
    
    [_webView loadHTMLString:[headerString stringByAppendingString:[self.info objectForKey:@"content"]] baseURL:nil];
    [_webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - tableview delegate & datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 1;
            break;
            
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    
    if (indexPath.section == 0) {
        FoodIntroduce_imageTableViewCell * imageCell = [tableView dequeueReusableCellWithIdentifier:kFoodIntroduce_imageTableViewCellID forIndexPath:indexPath];
        [imageCell refreshUIWithInfo:@{@"imageArray":self.imageArray}];
        imageCell.backFoodIntroduceBlock = ^(BOOL back) {
            [weakSelf.navigationController setNavigationBarHidden:NO animated:NO];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        return imageCell;
        
    }else if (indexPath.section == 1)
    {
        TeamContestTableViewCell * detailCell = [tableView dequeueReusableCellWithIdentifier:kTeamContestTableViewCellID forIndexPath:indexPath];
        [detailCell refreshUIWith:@{@"title":@"海上帆船比赛",@"time":@"2020年5月22日 14：00",@"score1":@"99",@"score2":@"1"}];
        return detailCell;
    }else
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
        [cell.contentView removeAllSubviews];
        [cell.contentView addSubview:self.webView];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return tableView.hd_width * 0.4;
        
    }else if (indexPath.section == 1)
    {
        return 208;
    }
    else{
        return self.webView.frame.size.height;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - scrollView delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"]) {
        if (_webView.scrollView.contentSize.height > self.webViewHeight || _webView.scrollView.contentSize.height == 0) {
            _webViewHeight = _webView.scrollView.contentSize.height;
            _webView.frame = CGRectMake(0, 0, kScreenWidth, _webViewHeight);
            [_tableview reloadData];
        }
    }
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    /*
     //    [webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable Result, NSError * _Nullable error) {
     //        NSString * heightStr = [NSString stringWithFormat:@"%@", Result];
     //        CGFloat height = heightStr.floatValue + 15;
     //        self.webView.frame = CGRectMake(0, 0, kScreenWidth, height);
     //        [self.tableview reloadData];
     //    }];
     
     //    for(UIView * view in webView.subviews)
     //    {
     //        NSLog(@"%@", [view class]);
     //        if ([view isKindOfClass:[NSClassFromString(@"WKScrollView") class]]) {
     //            UIScrollView * scrollView = (UIScrollView *)view;
     //            CGFloat height = scrollView.contentSize.height;
     //            self.webView.frame = CGRectMake(0, 0, kScreenWidth, height);
     //            [self.tableview reloadData];
     //        }
     //
     //    }
     
     */
    
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //    decisionHandler(WKNavigationResponsePolicyCancel);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"%@",navigationAction.request.URL.absoluteString);
    if([navigationAction.request.URL.absoluteString containsString:@"http"])
    {
        //不允许跳转
        decisionHandler(WKNavigationActionPolicyCancel);
    }else
    {
        //允许跳转
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}
#pragma mark - WKUIDelegate
// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    return [[WKWebView alloc]init];
}
// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    completionHandler(@"http");
}
// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    completionHandler(YES);
}
// 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    NSLog(@"%@",message);
    completionHandler();
}


@end
