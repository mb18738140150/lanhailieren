//
//  UserManager.m
//  Accountant
//
//  Created by aaa on 2017/2/27.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "UserManager.h"
#import "LoginStatusOperation.h"
#import "UserModuleModels.h"
#import "CommonMacro.h"
#import "ResetPwdOperation.h"
#import "AppInfoOperation.h"
#import "BindJPushOperation.h"
#import "OrderLivingCourseOperation.h"
#import "CancelOrderLivingCourseOperation.h"
#import "BindRegCodeOperation.h"
#import "DiscountCouponOperation.h"

#import "VerifyCodeOperation.h"
#import "RegistOperation.h"
#import "ForgetPsdOperation.h"
#import "VerifyAccountOperation.h"
#import "CompleteUserInfoOperation.h"
#import "PayCourseOperation.h"
#import "PathUtility.h"
#import "RecommendOperation.h"
#import "AssistantCenterOperation.h"
#import "MemberLevelDetail.h"
#import "SubmitOpinionOperation.h"
#import "CommonProblemOperation.h"
#import "LivingBackYearListOperation.h"
#import "SubmitGiftCodeOperation.h"
#import "GiftListOperation.h"
#import "AcquireDiscountCouponOperation.h"
#import "AcquireDiscountCouponSuccess.h"
#import "VerifyInAppPuchaseOperation.h"
#import "MyCoinOperation.h"

#import "AddressListOperation.h"
#import "EditAddressInfoOperation.h"
#import "DeleteAddressOperation.h"
#import "GoodCategoryOperation.h"
#import "GoodListOperation.h"
#import "GoodList_qualityOperation.h"
#import "GoodDetailOperation.h"
#import "StoreListOperation.h"
#import "AddShoppingCarOperation.h"
#import "DeleteShoppingCarOperation.h"
#import "CleanShoppingCarOperation.h"
#import "ShoppingCarListOperation.h"
#import "CreateOrderOperation.h"
#import "OrderListOperation.h"
#import "KeyWordListOperation.h"
#import "AddSearchKeyWordOperation.h"
#import "CleanSearchKeyWordOperation.h"
#import "ChangePhoneOperation.h"
#import "ChangePasswordOperation.h"
#import "CancelOrderOperation.h"

#import "BannerOperation.h"
#import "ChannelListOperation.h"
#import "ChannelDetailOperation.h"
#import "DianzanOperation.h"
#import "CollectOperation.h"
#import "VipCustomOperation.h"
#import "SaveCommentOperation.h"

#import "XishameishiOperation.h"
#import "MeishizhizuoOperation.h"
#import "YuleshipinOperation.h"
#import "XishameishiDetailOperation.h"

@interface UserManager()

@property (nonatomic,strong) LoginStatusOperation       *loginOperation;
@property (nonatomic,strong) UserModuleModels           *userModuleModels;

@property (nonatomic,strong) ResetPwdOperation          *resetOperation;

@property (nonatomic,strong) AppInfoOperation           *infoOperation;

@property (nonatomic, strong)BindJPushOperation         *bindJPushOperation;
@property (nonatomic, strong)OrderLivingCourseOperation *orderLivingCourseOperation;
@property (nonatomic, strong)CancelOrderLivingCourseOperation *cancelOrderLivingCOurseOperation;
@property (nonatomic, strong)VerifyCodeOperation         *verifyCodeOperation;
@property (nonatomic, strong)RegistOperation         *registOperation;
@property (nonatomic, strong)ForgetPsdOperation         *forgetPsdOperation;
@property (nonatomic, strong)VerifyAccountOperation     *verfyAccountOperation;
@property (nonatomic, strong)CompleteUserInfoOperation  *completeOperation;
@property (nonatomic, strong)BindRegCodeOperation       *bindRegCodeOperation;
@property (nonatomic, strong)PayCourseOperation         *payOrderOperation;
@property (nonatomic, strong)DiscountCouponOperation    *discountCouponOperation;

@property (nonatomic, strong)RecommendOperation         *recommendOperation;
@property (nonatomic, strong)AssistantCenterOperation   *assistantCenterOperation;
@property (nonatomic, strong)MemberLevelDetail          *memberLevelDetailOperation;
@property (nonatomic, strong)SubmitOpinionOperation     *submitOpinionOperation;
@property (nonatomic, strong)CommonProblemOperation     *commonProblemOperation;
@property (nonatomic, strong)LivingBackYearListOperation *livingBackYearLiatOperation;
@property (nonatomic, strong)GiftListOperation          *giftLIstOperation;
@property (nonatomic, strong)SubmitGiftCodeOperation    *submitGiftCodeOperation;
@property (nonatomic, strong)AcquireDiscountCouponOperation *acquireDisCountOperation;
@property (nonatomic, strong)AcquireDiscountCouponSuccess   *acquireDisCountSuccessOperation;
@property (nonatomic, strong)VerifyInAppPuchaseOperation *verifyInAppPurchaseOperation;
@property (nonatomic, strong)MyCoinOperation            *myCoinOperation;

@property (nonatomic, strong)AddressListOperation            *addressListOperation;
@property (nonatomic, strong)EditAddressInfoOperation            *editAddressOperation;
@property (nonatomic, strong)GoodCategoryOperation          * goodCategoryOperation;// good
@property (nonatomic, strong)GoodCategoryOperation          * xishaFoodCategoryOperation;// xisha food
@property (nonatomic, strong)GoodCategoryOperation          * fisheryHarvestCategoryOperation;// xisha food
@property (nonatomic, strong)GoodCategoryOperation          * foodmakeCategoryOperation;// food make
@property (nonatomic, strong)GoodCategoryOperation          * arderCategoryOperation; // arder
@property (nonatomic, strong)GoodCategoryOperation          * clubActivityCategoryOperation; // club activity
@property (nonatomic, strong)GoodCategoryOperation          * aboutClubCategoryOperation; // club activity



@property (nonatomic, strong)GoodListOperation          * goodListOperation;
@property (nonatomic, strong)GoodList_qualityOperation          * goodListQualityOperation;
@property (nonatomic, strong)GoodDetailOperation          * goodDetailOperation;
@property (nonatomic, strong)StoreListOperation         *storeListOperation;

@property (nonatomic, strong)AddShoppingCarOperation         *addShoppingCarOperation;
@property (nonatomic, strong)DeleteShoppingCarOperation         *deleteShoppingCarOperation;
@property (nonatomic, strong)CleanShoppingCarOperation         *cleanShoppingCarOperation;
@property (nonatomic, strong)ShoppingCarListOperation         *shoppingCarListOperation;
@property (nonatomic, strong)CreateOrderOperation         *createOrderOperation;
@property (nonatomic, strong)OrderListOperation         *orderListOperation;
@property (nonatomic, strong)KeyWordListOperation         *keyWordListOperation;
@property (nonatomic, strong)CleanSearchKeyWordOperation         *cleanSearchKeyWordOperation;
@property (nonatomic, strong)AddSearchKeyWordOperation         *addSearchKeyWordOperation;
@property (nonatomic, strong)CancelOrderOperation         *cancelOrderOperation;
@property (nonatomic, strong)DeleteAddressOperation         *deleteAddressOperation;
@property (nonatomic, strong)ChangePhoneOperation         *changePhoneOperation;
@property (nonatomic, strong)ChangePasswordOperation         *changePasswordOperation;
@property (nonatomic, strong)BannerOperation         *bannerOperation;
@property (nonatomic, strong)BannerOperation         *xishaFoodBannerOperation;
@property (nonatomic, strong)BannerOperation         *foodMakeBannerOperation;


// club
@property (nonatomic, strong)ChannelListOperation * clubChannelListOperation;
@property (nonatomic, strong)ChannelListOperation * clubActivityListOperation;
@property (nonatomic, strong)ChannelListOperation * clubContextListOperation;
@property (nonatomic, strong)ChannelListOperation * clubServerListOperation;
@property (nonatomic, strong)ChannelListOperation * entertainmentListOperation;
@property (nonatomic, strong)ChannelListOperation * foodmakeListOperation;
@property (nonatomic, strong)ChannelListOperation * aboutClubListOperation;


@property (nonatomic, strong)ChannelDetailOperation *  ChannelDetailOperation;
@property (nonatomic, strong)ChannelDetailOperation *  aboutClubDetailOperation;
@property (nonatomic, strong)ChannelDetailOperation *  clubActivityDetailOperation;
@property (nonatomic, strong)ChannelDetailOperation *  clubContestDetailOperation;
@property (nonatomic, strong)ChannelDetailOperation *  clubServerDetailOperation;

@property (nonatomic, strong)VipCustomOperation *  vipCustomOperation;

// xishafood
@property (nonatomic, strong)ChannelListOperation * storeTodayGoodFoodListOperation;
@property (nonatomic, strong)ChannelListOperation * storeGoodFoodListOperation;
@property (nonatomic, strong)ChannelListOperation * storeVRListOperation;
@property (nonatomic, strong)ChannelListOperation * storeTestReportListOperation;
@property (nonatomic, strong)ChannelListOperation * fisheryHarvestListOperation;

@property (nonatomic, strong)DianzanOperation *  dianzanOperation;
@property (nonatomic, strong)CollectOperation *  collectOperation;

// comment
@property (nonatomic, strong)ChannelListOperation * commentListOperation;


@property (nonatomic, strong)SaveCommentOperation *  saveCommentOperation;

@property (nonatomic, strong)ChannelListOperation * vipCustomListOperation;

@property (nonatomic, strong)XishameishiOperation * xishameishiOperation;
@property (nonatomic, strong)MeishizhizuoOperation * meishizhizuoOperation;
@property (nonatomic, strong)YuleshipinOperation * yuleshipinOperation;
@property (nonatomic, strong)XishameishiDetailOperation * xishameishiDetailOperation;
@end

@implementation UserManager

+ (instancetype)sharedManager
{
    static UserManager *__manager__;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __manager__ = [[UserManager alloc] init];
    });
    return __manager__;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.userModuleModels = [[UserModuleModels alloc] init];
        self.loginOperation = [[LoginStatusOperation alloc] init];
        [self.loginOperation setCurrentUser:self.userModuleModels.currentUserModel];
        self.resetOperation = [[ResetPwdOperation alloc] init];
        self.bindJPushOperation = [[BindJPushOperation alloc]init];
        self.orderLivingCourseOperation = [[OrderLivingCourseOperation alloc]init];
        self.cancelOrderLivingCOurseOperation = [[CancelOrderLivingCourseOperation alloc] init];
        self.infoOperation = [[AppInfoOperation alloc] init];
        self.infoOperation.appInfoModel = self.userModuleModels.appInfoModel;
        self.verifyCodeOperation = [[VerifyCodeOperation alloc]init];
        self.registOperation = [[RegistOperation alloc]init];
        self.forgetPsdOperation = [[ForgetPsdOperation alloc]init];
        self.verfyAccountOperation = [[VerifyAccountOperation alloc]init];
        self.completeOperation = [[CompleteUserInfoOperation alloc]init];
        [self.completeOperation setCurrentUser:self.userModuleModels.currentUserModel];
        self.bindRegCodeOperation = [[BindRegCodeOperation alloc]init];
        self.payOrderOperation = [[PayCourseOperation alloc]init];
        self.discountCouponOperation = [[DiscountCouponOperation alloc]init];
        self.acquireDisCountOperation = [[AcquireDiscountCouponOperation alloc]init];
        self.acquireDisCountSuccessOperation = [[AcquireDiscountCouponSuccess alloc]init];
        
        self.recommendOperation = [[RecommendOperation alloc]init];
        self.assistantCenterOperation = [[AssistantCenterOperation alloc]init];
        self.memberLevelDetailOperation = [[MemberLevelDetail alloc]init];
        self.submitOpinionOperation = [[SubmitOpinionOperation alloc]init];
        self.commonProblemOperation = [[CommonProblemOperation alloc]init];
        self.livingBackYearLiatOperation = [[LivingBackYearListOperation alloc]init];
        self.giftLIstOperation = [[GiftListOperation alloc]init];
        self.submitGiftCodeOperation = [[SubmitGiftCodeOperation alloc]init];
        self.verifyInAppPurchaseOperation = [[VerifyInAppPuchaseOperation alloc]init];
        self.myCoinOperation = [[MyCoinOperation alloc]init];
        
        
        self.addressListOperation = [[AddressListOperation alloc]init];
        self.editAddressOperation = [[EditAddressInfoOperation alloc]init];
        self.deleteAddressOperation = [[DeleteAddressOperation alloc]init];
        self.goodCategoryOperation = [[GoodCategoryOperation alloc]init];
        self.xishaFoodCategoryOperation = [[GoodCategoryOperation alloc]init];
        self.fisheryHarvestCategoryOperation = [[GoodCategoryOperation alloc]init];
        self.foodmakeCategoryOperation = [[GoodCategoryOperation alloc]init];
        self.arderCategoryOperation = [[GoodCategoryOperation alloc]init];
        self.clubActivityCategoryOperation = [[GoodCategoryOperation alloc]init];
        self.aboutClubCategoryOperation = [[GoodCategoryOperation alloc]init];
        
        self.goodListOperation = [[GoodListOperation alloc]init];
        self.goodListQualityOperation = [[GoodList_qualityOperation alloc]init];
        self.goodDetailOperation = [[GoodDetailOperation alloc]init];
        self.storeListOperation = [[StoreListOperation alloc]init];
        
        self.addShoppingCarOperation = [[AddShoppingCarOperation alloc]init];
        self.deleteShoppingCarOperation = [[DeleteShoppingCarOperation alloc]init];
        self.cleanShoppingCarOperation = [[CleanShoppingCarOperation alloc]init];
        self.shoppingCarListOperation = [[ShoppingCarListOperation alloc]init];
        self.createOrderOperation = [[CreateOrderOperation alloc]init];
        self.orderListOperation = [[OrderListOperation alloc]init];
        self.keyWordListOperation = [[KeyWordListOperation alloc]init];
        self.cleanSearchKeyWordOperation = [[CleanSearchKeyWordOperation alloc]init];
        self.addSearchKeyWordOperation = [[AddSearchKeyWordOperation alloc]init];
        self.cancelOrderOperation = [[CancelOrderOperation alloc]init];
        
        self.changePhoneOperation = [[ChangePhoneOperation alloc]init];
        self.changePasswordOperation = [[ChangePasswordOperation alloc]init];
        self.bannerOperation = [[BannerOperation alloc]init];
        self.xishaFoodBannerOperation = [[BannerOperation alloc]init];
        self.foodMakeBannerOperation = [[BannerOperation alloc]init];

        self.dianzanOperation = [[DianzanOperation alloc]init];
        self.collectOperation = [[CollectOperation alloc]init];
        
        self.clubChannelListOperation = [[ChannelListOperation alloc]init];
        self.clubActivityListOperation = [[ChannelListOperation alloc]init];
        self.clubContextListOperation = [[ChannelListOperation alloc]init];
        self.aboutClubListOperation = [[ChannelListOperation alloc]init];
        self.clubServerListOperation = [[ChannelListOperation alloc]init];
        
        self.aboutClubDetailOperation = [[ChannelDetailOperation alloc]init];
        self.clubActivityDetailOperation = [[ChannelDetailOperation alloc]init];
        self.clubContestDetailOperation = [[ChannelDetailOperation alloc]init];
        self.clubServerDetailOperation = [[ChannelDetailOperation alloc]init];
        
        self.vipCustomOperation = [[VipCustomOperation alloc]init];
        
        self.storeTodayGoodFoodListOperation = [[ChannelListOperation alloc]init];
        self.storeGoodFoodListOperation = [[ChannelListOperation alloc]init];
        self.storeVRListOperation = [[ChannelListOperation alloc]init];
        self.storeTestReportListOperation = [[ChannelListOperation alloc]init];
        self.fisheryHarvestListOperation = [[ChannelListOperation alloc]init];
        
        
        self.entertainmentListOperation = [[ChannelListOperation alloc]init];
        self.foodmakeListOperation = [[ChannelListOperation alloc]init];
        
        // comment
        self.commentListOperation = [[ChannelListOperation alloc]init];
        
        self.saveCommentOperation = [[SaveCommentOperation alloc]init];
        
        self.vipCustomListOperation = [[ChannelListOperation alloc]init];
        self.xishameishiOperation = [[XishameishiOperation alloc]init];
        self.meishizhizuoOperation = [[MeishizhizuoOperation alloc]init];
        self.yuleshipinOperation = [[YuleshipinOperation alloc]init];
        self.xishameishiDetailOperation = [[XishameishiDetailOperation alloc]init];
    }
    return self;
}


- (void)registWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_RegistProtocol>)object
{
    [self.registOperation didRequestRegistWithWithDic:infoDic withNotifiedObject:object];
}

- (void)loginWithUserName:(NSString *)userName andPassword:(NSString *)pwd withNotifiedObject:(id<UserModule_LoginProtocol>)object
{
    [self.loginOperation didLoginWithUserName:userName andPassword:pwd withNotifiedObject:object];
}

- (void)didLoginWith:(NSDictionary *)info withNotifiedObject:(id<UserModule_LoginProtocol>)object
{
    [self.loginOperation didLoginWith:info withNotifiedObject:object];
}

//- (void)didRequestUserInfoWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_LoginProtocol>)object
//{
//    
//}

- (void)resetPasswordWithOldPassword:(NSString *)oldPwd andNewPwd:(NSString *)newPwd withNotifiedObject:(id<UserModule_ResetPwdProtocol>)object
{
    [self.resetOperation didRequestResetPwdWithOldPwd:oldPwd andNewPwd:newPwd withNotifiedObject:object];
}

// 获取收货地址
- (void)getAddressListWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_AddressListProtocol>)object
{
    [self.addressListOperation didRequestAddressListWithWithDic:infoDic withNotifiedObject:object];
}
// 编辑收货地址
- (void)editAddressWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_EditAddressProtocol>)object
{
    [self.editAddressOperation didRequestEditAddressWithWithDic:infoDic withNotifiedObject:object];
}
- (NSArray *)getAddressList
{
    return self.addressListOperation.addressList;
}

// 删除地址
- (void)didRequestDeleteAddressWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_DeleteAddressProtocol>)object
{
    [self.deleteAddressOperation didRequestDeleteAddressWithCourseInfo:infoDic withNotifiedObject:object];
}


// 获取积分明细
- (void)didRequestIntegralDetailListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_RecommendProtocol>)object
{
    [self.recommendOperation didRequestIntegralDetailListWithInfo:infoDic withNotifiedObject:object];
}
- (NSMutableArray * )getIntegerDetailList
{
    return self.recommendOperation.integerDetailList;
}
- (int )getIntegerDetailListTotalCount
{
    return [[self.recommendOperation.integerDetailInfo objectForKey:@"totalCount"] intValue];
}

- (void)didRequestRechargeDetailListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_RechargeDetailListProtocol>)object
{
    [self.recommendOperation didRequestRechargeDetailListWithInfo:infoDic withNotifiedObject:object];
}
- (NSMutableArray * )getRechargeDetailList
{
    return self.recommendOperation.rechargeDetailList;
}
- (int )getRechargeDetailListTotalCount
{
    return [[self.recommendOperation.rechargeDetailInfo objectForKey:@"totalCount"] intValue];
}

// 商品分类
- (void)didRequestGoodCategoryListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodCategoryProtocol>)object
{
    [self.goodCategoryOperation didRequestGoodCategoryListWithInfo:infoDic withNotifiedObject:object];
}

- (NSMutableArray * )getGoodCategoryList
{
    return self.goodCategoryOperation.goodCategoryList;
}

// 西沙美食分类
- (void)didRequestXishaFoodCategoryListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodCategoryProtocol>)object
{
    [self.xishaFoodCategoryOperation didRequestGoodCategoryListWithInfo:infoDic withNotifiedObject:object];
}
- (NSMutableArray * )getXishaFoodCategoryList
{
    return self.xishaFoodCategoryOperation.goodCategoryList;
}

// fisheryHarvest
- (void)didRequestFisheryHarvestCategoryListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodCategoryProtocol>)object
{
    [self.fisheryHarvestCategoryOperation didRequestGoodCategoryListWithInfo:infoDic withNotifiedObject:object];
}
- (NSMutableArray * )getFisheryHarvestCategoryList
{
    return self.fisheryHarvestCategoryOperation.goodCategoryList;
}

// 美食制作分类
- (void)didRequestFoodMakeCategoryListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodCategoryProtocol>)object
{
    [self.foodmakeCategoryOperation didRequestGoodCategoryListWithInfo:infoDic withNotifiedObject:object];
}
- (NSMutableArray * )getFoodMakeCategoryList
{
    return self.foodmakeCategoryOperation.goodCategoryList;
}

// 娱乐视频分类
- (void)didRequestArderCategoryListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodCategoryProtocol>)object
{
    [self.arderCategoryOperation didRequestGoodCategoryListWithInfo:infoDic withNotifiedObject:object];
}
- (NSMutableArray * )getArderCategoryList
{
    return self.arderCategoryOperation.goodCategoryList;
}

// clubactivity
- (void)didRequestClubActivityCategoryListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodCategoryProtocol>)object
{
    [self.clubActivityCategoryOperation didRequestGoodCategoryListWithInfo:infoDic withNotifiedObject:object];
}
- (NSMutableArray * )getClubActivityCategoryList
{
    return self.clubActivityCategoryOperation.goodCategoryList;
}


// clubactivity
- (void)didRequestAboutClubCategoryListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodCategoryProtocol>)object
{
    [self.aboutClubCategoryOperation didRequestGoodCategoryListWithInfo:infoDic withNotifiedObject:object];
}
- (NSMutableArray * )getAboutClubCategoryList
{
    return self.aboutClubCategoryOperation.goodCategoryList;
}


// 商品列表
- (void)didRequestGoodListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodListProtocol>)object
{
    [self.goodListOperation didRequestGoodListWithInfo:infoDic withNotifiedObject:object];
}
- (NSMutableArray * )getGoodList
{
    return self.goodListOperation.goodList;
}
- (int)getGoodListTotalCount
{
    return self.goodListOperation.totalCount;
}

// 精品商品列表
- (void)didRequestGoodListQualityWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodList_qualityProtocol>)object
{
    [self.goodListQualityOperation didRequestGoodListQualityWithInfo:infoDic withNotifiedObject:object];
}
- (NSMutableArray * )getGoodList_quality
{
    return self.goodListQualityOperation.goodList_quality;
}
// 推荐商品列表
- (void)didRequestGoodListRecommendWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodList_recommendProtocol>)object
{
    [self.goodListOperation didRequestGoodListRecommendWithInfo:infoDic withNotifiedObject:object];
}
- (NSMutableArray * )getGoodList_Recommend
{
    return self.goodListOperation.goodList_recommend;
}

// 商品详情
- (void)didRequestGoodDetailWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodDetailProtocol>)object
{
    [self.goodDetailOperation didRequestGoodDetailWithInfo:infoDic withNotifiedObject:object];
}
- (NSDictionary * )getGoodDetailInfo
{
    return self.goodDetailOperation.goodDetailInfo;
}
- (void)HotSearchWith:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_HotSearchProtocol>)object
{
    [self.payOrderOperation didRequestpayOrderWithCourseInfo:infoDic withNotifiedObject:object];
}
- (NSDictionary *)getHotSearchKeyInfo
{
    return self.payOrderOperation.payOrderDetailInfo;
}

// 门店列表
- (void)didRequestStoreListWith:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_StoreListProtocol>)object
{
    [self.storeListOperation didRequestStoreListWithCourseInfo:infoDic withNotifiedObject:object];
}
// 获取门店列表
- (NSArray *)getStoreList
{
    return [self.storeListOperation.payOrderDetailInfo objectForKey:@"data"];
}

// 添加购物车
- (void)didRequestAddShoppingCarWith:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_AddShoppingCarProtocol>)object
{
    [self.addShoppingCarOperation didRequestAddShoppingCarWithCourseInfo:infoDic withNotifiedObject:object];
}
// 删除购物车
- (void)didRequestDeleteShoppingCarWith:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_DeleteShoppingCarProtocol>)object
{
    [self.deleteShoppingCarOperation didRequestDeleteShoppingCarWithCourseInfo:infoDic withNotifiedObject:object];
}
// 清空购物车
- (void)didRequestCleanShoppingCarWith:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_CleanShoppingCarProtocol>)object
{
    [self.cleanShoppingCarOperation didRequestCleanShoppingCarWithCourseInfo:infoDic withNotifiedObject:object];
}
// 我的购物车
- (void)didRequestShoppingCarListWith:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ShoppingCarListProtocol>)object
{
    [self.shoppingCarListOperation didRequestShoppingCarListWithCourseInfo:infoDic withNotifiedObject:object];
}
// 获取购物车列表
- (NSArray *)getShoppingCarList
{
    return self.shoppingCarListOperation.shoppingList;
}
// 获取订单列表
- (void)didRequestOrderListWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_OrderListProtocol>)object
{
    [self.orderListOperation didRequestOrderListWithCourseInfo:infoDic withNotifiedObject:object];
}
- (NSArray *)getMyOrderList
{
    return self.orderListOperation.orderList;
}
- (int )getMyOrderListTotalCount
{
    return self.orderListOperation.orderTotalCount;
}

// 创建订单
- (void)didRequestCreateOrderWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_CreateOrderProtocol>)object
{
    [self.createOrderOperation didRequestCreateOrderWithCourseInfo:infoDic withNotifiedObject:object];
}

// 取消订单
- (void)didRequestCancelOrderWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_CancelOrderProtocol>)object
{
    [self.cancelOrderOperation didRequestCancelOrderWithCourseInfo:infoDic withNotifiedObject:object];
}


// 获取搜索词列表
- (void)didRequestSearchKeyWordListWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GetSearchKeyWordListProtocol>)object
{
    [self.keyWordListOperation didRequestGetSearchKeyWordListWithCourseInfo:infoDic withNotifiedObject:object];
}
- (NSArray *)getSearchKeyWordList
{
    return self.keyWordListOperation.searchKeyWordList;
}
// 清空搜索词
- (void)didRequestCleanSearchKeyWordWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_CleanSearchKeyWordProtocol>)object
{
    [self.cleanSearchKeyWordOperation didRequestCleanSearchKeyWordWithCourseInfo:infoDic withNotifiedObject:object];
}
// 保存搜索词
- (void)didRequestAddSearchKeyWordWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_AddSearchKeyWordProtocol>)object
{
    [self.addSearchKeyWordOperation didRequestAddSearchKeyWordWithCourseInfo:infoDic withNotifiedObject:object];
}



// 修改手机号
- (void)didRequestChangePhoneWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChangePhoneProtocol>)object
{
    [self.changePhoneOperation didRequestChangePhoneWithCourseInfo:infoDic withNotifiedObject:object];
}
// 修改密码
- (void)didRequestChangePasswordWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChangePasswordProtocol>)object
{
    [self.changePasswordOperation didRequestChangePasswordWithCourseInfo:infoDic withNotifiedObject:object];
}
// banner
- (void)didRequestBannerWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_BannerProtocol>)object
{
    [self.bannerOperation didRequestBannerWithWithDic:infoDic withNotifiedObject:object];
}
- (NSArray *)getBannerList
{
    return self.bannerOperation.bannerList;
}

// xishaFoodBanner
- (void)didRequestXishaFoodBannerWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_BannerProtocol>)object
{
    [self.xishaFoodBannerOperation didRequestBannerWithWithDic:infoDic withNotifiedObject:object];
}
- (NSArray *)getXishaFoodBannerList
{
    return self.xishaFoodBannerOperation.bannerList;
}

// foodMakeBanner
- (void)didRequestFoodMakeBannerWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_BannerProtocol>)object
{
    [self.foodMakeBannerOperation didRequestBannerWithWithDic:infoDic withNotifiedObject:object];
}
- (NSArray *)getFoodMakeBannerList
{
    return self.foodMakeBannerOperation.bannerList;
}
















- (void)forgetPsdWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ForgetPasswordProtocol>)object
{
    [self.forgetPsdOperation didRequestForgetPsdWithWithDic:infoDic withNotifiedObject:object];
}

- (void)completeUserInfoWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_CompleteUserInfoProtocol>)object;
{
    [self.completeOperation didRequestCompleteUserInfoWithWithDic:infoDic withNotifiedObject:object];
}

- (void)bindRegCodeWithRegCode:(NSString *)regCode withNotifiedObject:(id<UserModule_bindRegCodeProtocol>)object
{
    [self.bindRegCodeOperation didBindRegCodeWithWithCode:regCode withNotifiedObject:object];
}



- (void)getVerifyCodeWithPhoneNumber:(NSDictionary *)info withNotifiedObject:(id<UserModule_VerifyCodeProtocol>)object
{
    [self.verifyCodeOperation didRequestVerifyCodeWithWithPhoneNumber:info withNotifiedObject:object];
}

- (void)getVerifyAccountWithAccountNumber:(NSString *)accountNumber withNotifiedObject:(id<UserModule_VerifyAccountProtocol>)object
{
    [self.verfyAccountOperation didRequestVerifyAccountWithWithAccountNumber:accountNumber withNotifiedObject:object];
}

- (void)didRequestAppVersionInfoWithNotifiedObject:(id<UserModule_AppInfoProtocol>)object
{
    [self.infoOperation didRequestAppInfoWithNotifedObject:object];
}



- (void)didRequestMyDiscountCouponWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_discountCouponProtocol>)object
{
    [self.discountCouponOperation didRequestDiscountCouponWithCourseInfo:infoDic withNotifiedObject:object];
}

- (void)didRequestAcquireDiscountCouponWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_AcquireDiscountCouponProtocol>)object
{
    [self.acquireDisCountOperation didRequestAcquireDiscountCouponWithCourseInfo:infoDic withNotifiedObject:object];
}

- (void)didRequestAcquireDiscountCouponSuccessWithCourseInfo:(NSDictionary *)infoDic
{
    [self.acquireDisCountSuccessOperation didRequestAcquireDiscountCouponSuccessWithCourseInfo:infoDic];
}



- (void)didRequestGetIntegralWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_RecommendProtocol>)object
{
    [self.recommendOperation didRequestGetIntegralWithCourseInfo:infoDic withNotifiedObject:object];
}
- (void)didRequestGetRecommendIntegralWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_RecommendProtocol>)object
{
    [self.recommendOperation didRequestGetRecommendIntegralWithCourseInfo:infoDic withNotifiedObject:object];
}

- (void)didRequestAssistantWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_AssistantCenterProtocol>)object
{
    [self.assistantCenterOperation didRequestAssistantWithInfo:infoDic withNotifiedObject:object];
}

- (void)didRequestLevelDetailWithNotifiedObject:(id<UserModule_LevelDetailProtocol>)object
{
    [self.memberLevelDetailOperation didRequestMemberLevelDetailWithNotifiedObject:object];
}

- (void)didRequestSubmitOpinionWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_SubmitOperationProtocol>)object
{
    [self.submitOpinionOperation didRequestSubmitOpinionWithInfo:infoDic withNotifiedObject:object];
}

- (void)didRequestCommonProblemWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_CommonProblem>)object
{
    [self.commonProblemOperation didRequestCommonProblemWithNotifiedObject:object];
}

- (void)didRequestGiftListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GiftList>)object
{
    [self.giftLIstOperation didRequestGiftListWithInfo:infoDic withNotifiedObject:object];
}

- (void)didRequestSubmitGiftCodeWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_SubmitGiftCode>)object
{
    [self.submitGiftCodeOperation didRequestSubmitGiftCodeWithInfo:infoDic withNotifiedObject:object];
}

- (void)didRequestLivingBackYearListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_LivingBackYearList>)object
{
    [self.livingBackYearLiatOperation didRequestLivingBackYearListWithInfo:infoDic withNotifiedObject:object];
}

- (void)didRequestVerifyInAppPurchaseWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_VerifyInAppPurchase>)object
{
    [self.verifyInAppPurchaseOperation didRequestVerifyInAppPurchaseWithInfo:infoDic withNotifiedObject:object];
}

- (void)didRequestMyCoinsWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_MyCoin>)object
{
    [self.myCoinOperation didRequestMyCoinWithNotifiedObject:object];
}

- (void)logout
{
    [self.loginOperation clearLoginUserInfo];
}

- (void)refreshRCDUserInfoWithNickName:(NSString *)nickName andWithPortraitUrl:(NSString *)portraitUrl
{
//    RCUserInfo *user = [RCUserInfo new];
//
//    user.userId = [NSString stringWithFormat:@"%d", [UserManager sharedManager].getUserId];
//    user.name = nickName.length > 0 ? nickName : [[UserManager sharedManager] getUserNickName];
//    user.portraitUri = portraitUrl.length > 0 ? portraitUrl : [[UserManager sharedManager] getIconUrl];
//
//    [[RCIM sharedRCIM]refreshUserInfoCache:user withUserId:user.userId];
}

- (int)getUserId
{
    return self.userModuleModels.currentUserModel.userID;
}

- (int)getUserIdFromRegidster
{
    return self.registOperation.userID;
}

- (int)getCodeview
{
    return self.userModuleModels.currentUserModel.codeview;
}

- (void)changeCodeViewWith:(int)codeView
{
    self.userModuleModels.currentUserModel.codeview = codeView;
}

- (void)didRequestBindJPushWithCID:(NSString *)cid withNotifiedObject:(id<UserModule_BindJPushProtocol>)object
{
    [self.bindJPushOperation didRequestBindJPushWithCID:cid withNotifiedObject:object];
}


- (void)didRequestOrderLivingCourseOperationWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_OrderLivingCourseProtocol>)object
{
    [self.orderLivingCourseOperation didRequestOrderLivingCourseWithCourseInfo:infoDic withNotifiedObject:object];
}

- (void)didRequestCancelOrderLivingCourseOperationWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_CancelOrderLivingCourseProtocol>)object
{
    [self.cancelOrderLivingCOurseOperation didRequestCancelOrderLivingCourseWithCourseInfo:infoDic withNotifiedObject:object];
}

- (BOOL)isUserLogin
{
    return self.userModuleModels.currentUserModel.isLogin;
}

- (NSString *)getUserName
{
    return self.userModuleModels.currentUserModel.userName;
}
- (NSString *)getUserNickName
{
    return self.userModuleModels.currentUserModel.userNickName;
}

- (NSString *)getVerifyCode
{
    return self.verifyCodeOperation.verifyCode;
}

- (NSString *)getVerifyPhoneNumber
{
    return self.verfyAccountOperation.verifyPhoneNumber;
}

- (NSString *)getRongToken
{
    return self.userModuleModels.currentUserModel.rongToken;
}
- (NSString *)getIconUrl
{
    return self.userModuleModels.currentUserModel.headImageUrl;
}
- (int)getUserLevel
{
    return self.userModuleModels.currentUserModel.level;
}

- (NSString *)getLevelStr
{
    NSString * levelStr = @"";
    switch (self.userModuleModels.currentUserModel.level) {
        case 1:
            levelStr = @"普通会员";
            break;
        case 2:
            levelStr = @"试听会员";
            break;
        case 3:
        {
            if ([self isHaveMemberLevel]) {
                levelStr = self.userModuleModels.currentUserModel.levelDetail;
            }else
            {
                levelStr = @"正式会员";
            }
        }
            break;
            
        default:
            break;
    }
    return levelStr;
}

- (BOOL)isHaveMemberLevel
{
    NSString * levelDetail = self.userModuleModels.currentUserModel.levelDetail ;
    if ([levelDetail isEqualToString:@"K1"] || [levelDetail isEqualToString:@"K2"] || [levelDetail isEqualToString:@"K3"] || [levelDetail isEqualToString:@"K4"] || [levelDetail isEqualToString:@"K5"] || [levelDetail isEqualToString:@"K6"] || [levelDetail isEqualToString:@"K7"]) {
        return YES;
    }else
    {
        return NO;
    }
}

- (NSDictionary *)getUserInfos
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if (self.userModuleModels.currentUserModel.userID == 0) {
        return dic;
    }
    
    [dic setObject:self.userModuleModels.currentUserModel.userName forKey:kUserName];
    [dic setObject:@(self.userModuleModels.currentUserModel.userID) forKey:kUserId];
    [dic setObject:self.userModuleModels.currentUserModel.userNickName forKey:kUserNickName];
    
    [dic setObject:self.userModuleModels.currentUserModel.headImageUrl forKey:kUserHeaderImageUrl];
    [dic setObject:self.userModuleModels.currentUserModel.telephone forKey:kUserTelephone];
    [dic setObject:@(self.userModuleModels.currentUserModel.level) forKey:kUserLevel];
    [dic setObject:self.userModuleModels.currentUserModel.levelDetail forKey:kUserLevelDetail];
    [dic setObject:@(self.userModuleModels.currentUserModel.amount) forKey:kAmount];
    [dic setObject:@(self.userModuleModels.currentUserModel.point) forKey:kPoint];
    [dic setObject:@(self.userModuleModels.currentUserModel.exp) forKey:kExp];
    [dic setObject:@(self.userModuleModels.currentUserModel.status) forKey:kStatus];
    [dic setObject:@(self.userModuleModels.currentUserModel.group_id) forKey:kGroup_id];
    [dic setObject:self.userModuleModels.currentUserModel.group_name forKey:kGroup_name];

    return dic;
}
- (int)getCurrentInteger
{
    return self.userModuleModels.currentUserModel.point;
}

- (int)getCurrentAmount
{
    return self.userModuleModels.currentUserModel.amount;
}

- (void)refreshUserInfoWith:(NSDictionary *)infoDic
{
//    RCUserInfo *user = [RCUserInfo new];
    
    
    if ([infoDic objectForKey:@"icon"] && [[infoDic objectForKey:@"icon"] length] > 0) {
        self.userModuleModels.currentUserModel.headImageUrl = [infoDic objectForKey:@"icon"];
//        user.portraitUri = [infoDic objectForKey:@"icon"];
    }else
    {
//        user.portraitUri = [[UserManager sharedManager] getIconUrl];
    }
    
    if ([infoDic objectForKey:@"phoneNumber"] && [[infoDic objectForKey:@"phoneNumber"] length] > 0) {
        self.userModuleModels.currentUserModel.telephone = [infoDic objectForKey:@"phoneNumber"];
    }
    
    if ([infoDic objectForKey:@"nickName"] && [[infoDic objectForKey:@"nickName"] length] > 0) {
        self.userModuleModels.currentUserModel.userNickName = [infoDic objectForKey:@"nickName"];
//        user.name = [infoDic objectForKey:@"nickName"];
    }else
    {
//        user.name = [[UserManager sharedManager] getUserNickName];
    }
    
//    user.userId = [NSString stringWithFormat:@"%d", [UserManager sharedManager].getUserId];
    
//    [[RCIM sharedRCIM]refreshUserInfoCache:user withUserId:user.userId];
//    [RCIM sharedRCIM].currentUserInfo.userId = user.userId;
//    [RCIM sharedRCIM].currentUserInfo.name = user.name;
//    [RCIM sharedRCIM].currentUserInfo.portraitUri = user.portraitUri;
    NSString *dataPath = [[PathUtility getDocumentPath] stringByAppendingPathComponent:@"user.data"];
    [NSKeyedArchiver archiveRootObject:self.userModuleModels.currentUserModel toFile:dataPath];
}

- (NSDictionary *)getUpdateInfo
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.userModuleModels.appInfoModel.updateContent forKey:kAppUpdateInfoContent];
    [dic setObject:@(self.userModuleModels.appInfoModel.version) forKey:kAppUpdateInfoVersion];
    [dic setObject:self.userModuleModels.appInfoModel.downloadUrl forKey:kAppUpdateInfoUrl];
    [dic setObject:@(self.userModuleModels.appInfoModel.isForce) forKey:kAppUpdateInfoIsForce];
    return dic;
}





- (NSArray *)getAllDiscountCoupon
{
    return self.discountCouponOperation.discountCouponArray;
}

- (NSArray *)getAcquireDiscountCoupon
{
    return self.acquireDisCountOperation.discountCouponArray;
}

- (NSArray *)getNormalDiscountCoupon
{
    NSMutableArray * array = [NSMutableArray array];
    for (NSDictionary * infoDic in self.discountCouponOperation.discountCouponArray) {
        if ([[infoDic objectForKey:@"State"] intValue] == 0) {
            [array addObject:infoDic];
        }
    }
    
    return array;
}
- (NSArray *)getexpireDiscountCoupon
{
    NSMutableArray * array = [NSMutableArray array];
    for (NSDictionary * infoDic in self.discountCouponOperation.discountCouponArray) {
        if ([[infoDic objectForKey:@"State"] intValue] == 2) {
            [array addObject:infoDic];
        }
    }
    return array;
}
- (NSArray *)getCannotUseDiscountCoupon:(double)price
{
    NSMutableArray * array = [NSMutableArray array];
    
    NSMutableArray * canUseArray = [NSMutableArray array];
    NSMutableArray *cannotArray = [NSMutableArray array];
    for (NSDictionary * infoDic in self.discountCouponOperation.discountCouponArray) {
        if ([[infoDic objectForKey:@"State"] intValue] == 0 &&  [[infoDic objectForKey:@"Area"] doubleValue] <= price) {
            [canUseArray addObject:infoDic];
        }else if ([[infoDic objectForKey:@"State"] intValue] == 0)
        {
            [cannotArray addObject:infoDic];
        }
        
    }
    [array addObject:canUseArray];
    [array addObject:cannotArray];
    return array;
}
- (NSArray *)getHaveUsedDiscountCoupon
{
    NSMutableArray * array = [NSMutableArray array];
    for (NSDictionary * infoDic in self.discountCouponOperation.discountCouponArray) {
        if ([[infoDic objectForKey:@"State"] intValue] == 1) {
            [array addObject:infoDic];
        }
        
    }
    return array;
}

- (int)getIntegral
{
    return self.recommendOperation.integral;
}
- (NSDictionary *)getRecommendIntegral
{
    return self.recommendOperation.recommendInfo;
}

- (NSArray *)getAssistantList
{
    return self.assistantCenterOperation.assistantList;
}

- (NSArray *)getTelephoneList
{
    return self.assistantCenterOperation.telephoneNumberList;
}

- (NSArray *)getLevelDetailList
{
    return self.memberLevelDetailOperation.memberLevelDetailList;
}

- (NSArray *)getCommonProblemList
{
    return self.commonProblemOperation.commonProblemList;
}

- (NSArray *)getLivingBackYearList
{
    return self.livingBackYearLiatOperation.livingBackYearList;
}

- (NSArray *)getGiftList
{
    return self.giftLIstOperation.livingBackYearList;
}

- (void)resetGoldCoinCount:(int )count
{
    self.userModuleModels.currentUserModel.goldCoins = count;
}

- (int)getMyGoldCoins
{
    return self.userModuleModels.currentUserModel.goldCoins;
}


// dianzan
- (void)didRequestDianzanDetailWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodProtocol>)object
{
    [self.dianzanOperation didRequestDianzanWithInfo:infoDic withNotifiedObject:object];
}

// Collect
- (void)didRequestCollectDetailWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_CollectProtocol>)object
{
    [self.collectOperation didRequestCollectWithInfo:infoDic withNotifiedObject:object];
}

#pragma mark - club

// club
- (void)didRequestClubChannelListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelListProtocol>)object
{
    [self.clubChannelListOperation didRequestChannelListWithInfo:infoDic withNotifiedObject:object];
}
- (NSMutableArray * )getclubChannelList
{
    return self.clubChannelListOperation.channelList;
}
- (int)getClubChannelListTotalCount
{
    return self.clubChannelListOperation.totalCount;
}


// clubActivityList
- (void)didRequestClubActivityListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelListProtocol>)object
{
    [self.clubActivityListOperation didRequestChannelListWithInfo:infoDic withNotifiedObject:object];
}
- (NSMutableArray * )getclubActivityList
{
    return self.clubActivityListOperation.channelList;
}
- (int)getClubActivityListTotalCount
{
    return self.clubActivityListOperation.totalCount;
}

// clubContextList
- (void)didRequestClubContextListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelListProtocol>)object
{
    [self.clubContextListOperation didRequestChannelListWithInfo:infoDic withNotifiedObject:object];
}
- (NSMutableArray * )getclubContextList
{
    return self.clubContextListOperation.channelList;
}
- (int)getClubContextListTotalCount
{
    return self.clubContextListOperation.totalCount;
}


// aboutClub
- (void)didRequestAboutClubListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelListProtocol>)object
{
    [self.aboutClubListOperation didRequestChannelListWithInfo:infoDic withNotifiedObject:object];
}
- (NSMutableArray * )getAboutClubList
{
    return self.aboutClubListOperation.channelList;
}
- (int)getAboutClubListTotalCount
{
    return self.aboutClubListOperation.totalCount;
}

// ClubServerList
- (void)didRequestClubServerListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelListProtocol>)object
{
    [self.clubServerListOperation didRequestChannelListWithInfo:infoDic withNotifiedObject:object];
}
- (NSMutableArray * )getClubServerList
{
    return self.clubServerListOperation.channelList;
}
- (int)getClubServerListTotalCount
{
    return self.clubServerListOperation.totalCount;
}



// aboutClubDetail
- (void)didRequestAboutClubDetailWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelDetailProtocol>)object
{
    [self.aboutClubDetailOperation didRequestChannelDetailWithInfo:infoDic withNotifiedObject:object];
}
- (NSDictionary * )getAboutClubDetail
{
    return self.aboutClubDetailOperation.channelDetail;
}

// ClubActivityDetail
- (void)didRequestClubActivityDetailWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelDetailProtocol>)object
{
    [self.clubActivityDetailOperation didRequestChannelDetailWithInfo:infoDic withNotifiedObject:object];
}
- (NSDictionary * )getClubActivityDetail
{
    return self.clubActivityDetailOperation.channelDetail;
}

// ClubContestDetail
- (void)didRequestClubContestDetailWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelDetailProtocol>)object
{
    [self.clubContestDetailOperation didRequestChannelDetailWithInfo:infoDic withNotifiedObject:object];
}
- (NSDictionary * )getClubContestDetail
{
    return self.clubContestDetailOperation.channelDetail;
}

// ClubServerDetail
- (void)didRequestClubServerDetailWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelDetailProtocol>)object
{
    [self.clubServerDetailOperation didRequestChannelDetailWithInfo:infoDic withNotifiedObject:object];
}
- (NSDictionary * )getClubServerDetail
{
    return self.clubServerDetailOperation.channelDetail;
}


// VIPCustom
- (void)didRequestVIPCustomWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_VIPCustomProtocol>)object
{
    [self.vipCustomOperation didRequestVIPCustomWithInfo:infoDic withNotifiedObject:object];
}
- (NSDictionary * )getVIPCustom
{
    return self.vipCustomOperation.channelDetail;
}


- (void)didRequestXiShaMeiShiList_ClubWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_XishameishiListProtocol>)object
{
    [self.xishameishiOperation didRequestChannelListWithInfo:infoDic withNotifiedObject:object];
}
- (NSMutableArray * )getXiShaMeiShi_clubList
{
    return self.xishameishiOperation.channelList;
}

- (void)didRequestXiShaMeiShiDetailWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_XishameishiDetailProtocol>)object
{
    [self.xishameishiDetailOperation didRequestChannelDetailWithInfo:infoDic withNotifiedObject:object];
}
- (NSDictionary * )getXiShaMeiShiDetailInfo
{
    return self.xishameishiDetailOperation.channelDetail;
}

// FoodMakeList
- (void)didRequestFoodMakeList_ClubWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_MeishizhizuoListProtocol>)object
{
    [self.meishizhizuoOperation didRequestChannelListWithInfo:infoDic withNotifiedObject:object];
}
- (NSMutableArray * )getFoodMake_clubList
{
    return self.meishizhizuoOperation.channelList;
}


- (void)didRequestYuleShipin_ClubWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_YuleshipinListProtocol>)object
{
    [self.yuleshipinOperation didRequestChannelListWithInfo:infoDic withNotifiedObject:object];
}
- (NSMutableArray * )getYuLeShiPin_clubList
{
    return self.yuleshipinOperation.channelList;
}


#pragma mark - xisha food

// StoreTodayGoodFoodList
- (void)didRequestStore_todayGoodFoodListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelListProtocol>)object
{
     [self.storeTodayGoodFoodListOperation didRequestChannelListWithInfo:infoDic withNotifiedObject:object];
}
- (NSMutableArray * )getStoreTodayGoodFoodList
{
    return self.storeTodayGoodFoodListOperation.channelList;
}
- (int)getStoreTodayGoodFoodListTotalCount
{
    return self.storeTodayGoodFoodListOperation.totalCount;
}

// StoreGoodFoodList
- (void)didRequestStoreGoodFoodListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelListProtocol>)object
{
    [self.storeGoodFoodListOperation didRequestChannelListWithInfo:infoDic withNotifiedObject:object];
}
- (NSMutableArray * )getStoreGoodFoodList
{
    return self.storeGoodFoodListOperation.channelList;
}
- (int)getStoreGoodFoodListTotalCount
{
    return self.storeGoodFoodListOperation.totalCount;
}

// StoreVRList
- (void)didRequestStoreVRListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelListProtocol>)object
{
    [self.storeVRListOperation didRequestChannelListWithInfo:infoDic withNotifiedObject:object];
}
- (NSMutableArray * )getStoreVRList
{
     return self.storeVRListOperation.channelList;
}
- (int)getStoreVRListTotalCount
{
    return self.storeVRListOperation.totalCount;
}

// StoreTestReportList
- (void)didRequestStoreTestReportListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelListProtocol>)object
{
    [self.storeTestReportListOperation didRequestChannelListWithInfo:infoDic withNotifiedObject:object];
}
- (NSMutableArray * )getStoreTestReportList
{
    return self.storeTestReportListOperation.channelList;
}
- (int)getStoreTestReportListTotalCount
{
    return self.storeTestReportListOperation.totalCount;
}


// FisheryHarvestList
- (void)didRequestFisheryHarvestListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelListProtocol>)object
{
    [self.fisheryHarvestListOperation didRequestChannelListWithInfo:infoDic withNotifiedObject:object];
}
- (NSMutableArray * )getFisheryHarvestList
{
    return self.fisheryHarvestListOperation.channelList;
}
- (int)getFisheryHarvestListTotalCount
{
    return self.fisheryHarvestListOperation.totalCount;
}



// EntertainmentList
- (void)didRequestEntertainmentListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelListProtocol>)object
{
    [self.entertainmentListOperation didRequestChannelListWithInfo:infoDic withNotifiedObject:object];
}
- (NSMutableArray * )getEntertainmentList
{
    return self.entertainmentListOperation.channelList;
}
- (int)getEntertainmentListTotalCount
{
    return self.entertainmentListOperation.totalCount;
}

// FoodMakeList
- (void)didRequestFoodMakeListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelListProtocol>)object
{
    [self.foodmakeListOperation didRequestChannelListWithInfo:infoDic withNotifiedObject:object];
}
- (NSMutableArray * )getFoodMakeList
{
    return self.foodmakeListOperation.channelList;
}
- (int)getFoodMakeListTotalCount
{
    return self.foodmakeListOperation.totalCount;
}


#pragma mark - comment
- (void)didRequestCommentListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelListProtocol>)object
{
    [self.commentListOperation didRequestChannelListWithInfo:infoDic withNotifiedObject:object];
}
- (NSMutableArray * )getCommentList
{
    return self.commentListOperation.channelList;
}
- (int)getCommentListTotalCount
{
    return self.commentListOperation.totalCount;
}


// save comment
- (void)didRequestSaveCommentWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_SaveCommentProtocol>)object
{
    [self.saveCommentOperation didRequestSaveCommentWithInfo:infoDic withNotifiedObject:object];
}


#pragma mark - VIPCustom
- (void)didRequestVIPCustomListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelListProtocol>)object
{
    [self.vipCustomListOperation didRequestChannelListWithInfo:infoDic withNotifiedObject:object];
}

- (NSMutableArray * )getVIPCustomList
{
    return self.vipCustomListOperation.channelList;
}

- (int)getVIPCustomListTotalCount
{
    return self.vipCustomListOperation.totalCount;
}

@end
