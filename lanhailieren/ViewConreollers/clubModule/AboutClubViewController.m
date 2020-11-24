//
//  AboutClubViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/4/29.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "AboutClubViewController.h"

#import <WebKit/WebKit.h>

@interface AboutClubViewController ()<WKUIDelegate,WKNavigationDelegate,HYSegmentedControlDelegate,UIScrollViewDelegate,UserModule_ChannelListProtocol,UserModule_ChannelDetailProtocol,HYSegmentedControlDelegate>

@property (nonatomic, strong)WKWebView * webView;
@property (nonatomic, assign)CGFloat webViewHeight;
@property (nonatomic, strong)HYSegmentedControl * segmentC;

@property (nonatomic, strong)NSArray * datasource;
@property (nonatomic, strong)NSMutableArray * titleArray;

@end

@implementation AboutClubViewController

- (NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self navigationViewSetup];
    
    if ([[UserManager sharedManager] getAboutClubCategoryList] <= 0) {
        [self loadData];
    }else
    {
        [self refreshUI_iPhone];
    }
}

#pragma mark - ui
- (void)navigationViewSetup
{
    
    self.navigationItem.title = @"关于俱乐部";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.barTintColor = kCommonNavigationBarColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kCommonMainTextColor_50};
    TeamHitBarButtonItem * leftBarItem = [TeamHitBarButtonItem leftButtonWithImage:[UIImage imageNamed:@"public-返回"] title:@""];
    [leftBarItem addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBarItem];
}
- (void)backAction:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)loadData
{
    [SVProgressHUD dismiss];
    [[UserManager sharedManager] didRequestAboutClubListWithInfo:@{@"command":@30,@"channel_name":@"club",@"category_id":@0,@"page_size":@(10),@"page_index":@(1),@"key":@"",@"sort":@"0",@"is_red":@0} withNotifiedObject:self];
}

- (void)refreshUI_iPhone
{
    if (self.segmentC) {
        return;
    }
    CGFloat left = 100;
    if (self.titleArray.count < 4) {
        left = (kScreenWidth - 100 * self.titleArray.count) / 2;
    }else
    {
        left = 15;
    }
    
    self.segmentC = [[HYSegmentedControl alloc] initWithOriginX:left OriginY:0 Titles:self.titleArray delegate:self drop:NO color:kMainRedColor];
    [self.segmentC hideBottomBackLine];
    [self.view addSubview:self.segmentC];
    
    NSString * jsString = @"var objs = document.getElementsByTagName('img');for(var i=0;i++){var img = objs[i];img.style.maxWidth = '100%';img.style.height='auto';}";
    WKUserScript *wkUScriptImg = [[WKUserScript alloc] initWithSource:jsString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    
    //注入
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];

    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScriptImg];
    [wkUController addUserScript:wkUScript];

    //配置对象
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    // 创建设置对象
//    WKPreferences *preference = [[WKPreferences alloc]init];
//    preference.javaScriptCanOpenWindowsAutomatically = true;
//    // 设置字体大小(最小的字体大小)
//    preference.minimumFontSize = 58 ;
//    // 设置偏好设置对象
//    wkWebConfig.preferences = preference;


    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 42, kScreenWidth, kScreenHeight - 42 - kNavigationBarHeight - kStatusBarHeight)];
    
//    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 42, kScreenWidth, kScreenHeight - 42 - kNavigationBarHeight - kStatusBarHeight)];
    
    
    
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    _webView.scrollView.delegate = self;
    [_webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.view addSubview:_webView];
}

- (void)didRequestChannelListSuccessed
{
    if ([[[UserManager sharedManager] getAboutClubList] count] <= 0) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"暂无数据"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [self.navigationController popViewControllerAnimated:YES];
        });
    }else
    {
        [self.titleArray removeAllObjects];
        self.datasource = [[UserManager sharedManager] getAboutClubList];
        for (NSDictionary * info in self.datasource) {
            [self.titleArray addObject:[info objectForKey:@"title"]];
        }
        
        [[UserManager sharedManager] didRequestAboutClubDetailWithInfo:@{@"command":@31,@"channel_name":@"club",@"id":[[self.datasource objectAtIndex:0] objectForKey:@"id"]} withNotifiedObject:self];
        
        [self refreshUI_iPhone];
    }
}

- (void)didRequestChannelListFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestChannelDetailSuccessed
{
    [SVProgressHUD dismiss];
    NSLog(@"%@", [[[UserManager sharedManager] getAboutClubDetail] objectForKey:@"content"]);
    
    NSString *displayContent = [NSString stringWithFormat:@"<span style=\"text-align:justify; text-justify:inter-ideograph;\">%@",[[[UserManager sharedManager] getAboutClubDetail] objectForKey:@"content"]];
    [_webView loadHTMLString:[[[UserManager sharedManager] getAboutClubDetail] objectForKey:@"content"] baseURL:nil];
}

- (void)didRequestChannelDetailFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
//    if ([keyPath isEqualToString:@"contentSize"]) {
//        if (_webView.scrollView.contentSize.height > self.webViewHeight || _webView.scrollView.contentSize.height == 0) {
//            _webViewHeight = _webView.scrollView.contentSize.height;
//            _webView.frame = CGRectMake(0, 40, kScreenWidth, _webViewHeight);
//        }
//    }
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

#pragma mark - hySegmentedControl delegate
- (void)hySegmentedControlSelectAtIndex:(NSInteger)index
{
    NSDictionary * info = [self.datasource objectAtIndex:index];
    [[UserManager sharedManager] didRequestAboutClubDetailWithInfo:@{@"command":@31,@"channel_name":@"club",@"id":[info objectForKey:@"id"]} withNotifiedObject:self];
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
    
//    [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '200%'" completionHandler:nil];
    
//    NSString *fontSize = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%d%%'",200];
//    [ webView evaluateJavaScript:fontSize completionHandler:nil];
//
//
//    //修改字体颜色
//    NSString *colorString = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#ff0000'"];
//    [webView evaluateJavaScript:colorString completionHandler:nil];
    
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
