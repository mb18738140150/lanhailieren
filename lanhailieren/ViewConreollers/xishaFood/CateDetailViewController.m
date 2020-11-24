//
//  CateDetailViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/4/21.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "CateDetailViewController.h"
#import "CateDetailHeaderTableViewCell.h"
#define kCateDetailHeaderTableViewCellID @"CateDetailHeaderTableViewCellID"
#import <WebKit/WebKit.h>

@interface CateDetailViewController ()<UITableViewDelegate,UITableViewDataSource,WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong)NSMutableArray * dataSource;
@property(nonatomic,retain)UITableView *tableView;

@property (nonatomic, strong)WKWebView * webView;
@property (nonatomic, assign)CGFloat webViewHeight;
@property (nonatomic, strong)UIButton* backBtn;

@end

@implementation CateDetailViewController

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
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
    
    
//    NSString * jsString = @"var objs = document.getElementsByTagName('img');for(var i=0;i++){var img = objs[i];img.style.maxWidth = '100%';img.style.height='auto';}";
//    WKUserScript *wkUScriptImg = [[WKUserScript alloc] initWithSource:jsString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//
//    // device-width
//    NSString *jScript = [NSString stringWithFormat:@"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"];
//
//    //注入
//    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//
//    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
//    [wkUController addUserScript:wkUScriptImg];
//    [wkUController addUserScript:wkUScript];
//
//    //配置对象
//    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
//    wkWebConfig.userContentController = wkUController;
//    // 创建设置对象
//    WKPreferences *preference = [[WKPreferences alloc]init];
//    preference.javaScriptCanOpenWindowsAutomatically = true;
//    // 设置字体大小(最小的字体大小)
//    preference.minimumFontSize = 38 ;
//    // 设置偏好设置对象
//    wkWebConfig.preferences = preference;
    
    
    
    
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    _webView.scrollView.delegate = self;
    _webView.scrollView.scrollEnabled = NO;
    
    
    
    NSString *headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'><style>img{max-width:100%}</style></header>";
    
    
    [_webView loadHTMLString:[headerString stringByAppendingString:[self.info objectForKey:@"content"]] baseURL:nil];
    [_webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    [_tableView registerClass:[CateDetailHeaderTableViewCell class] forCellReuseIdentifier:kCateDetailHeaderTableViewCellID];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(10, 20, 23, 23);
    [self.backBtn setImage:[UIImage imageNamed:@"ic_fooeIntroduceback"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backBtn];
    
}

- (void)backAction
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)navigationViewSetup
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)loadData
{
     NSDictionary * info = self.info;
       
       // banner
       [self.dataSource removeAllObjects];
       NSArray * albums = [info objectForKey:@"albums"];
       if (albums.count == 0) {
           [self.dataSource addObject:[NSString stringWithFormat:@"%@%@", kRootImageUrl,[info objectForKey:@"img_url"]]];
       }else
       {
           for (NSDictionary * bannerInfo  in albums) {
               [self.dataSource addObject:[NSString stringWithFormat:@"%@%@", kRootImageUrl,[bannerInfo objectForKey:@"original_path"]]];
           }
       }
       
       [self.tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        CateDetailHeaderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kCateDetailHeaderTableViewCellID forIndexPath:indexPath];
        cell.bannerImgUrlArray = self.dataSource;
        [cell refreshUIWith:@{@"image":@"http://wimg.spriteapp.cn/picture/2016/0709/5781023a2e6a2__b_35.jpg",@"title":[self.info objectForKey:@"title"],@"state":@1,@"menu":[NSString stringWithFormat:@"菜品所用食材：%@", [self.info objectForKey:@"mater"]],@"content":@"",@"time":@"2019-08-01  12:24:56"}];
        return cell;
    }
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    [cell.contentView removeAllSubviews];
    [cell.contentView addSubview:self.webView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        return  55 + tableView.hd_width * 0.4 - 5;
    }
    return self.webView.frame.size.height;
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
            [_tableView reloadData];
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
    
    NSLog(@"*** %@",navigationAction.request.URL.absoluteString);
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
