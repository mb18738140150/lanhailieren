//
//  FoodMakeCommentDetailViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/4/17.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "FoodMakeCommentDetailViewController.h"
#import "WFReplyBody.h"
#import "YMTextData.h"
#import "WFMessageBody.h"
#import "CLPlayerView.h"
#import "WriteCommentContentView.h"

#import "FoodMakeCommentTableViewCell.h"
#define kFoodMakeCommentTableViewCellID @"FoodMakeCommentTableViewCellID"
#import "FoodMakeCommemtHeaderTableViewCell.h"
#define kFoodMakeCommemtHeaderTableViewCellID @"FoodMakeCommemtHeaderTableViewCellID"

@interface FoodMakeCommentDetailViewController ()<UITableViewDelegate,UITableViewDataSource,HYSegmentedControlDelegate,UserModule_ChannelListProtocol,UserModule_ChannelDetailProtocol,UIScrollViewDelegate,UserModule_GoodProtocol,UserModule_CollectProtocol,UserModule_SaveCommentProtocol>

@property (nonatomic, strong)HYSegmentedControl * segmentC;

@property (nonatomic, strong)LeftBar * leftBar;
@property (nonatomic, strong)UITableView * tableview;
@property (nonatomic, strong)NSMutableArray<YMTextData*> * dataSource;

@property (nonatomic, assign)int page_size;
@property (nonatomic, assign)int page_index;

@property (nonatomic, weak) CLPlayerView *playerView;
@property (nonatomic, assign)FoodMakeCommemtHeaderTableViewCell * cell;// 记录cell
@property (nonatomic, strong)WriteCommentContentView * writeCommentView;// 添加评论

@property (nonatomic, strong)NSDictionary * currentSelectInfo;
@property (nonatomic, strong)NSString * commentStr;

@end

@implementation FoodMakeCommentDetailViewController

- (NSMutableArray<YMTextData *> *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.page_size = 10;
    self.page_index = 1;
    [self loadCommentData];
    
    [self navigationViewSetup];
    UIView * seperateView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.hd_width, 5)];
    seperateView.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [self.view addSubview:seperateView];
    
    [self refreshUI_iPhone];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//
//                                             selector:@selector(keyboardWasShown:)
//
//                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification*)aNotification
{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat keyBoardHeight = keyboardRect.size.height;
    
    [self.writeCommentView hideOperationBtn];
    CGRect beginUserInfo = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    if (beginUserInfo.size.height <=0) {//!!搜狗输入法弹出时会发出三次UIKeyboardWillShowNotification的通知,和官方输入法相比,有效的一次为dUIKeyboardFrameBeginUserInfoKey.size.height都大于零时.
        return;
    }
    self.writeCommentView.frame = CGRectMake(0,kScreenHeight - kStatusBarHeight - kNavigationBarHeight - keyBoardHeight - 50, kScreenWidth, 50);
    NSLog(@"self.writeCommentView.frame = %@", self.writeCommentView.frame);
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    
    self.writeCommentView.frame = CGRectMake(0,kScreenHeight - kStatusBarHeight - kNavigationBarHeight - kbSize.height - 50, kScreenWidth, 50);
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [self.writeCommentView showOperationBtn];
    self.writeCommentView.frame = CGRectMake(0, kScreenHeight - kStatusBarHeight - kNavigationBarHeight - 50, kScreenWidth, 50);
    //do something
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)navigationViewSetup
{
    self.navigationItem.title = @"西沙美食制作";
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
    [self->_playerView destroyPlayer];
    self->_playerView = nil;
    self->_cell = nil;
    [self.navigationController popViewControllerAnimated:YES];
    if (self.refreshBlock) {
        self.refreshBlock(YES);
    }
}


- (void)refreshUI_iPhone
{
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusBarHeight - kNavigationBarHeight - 50) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[FoodMakeCommentTableViewCell class] forCellReuseIdentifier:kFoodMakeCommentTableViewCellID];
    [self.tableview registerClass:[FoodMakeCommemtHeaderTableViewCell class] forCellReuseIdentifier:kFoodMakeCommemtHeaderTableViewCellID];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(doNextPageQuestionRequest)];
    self.tableview.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(doNextPageQuestionRequest)];
    
    MJRefreshBackStateFooter * footer = (MJRefreshBackStateFooter *)self.tableview.mj_footer;
    [footer setTitle:@"暂无更多评论" forState:MJRefreshStateNoMoreData];
    
    __weak typeof(self)weakSelf = self;
    self.writeCommentView = [[WriteCommentContentView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 50 - kNavigationBarHeight - kStatusBarHeight, kScreenWidth, 50) andInfo:self.infoDic];
    [self.view addSubview:self.writeCommentView];
    self.writeCommentView.commitBlock = ^(NSString *comment) {
        NSLog(@"%@", comment);
        weakSelf.writeCommentView.textView.text = @"";
        weakSelf.commentStr = comment;
        int parent_id = 0;
        if (weakSelf.currentSelectInfo) {
            parent_id = [[weakSelf.currentSelectInfo objectForKey:@"id"] intValue];
        }
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestSaveCommentWithInfo:@{@"command":@32,@"channel_name":weakSelf.channel_name,@"article_id":[weakSelf.infoDic objectForKey:@"id"],@"content":comment,@"parent_id":@(parent_id)} withNotifiedObject:weakSelf];
    };
    
    self.writeCommentView.goodBlock = ^(NSDictionary *info) {
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestDianzanDetailWithInfo:@{@"command":@36,@"channel_name":weakSelf.channel_name,@"article_id":[info objectForKey:@"id"],@"click_type":@2} withNotifiedObject:weakSelf];
    };
    self.writeCommentView.collectBlock = ^(NSDictionary *info) {
        [SVProgressHUD show];
        if ([[info objectForKey:@"is_collect"] intValue]) {
            // 已收藏，取消收藏
            [[UserManager sharedManager] didRequestCollectDetailWithInfo:@{@"command":@35,@"channel_name":weakSelf.channel_name,@"article_id":[info objectForKey:@"id"]} withNotifiedObject:weakSelf];
        }else
        {
            [[UserManager sharedManager] didRequestCollectDetailWithInfo:@{@"command":@34,@"channel_name":weakSelf.channel_name,@"article_id":[info objectForKey:@"id"]} withNotifiedObject:weakSelf];
        }
    };
    self.writeCommentView.shareBlock = ^(NSDictionary *info) {
        ;
    };
    
}


#pragma mark - getintegerDetailList
- (void)doResetQuestionRequest
{
    self.page_index = 1;
    [self loadCommentData];
}

- (void)doNextPageQuestionRequest
{
    self.page_index++;
    [self loadCommentData];
}
#pragma mark - tableview delegate & datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        FoodMakeCommemtHeaderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kFoodMakeCommemtHeaderTableViewCellID forIndexPath:indexPath];
        [cell refreshUI:self.infoDic];
        __weak typeof(self)weakSelf = self;
        __weak typeof(cell)weakCell = cell;
        cell.playBlock = ^(NSDictionary * _Nonnull info) {
            [weakSelf cl_tableViewCellPlayVideoWithCell:weakCell];
        };
        return cell;
    }
    FoodMakeCommentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kFoodMakeCommentTableViewCellID forIndexPath:indexPath];
    
    [cell refreshUIWith:[self.dataSource objectAtIndex:indexPath.row]];
    __weak typeof(self)weakSelf = self;
    cell.commentBlock = ^(NSDictionary *info) {
        weakSelf.currentSelectInfo = info;
        [weakSelf.writeCommentView.textView becomeFirstResponder];
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return tableView.hd_width * 0.55;
    }
    YMTextData * ymData = [self.dataSource objectAtIndex:indexPath.row];
    
    NSString * content = [ymData.infoDic objectForKey:@"content"];
    CGFloat contentHeight = [content boundingRectWithSize:CGSizeMake(tableView.hd_width - 55, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kMainFont_12} context:nil].size.height + 5;
    
    if (ymData.replyHeight <= 0) {
        return ymData.replyHeight + 83 + contentHeight;
    }
    
    return ymData.replyHeight + 93 + contentHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.writeCommentView textViewResignFirstResponder];
    self.currentSelectInfo = nil;
}


// 播放
- (void)cl_tableViewCellPlayVideoWithCell:(FoodMakeCommemtHeaderTableViewCell *)cell
{
    // 记录被点击的cell
    _cell = cell;
    // 销毁播放器
    [_playerView destroyPlayer];
    CLPlayerView * playerView = [[CLPlayerView alloc]initWithFrame:cell.iconImageView.frame];
    _playerView = playerView;
    [cell.contentView addSubview:playerView];
    
    // 视频地址
    _playerView.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kRootImageUrl,[cell.infoDic objectForKey:@"video_src"]]];
    [_playerView updateWithConfigure:^(CLPlayerViewConfigure *configure) {
        configure.topToolBarHiddenType = TopToolBarHiddenSmall;
    }];
    [_playerView playVideo];
    [_playerView backButton:^(UIButton *button) {
        NSLog(@"返回按钮点击");
    }];
    [_playerView endPlay:^{
        [self->_playerView destroyPlayer];
        self->_playerView = nil;
        self->_cell = nil;
    }];
    
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 因为复用，同一个cell可能会走多次
    if ([_cell isEqual:cell]) {
        // 区分是否是播放器所在的cell，销毁时将指针置空
        [_playerView destroyPlayer];
        _cell = nil;
    }
}

- (void)loadCommentData
{
    NSString * chang = @"http://img4.duitang.com/uploads/item/201602/22/20160222232729_T8Qku.thumb.700_0.jpeg";
    NSString * kuan = @"http://tupian.enterdesk.com/2015/xll/07/4/Zoro7.jpg";
    NSString * fang = @"http://imgsrc.baidu.com/forum/pic/item/5882b2b7d0a20cf4ee25596676094b36adaf99d6.jpg";
    
    WFReplyBody *body1 = [[WFReplyBody alloc] init];
    body1.replyUser = @"hhh";
    body1.repliedUser = @"红领巾";
    body1.replyInfo = kContentText1;
    
    
    WFReplyBody *body2 = [[WFReplyBody alloc] init];
    body2.replyUser = @"迪恩";
    body2.repliedUser = @"";
    body2.replyInfo = kContentText2;
    
    
    WFReplyBody *body3 = [[WFReplyBody alloc] init];
    body3.replyUser = @"山姆";
    body3.repliedUser = @"";
    body3.replyInfo = kContentText3;
    
    
    WFReplyBody *body4 = [[WFReplyBody alloc] init];
    body4.replyUser = @"雷锋";
    body4.repliedUser = @"简森·阿克斯";
    body4.replyInfo = kContentText4;
    
    
    WFReplyBody *body5 = [[WFReplyBody alloc] init];
    body5.replyUser = @"hhh";
    body5.repliedUser = @"";
    body5.replyInfo = kContentText5;
    
    WFReplyBody *body6 = [[WFReplyBody alloc] init];
    body6.replyUser = @"红领巾";
    body6.repliedUser = @"";
    body6.replyInfo = kContentText6;
    
    
    WFMessageBody *messBody1 = [[WFMessageBody alloc] init];
    messBody1.posterContent = kShuoshuoText1;
    messBody1.posterPostImage = @[chang];
    messBody1.posterReplies = [NSMutableArray arrayWithObjects:body1,body2,body4, nil];
    messBody1.posterImgstr = @"mao.jpg";
    messBody1.posterName = @"迪恩·温彻斯特";
    messBody1.posterIntro = @"这个人很懒，什么都没有留下";
    messBody1.publishTime = @"2016-8-20";
    messBody1.isFavour = YES;
    
    WFMessageBody *messBody2 = [[WFMessageBody alloc] init];
    messBody2.posterContent = kShuoshuoText1;
    messBody2.posterPostImage = @[kuan];
    messBody2.posterReplies = [NSMutableArray arrayWithObjects:body1,body2,body4, nil];
    messBody2.posterImgstr = @"mao.jpg";
    messBody2.posterName = @"山姆·温彻斯特";
    messBody2.posterIntro = @"这个人很懒，什么都没有留下";
    messBody2.publishTime = @"2016-8-20";
    messBody2.posterFavour = [NSMutableArray arrayWithObjects:@"塞纳留斯",@"希尔瓦娜斯",@"鹿盔", nil];
    messBody2.isFavour = NO;
    
    
    WFMessageBody *messBody3 = [[WFMessageBody alloc] init];
    messBody3.posterContent = kShuoshuoText3;
    messBody3.posterPostImage = @[chang,kuan,fang];
    messBody3.posterReplies = [NSMutableArray arrayWithObjects:body1,body2,body4,body6,body5,body4, nil];
    messBody3.posterImgstr = @"mao.jpg";
    messBody3.posterName = @"伊利丹怒风";
    messBody3.posterIntro = @"这个人很懒，什么都没有留下";
    messBody3.publishTime = @"2016-8-20";
    
    messBody3.isFavour = YES;
    
    WFMessageBody *messBody4 = [[WFMessageBody alloc] init];
    messBody4.posterContent = kShuoshuoText4;
    messBody4.posterPostImage = @[chang,kuan,fang,chang,kuan];
    messBody4.posterReplies = [NSMutableArray arrayWithObjects:body1, nil];
    messBody4.posterImgstr = @"mao.jpg";
    messBody4.posterName = @"基尔加丹";
    messBody4.posterIntro = @"这个人很懒，什么都没有留下";
    messBody4.publishTime = @"2016-8-20";
    messBody4.posterFavour = [NSMutableArray arrayWithObjects:nil];
    messBody4.isFavour = NO;
    
    WFMessageBody *messBody5 = [[WFMessageBody alloc] init];
    messBody5.posterContent = kShuoshuoText5;
    messBody5.posterPostImage = @[chang,kuan,chang,chang,kuan,fang,chang];
    messBody5.posterReplies = [NSMutableArray arrayWithObjects:body2,body4,body5, nil];
    messBody5.posterImgstr = @"mao.jpg";
    messBody5.posterName = @"阿克蒙德";
    messBody5.posterIntro = @"这个人很懒，什么都没有留下";
    messBody5.publishTime = @"2016-8-20";
    messBody5.posterFavour = [NSMutableArray arrayWithObjects:@"希尔瓦娜斯",@"格鲁尔",@"魔兽世界5区石锤人类联盟女圣骑丨阿诺丨",@"钢铁女武神",@"克苏恩",@"克尔苏加德",@"钢铁议会", nil];
    messBody5.isFavour = NO;
    
    WFMessageBody *messBody6 = [[WFMessageBody alloc] init];
    messBody6.posterContent = kShuoshuoText5;
    messBody6.posterPostImage = @[chang,kuan,fang,chang,chang,kuan,fang,chang,fang];
    messBody6.posterReplies = [NSMutableArray arrayWithObjects:body2,body4,body5,body4,body6, nil];
    messBody6.posterImgstr = @"mao.jpg";
    messBody6.posterName = @"红领巾";
    messBody6.posterIntro = @"这个人很懒，什么都没有留下";
    messBody6.posterFavour = [NSMutableArray arrayWithObjects:@"爆裂熔岩",@"希尔瓦娜斯",@"阿尔萨斯",@"死亡之翼",@"玛里苟斯", nil];
    messBody6.isFavour = NO;
    
    NSDictionary  * addressInfo = @{@"image":@"http://wimg.spriteapp.cn/picture/2016/0317/56ea981c857df__82.jpg",@"title":@"海鲜炒饭",@"state":@1,@"videoUrl":@"https://v.kjjl100.com/jczs/qbxqycwbb/1/1.mp4",@"replayDataSource":@[@{@"name":@"zhangsan",@"content":@"偶的烤肉ink两面派的佛教公婆的买股票上欧普；老地方股票来看"},@{@"name":@"zhangsan",@"content":@"偶的烤肉ink两看"}],@"content":@"偶的烤肉ink两面派的佛教公婆的买股票上欧普；老地方股票来看，偶的烤肉ink两面派的佛教公婆的买股票上欧普；老地方股票来看",@"time":@"2019-08-01  12:24:56"};
    NSDictionary * dataInfo = @{@"image":@"http://wimg.spriteapp.cn/picture/2016/0616/57620c1f354ae_31.jpg",@"title":@"修改资料",@"state":@1,@"videoUrl":@"https://v.kjjl100.com/jczs/qbxqycwbb/2/1.mp4",@"replayDataSource":@[@{@"name":@"zhangsan",@"content":@"偶的烤肉ink两面派的佛教公婆的买股票上欧普；老地方股票来看"}],@"content":@"偶的烤肉ink两面派的佛教公婆的买股票上欧普；老地方股票来看",@"time":@"2019-08-01  12:24:56"};
    NSDictionary  * passwordFoodInfo = @{@"image":@"http://wimg.spriteapp.cn/picture/2016/0503/572802026dcd4_64.jpg",@"title":@"修改密码",@"state":@2,@"videoUrl":@"https://v.kjjl100.com/jczs/qbxqycwbb/3/1.mp4",@"replayDataSource":@[@{@"name":@"zhangsan",@"content":@"偶的烤肉ink两看"}],@"content":@"偶的烤肉ink两面派的佛教公婆的买股票上欧普；老地方股票来看",@"time":@"2019-08-01  12:24:56"};
    NSDictionary  * phoneNumberInfo = @{@"image":@"http://wimg.spriteapp.cn/picture/2016/0506/572c0236200e7__b.jpg",@"title":@"修改手机号",@"state":@1,@"videoUrl":@"https://v.kjjl100.com/jczs/qbxqycwbb/1/1.mp4",@"content":@"偶的烤肉ink两面",@"time":@"2019-08-01  12:24:56"};
    NSDictionary  * phoneNumberInfo1 = @{@"image":@"http://wimg.spriteapp.cn/picture/2016/0709/5781023a2e6a2__b_35.jpg",@"title":@"墨鱼丸子",@"state":@1,@"videoUrl":@"https://v.kjjl100.com/jczs/qbxqycwbb/2/1.mp4",@"content":@"偶的烤肉ink两面派的佛教公婆的买股票上欧普；老地方股票来看",@"time":@"2019-08-01  12:24:56"};
    NSDictionary  * phoneNumberInfo2 = @{@"image":@"http://wimg.spriteapp.cn/picture/2016/0709/5781023a2e6a2__b_35.jpg",@"title":@"墨鱼丸子",@"state":@1,@"videoUrl":@"https://v.kjjl100.com/jczs/qbxqycwbb/2/1.mp4",@"content":@"偶的烤肉ink两面派的佛教公婆的买股票上欧普；老地方股票来看",@"time":@"2019-08-01  12:24:56"};
    
    NSArray * messageArr = @[messBody1,messBody2,messBody3,messBody4,messBody5,messBody6];
    NSArray * dataArr = @[addressInfo,dataInfo,passwordFoodInfo,phoneNumberInfo,phoneNumberInfo1,phoneNumberInfo2];
    
    for (int i = 0; i < 6; i++) {
        WFMessageBody *messBody = [messageArr objectAtIndex:i];
        NSDictionary * info = [dataArr objectAtIndex:i];
        YMTextData *ymData = [[YMTextData alloc] init ];
        ymData.messageBody = messBody;
        ymData.infoDic = info;
        ymData.replyHeight = [ymData calculateReplyHeightWithWidth:(kScreenWidth - 80)];
//        [self.dataSource addObject:ymData];
    }
    
    
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestCommentListWithInfo:@{@"command":@33,@"channel_name":self.channel_name,@"article_id":[self.infoDic objectForKey:@"id"],@"page_size":@(self.page_size),@"page_index":@(self.page_index)} withNotifiedObject:self];
    
}
- (void)didRequestChannelListSuccessed
{
    [self.tableview.mj_header endRefreshing];
    [self.tableview.mj_footer endRefreshing];
    [SVProgressHUD dismiss];
    NSArray * commentList = [[UserManager sharedManager] getCommentList];
    
    if (self.page_index == 1) {
        [self.dataSource removeAllObjects];
    }
    if ([[UserManager sharedManager] getCommentListTotalCount] <= self.dataSource.count) {
        [self.tableview.mj_footer endRefreshingWithNoMoreData];
    }
    
    for (NSDictionary * commentInfo in commentList) {
        
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:commentInfo];
        [mInfo setObject:[commentInfo objectForKey:@"avatar"] forKey:@"img_url"];
        [mInfo setObject:[commentInfo objectForKey:@"add_time"] forKey:@"time"];
        [mInfo setObject:[commentInfo objectForKey:@"user_name"] forKey:@"title"];
        
        
        WFMessageBody *messBody1 = [[WFMessageBody alloc] init];
        messBody1.posterContent = [commentInfo objectForKey:@"content"];
//        messBody1.posterPostImage = @[chang];
//        messBody1.posterReplies = [NSMutableArray arrayWithObjects:body1,body2,body4, nil];
        messBody1.posterImgstr = [NSString stringWithFormat:@"%@%@", kRootImageUrl,[commentInfo objectForKey:@"avatar"]];
        messBody1.posterName = [commentInfo objectForKey:@"user_name"];
        messBody1.posterIntro = [commentInfo objectForKey:@"content"];
        messBody1.publishTime = [commentInfo objectForKey:@"add_time"];
        messBody1.isFavour = YES;
        
        for (NSDictionary * replayInfo in [commentInfo objectForKey:@"son_list"]) {
            WFReplyBody *body6 = [[WFReplyBody alloc] init];
            body6.replyUser = [replayInfo objectForKey:@"user_name"];
            body6.repliedUser = @"";
            body6.replyInfo = [replayInfo objectForKey:@"content"];
            
            [messBody1.posterReplies addObject:body6];
        }
        
        YMTextData *ymData = [[YMTextData alloc] init ];
        ymData.messageBody = messBody1;
        ymData.infoDic = mInfo;
        ymData.replyHeight = [ymData calculateReplyHeightWithWidth:(kScreenWidth - 80)];
        [self.dataSource addObject:ymData];
    }
    
    
    [self.tableview reloadData];
}

- (void)didRequestChannelListFailed:(NSString *)failedInfo
{
    [self.tableview.mj_header endRefreshing];
    [self.tableview.mj_footer endRefreshing];
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didSaveCommentFailed:(NSString *)failedInfo
{
    self.currentSelectInfo = nil;
    self.commentStr = @"";
    [self.tableview.mj_header endRefreshing];
    [self.tableview.mj_footer endRefreshing];
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didSaveCommentSuccessed
{
    [self.tableview.mj_header endRefreshing];
    [self.tableview.mj_footer endRefreshing];
    [SVProgressHUD dismiss];
    [SVProgressHUD showSuccessWithStatus:@"评论成功"];
    
    if (self.currentSelectInfo) {
        
        WFReplyBody *body6 = [[WFReplyBody alloc] init];
        body6.replyUser = [[UserManager sharedManager] getUserNickName];
        body6.repliedUser = @"";
        body6.replyInfo = self.commentStr;
        
        YMTextData * ymData ;
        
        for (YMTextData * ymData1 in self.dataSource) {
            
            if ([[ymData1.infoDic objectForKey:@"id"] isEqual:[self.currentSelectInfo objectForKey:@"id"]]) {
                
                ymData = ymData1;
                
                break;
            }
            
        }
        
        
        WFMessageBody *messBody1 = [[WFMessageBody alloc] init];
        messBody1.posterContent = ymData.messageBody.posterContent;
        messBody1.posterImgstr = ymData.messageBody.posterImgstr;
        messBody1.posterName = ymData.messageBody.posterName;
        messBody1.posterIntro = ymData.messageBody.posterIntro;
        messBody1.publishTime = ymData.messageBody.publishTime;
        for (WFReplyBody * body in ymData.messageBody.posterReplies) {
            [messBody1.posterReplies addObject:body];
        }
        [messBody1.posterReplies addObject:body6];
        ymData.messageBody = messBody1;
        ymData.replyHeight = [ymData calculateReplyHeightWithWidth:(kScreenWidth - 80)];
        
        
        
        YMTextData *newYmData = [[YMTextData alloc] init ];
        newYmData.messageBody = messBody1;
        newYmData.infoDic = ymData.infoDic;
        newYmData.replyHeight = [newYmData calculateReplyHeightWithWidth:(kScreenWidth - 80)];
        
        NSInteger index = [self.dataSource indexOfObject:ymData];
        [self.dataSource removeObject:ymData];
        
        [self.dataSource insertObject:newYmData atIndex:index];
        
        [self.tableview reloadData];
        
    }else
    {
        self.page_index = 1;
        [self loadCommentData];
    }
    
    self.currentSelectInfo = nil;
    self.commentStr = @"";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (NSString *)getCurrentTime
{
    NSString * time;
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    time = [formatter stringFromDate:date];
    
    return time;
}

- (void)didRequestGoodSuccessed
{
    [self getCurrentpage_indexInfo];
}

- (void)didRequestGoodFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestCollectSuccessed
{
    [self getCurrentpage_indexInfo];
}


- (void)getCurrentpage_indexInfo{
    [[UserManager sharedManager] didRequestClubActivityDetailWithInfo:@{@"command":@31,@"channel_name":self.channel_name,@"id":[_infoDic objectForKey:@"id"]} withNotifiedObject:self];
}

- (void)didRequestCollectFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    self.currentSelectInfo = nil;
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestChannelDetailSuccessed
{
    [SVProgressHUD dismiss];
    self.writeCommentView.infoDic = [[UserManager sharedManager] getClubActivityDetail];
    [self.writeCommentView refreshUIWithInfo:[[UserManager sharedManager] getClubActivityDetail]];
}

- (void)didRequestChannelDetailFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    self.currentSelectInfo = nil;
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}


@end
