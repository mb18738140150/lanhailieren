//
//  VipCustomDetailViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/4/22.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "VipCustomDetailViewController.h"
#import "CateDetailHeaderTableViewCell.h"
#define kCateDetailHeaderTableViewCellID @"CateDetailHeaderTableViewCellID"
#import <WebKit/WebKit.h>
#import "CustomView.h"

@interface VipCustomDetailViewController ()<UITableViewDelegate,UITableViewDataSource,WKUIDelegate,WKNavigationDelegate,UserModule_VIPCustomProtocol>
@property (nonatomic, strong)NSMutableArray * dataSource;
@property(nonatomic,retain)UITableView *tableView;

@property (nonatomic, strong)WKWebView * webView;
@property (nonatomic, assign)CGFloat webViewHeight;
@property (nonatomic, strong)UIButton* backBtn;

@end

@implementation VipCustomDetailViewController

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
    
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 45 - kNavigationBarHeight - kStatusBarHeight)];
    
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
        
        __weak typeof(self)weakSelf = self;
        [cell refreshVipCustomDetailUIWith:@{@"image":@"http://wimg.spriteapp.cn/picture/2016/0709/5781023a2e6a2__b_35.jpg",@"title":[self.info objectForKey:@"title"],@"state":@1,@"menu":@"",@"content":@"",@"time":@"2019-08-01  12:24:56",@"group_id":[self.info objectForKey:@"group_id"]}];
        
        cell.vipCustomMadeBlock = ^(NSDictionary * _Nonnull info) {
            [weakSelf showCustomMadeView:info];
            NSLog(@"custom made");
        };
        
        return cell;
    }
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    [cell.contentView removeAllSubviews];
    [cell.contentView addSubview:self.webView];
    return cell;
}

- (void)showCustomMadeView:(NSDictionary *)info
{
//    NSDictionary * detailInfo = [UserManager sharedManager]；
    if ([[self.info objectForKey:kGroup_id] intValue] > [[[[UserManager sharedManager] getUserInfos] objectForKey:kGroup_id] intValue]) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"由于您的等级不够，暂时不能定制，请联系门店升级" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertC addAction:alertA];
        [self presentViewController:alertC animated:YES completion:nil];
        return;
    }
    
    CustomView * customView = [[CustomView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:customView];
    
    __weak typeof(self)weakSelf = self;
    customView.customMakeCommitBlock = ^(NSDictionary *info) {
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestVIPCustomWithInfo:@{@"command":@37,@"channel_name":@"service",@"article_id":[self.info objectForKey:@"id"],@"shop_id":@(0),@"name":[info objectForKey:@"name"],@"phone":[info objectForKey:@"phone"],@"address":[info objectForKey:@"address"],@"webchat":@"",@"birthday":@""} withNotifiedObject:weakSelf];
    };
    
}

- (void)didRequestVIPCustomFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestVIPCustomSuccessed
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showSuccessWithStatus:@"提交成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        return 40 + tableView.hd_width * 0.4 - 5;
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
