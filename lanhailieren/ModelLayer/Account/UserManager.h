//
//  UserManager.h
//  Accountant
//
//  Created by aaa on 2017/2/27.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModuleProtocol.h"

@interface UserManager : NSObject

@property (nonatomic, strong)NSDictionary * currentSelectStore;// 当前选中门店
@property (nonatomic, strong)NSDictionary * currentSelectAddressInfo;// 当前选中门店

+ (instancetype)sharedManager;

@property (nonatomic, strong)UIViewController * currentShareVC;

/**
 请求登陆接口

 @param userName 用户名
 @param pwd 密码
 @param object 请求成功后通知的对象
 */
- (void)loginWithUserName:(NSString *)userName
              andPassword:(NSString *)pwd
       withNotifiedObject:(id<UserModule_LoginProtocol>)object;

// 短信验证码登录
- (void)didLoginWith:(NSDictionary *)info withNotifiedObject:(id<UserModule_LoginProtocol>)object;

// 注册
- (void)registWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_RegistProtocol>)object;

// 完善个人信息
- (void)completeUserInfoWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_CompleteUserInfoProtocol>)object;

/**
 退出登录
 */
- (void)logout;

/**
 判断是否已经登陆
 
 @return 是否登陆
 */
- (BOOL)isUserLogin;

/**
 获取用户id
 
 @return 用户id
 */
- (int)getUserId;

- (int)getUserIdFromRegidster;

/**
 获取用户名
 
 @return 用户名
 */
- (NSString *)getUserName;

/**
 获取昵称
 
 @return 昵称
 */
- (NSString *)getUserNickName;

/**
 获取验证码
 
 @return 验证码
 */
- (NSString *)getVerifyCode;

/**
 获取绑定手机号
 
 @return 已绑定手机号
 */
- (NSString *)getVerifyPhoneNumber;



//- (void)didRequestUserInfoWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_LoginProtocol>)object;

/**
 获取用户信息
 @return 用户信息
 */
- (NSDictionary *)getUserInfos;

- (int)getCurrentInteger;
- (int)getCurrentAmount;

- (void)refreshUserInfoWith:(NSDictionary *)infoDic;

// 获取收货地址
- (void)getAddressListWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_AddressListProtocol>)object;
// 编辑收货地址
- (void)editAddressWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_EditAddressProtocol>)object;
- (NSArray *)getAddressList;
// 删除地址
- (void)didRequestDeleteAddressWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_DeleteAddressProtocol>)object;

// 获取我的积分
- (void)didRequestIntegralDetailListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_RecommendProtocol>)object;
- (NSMutableArray * )getIntegerDetailList;
- (int )getIntegerDetailListTotalCount;


- (void)didRequestGetIntegralWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_RecommendProtocol>)object;

- (void)didRequestGetRecommendIntegralWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_RecommendProtocol>)object;

- (int)getIntegral;
- (NSDictionary *)getRecommendIntegral;

// Recharge Detail List
- (void)didRequestRechargeDetailListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_RechargeDetailListProtocol>)object;
- (NSMutableArray * )getRechargeDetailList;
- (int )getRechargeDetailListTotalCount;

// GoodCategory
- (void)didRequestGoodCategoryListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodCategoryProtocol>)object;
- (NSMutableArray * )getGoodCategoryList;

// xishaFood
- (void)didRequestXishaFoodCategoryListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodCategoryProtocol>)object;
- (NSMutableArray * )getXishaFoodCategoryList;

// fisheryHarvest
- (void)didRequestFisheryHarvestCategoryListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodCategoryProtocol>)object;
- (NSMutableArray * )getFisheryHarvestCategoryList;

// foodmake
- (void)didRequestFoodMakeCategoryListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodCategoryProtocol>)object;
- (NSMutableArray * )getFoodMakeCategoryList;

// arder
- (void)didRequestArderCategoryListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodCategoryProtocol>)object;
- (NSMutableArray * )getArderCategoryList;

// clubactivity
- (void)didRequestClubActivityCategoryListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodCategoryProtocol>)object;
- (NSMutableArray * )getClubActivityCategoryList;

// clubactivity
- (void)didRequestAboutClubCategoryListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodCategoryProtocol>)object;
- (NSMutableArray * )getAboutClubCategoryList;


// GoodList
- (void)didRequestGoodListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodListProtocol>)object;
- (NSMutableArray * )getGoodList;
- (int)getGoodListTotalCount;

// 精品商品列表
- (void)didRequestGoodListQualityWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodList_qualityProtocol>)object;
- (NSMutableArray * )getGoodList_quality;
// 推荐商品列表
- (void)didRequestGoodListRecommendWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodList_recommendProtocol>)object;
- (NSMutableArray * )getGoodList_Recommend;

// 商品详情
- (void)didRequestGoodDetailWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodDetailProtocol>)object;
- (NSDictionary * )getGoodDetailInfo;

// 热门搜索词
- (void)HotSearchWith:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_HotSearchProtocol>)object;
// 获取订单支付详情
- (NSDictionary *)getHotSearchKeyInfo;

// 门店列表
- (void)didRequestStoreListWith:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_StoreListProtocol>)object;
// 获取门店列表
- (NSArray *)getStoreList;

// 添加购物车
- (void)didRequestAddShoppingCarWith:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_AddShoppingCarProtocol>)object;
// 删除购物车
- (void)didRequestDeleteShoppingCarWith:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_DeleteShoppingCarProtocol>)object;
// 清空购物车
- (void)didRequestCleanShoppingCarWith:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_CleanShoppingCarProtocol>)object;
// 我的购物车
- (void)didRequestShoppingCarListWith:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ShoppingCarListProtocol>)object;
// 获取购物车列表
- (NSArray *)getShoppingCarList;
// 获取我的订单列表
- (void)didRequestOrderListWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_OrderListProtocol>)object;
- (NSArray *)getMyOrderList;
- (int )getMyOrderListTotalCount;
- (void)didRequestCreateOrderWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_CreateOrderProtocol>)object;
// 取消订单
- (void)didRequestCancelOrderWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_CancelOrderProtocol>)object;

// 获取搜索词列表
- (void)didRequestSearchKeyWordListWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GetSearchKeyWordListProtocol>)object;
- (NSArray *)getSearchKeyWordList;
// 清空搜索词
- (void)didRequestCleanSearchKeyWordWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_CleanSearchKeyWordProtocol>)object;
// 保存搜索词
- (void)didRequestAddSearchKeyWordWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_AddSearchKeyWordProtocol>)object;

// 修改手机号
- (void)didRequestChangePhoneWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChangePhoneProtocol>)object;
// 修改密码
- (void)didRequestChangePasswordWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChangePasswordProtocol>)object;
// banner
- (void)didRequestBannerWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_BannerProtocol>)object;
- (NSArray *)getBannerList;

// xishaFoodBanner
- (void)didRequestXishaFoodBannerWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_BannerProtocol>)object;
- (NSArray *)getXishaFoodBannerList;

// foodMakeBanner
- (void)didRequestFoodMakeBannerWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_BannerProtocol>)object;
- (NSArray *)getFoodMakeBannerList;


// dianzan
- (void)didRequestDianzanDetailWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GoodProtocol>)object;

// Collect
- (void)didRequestCollectDetailWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_CollectProtocol>)object;

#pragma mark - club

// club
- (void)didRequestClubChannelListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelListProtocol>)object;
- (NSMutableArray * )getclubChannelList;
- (int)getClubChannelListTotalCount;

// clubActivityList
- (void)didRequestClubActivityListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelListProtocol>)object;
- (NSMutableArray * )getclubActivityList;
- (int)getClubActivityListTotalCount;

// clubContextList
- (void)didRequestClubContextListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelListProtocol>)object;
- (NSMutableArray * )getclubContextList;
- (int)getClubContextListTotalCount;

// aboutClub
- (void)didRequestAboutClubListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelListProtocol>)object;
- (NSMutableArray * )getAboutClubList;
- (int)getAboutClubListTotalCount;

// ClubServerList
- (void)didRequestClubServerListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelListProtocol>)object;
- (NSMutableArray * )getClubServerList;
- (int)getClubServerListTotalCount;


// aboutClubDetail
- (void)didRequestAboutClubDetailWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelDetailProtocol>)object;
- (NSDictionary * )getAboutClubDetail;

// ClubActivityDetail
- (void)didRequestClubActivityDetailWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelDetailProtocol>)object;
- (NSDictionary * )getClubActivityDetail;

// ClubContestDetail
- (void)didRequestClubContestDetailWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelDetailProtocol>)object;
- (NSDictionary * )getClubContestDetail;

// ClubServerDetail
- (void)didRequestClubServerDetailWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelDetailProtocol>)object;
- (NSDictionary * )getClubServerDetail;

// VIPCustom
- (void)didRequestVIPCustomWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_VIPCustomProtocol>)object;
- (NSDictionary * )getVIPCustom;


// FoodMakeList
- (void)didRequestXiShaMeiShiList_ClubWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_XishameishiListProtocol>)object;
- (NSMutableArray * )getXiShaMeiShi_clubList;

- (void)didRequestXiShaMeiShiDetailWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_XishameishiDetailProtocol>)object;
- (NSDictionary * )getXiShaMeiShiDetailInfo;

// FoodMakeList
- (void)didRequestFoodMakeList_ClubWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_MeishizhizuoListProtocol>)object;
- (NSMutableArray * )getFoodMake_clubList;

// FoodMakeList
- (void)didRequestYuleShipin_ClubWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_YuleshipinListProtocol>)object;
- (NSMutableArray * )getYuLeShiPin_clubList;



#pragma mark - xishaFood

// StoreTodayGoodFoodList
- (void)didRequestStore_todayGoodFoodListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelListProtocol>)object;
- (NSMutableArray * )getStoreTodayGoodFoodList;
- (int)getStoreTodayGoodFoodListTotalCount;

// StoreGoodFoodList
- (void)didRequestStoreGoodFoodListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelListProtocol>)object;
- (NSMutableArray * )getStoreGoodFoodList;
- (int)getStoreGoodFoodListTotalCount;

// StoreVRList
- (void)didRequestStoreVRListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelListProtocol>)object;
- (NSMutableArray * )getStoreVRList;
- (int)getStoreVRListTotalCount;

// StoreTestReportList
- (void)didRequestStoreTestReportListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelListProtocol>)object;
- (NSMutableArray * )getStoreTestReportList;
- (int)getStoreTestReportListTotalCount;


// FisheryHarvestList
- (void)didRequestFisheryHarvestListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelListProtocol>)object;
- (NSMutableArray * )getFisheryHarvestList;
- (int)getFisheryHarvestListTotalCount;


#pragma mark - arder
// EntertainmentList
- (void)didRequestEntertainmentListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelListProtocol>)object;
- (NSMutableArray * )getEntertainmentList;
- (int)getEntertainmentListTotalCount;

#pragma mark - foodMake

// FoodMakeList
- (void)didRequestFoodMakeListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelListProtocol>)object;
- (NSMutableArray * )getFoodMakeList;
- (int)getFoodMakeListTotalCount;





#pragma mark - comment
- (void)didRequestCommentListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelListProtocol>)object;
- (NSMutableArray * )getCommentList;
- (int)getCommentListTotalCount;


// save comment
- (void)didRequestSaveCommentWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_SaveCommentProtocol>)object;

#pragma mark - VIPCustom
- (void)didRequestVIPCustomListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ChannelListProtocol>)object;
- (NSMutableArray * )getVIPCustomList;
- (int)getVIPCustomListTotalCount;

/**
 请求重置密码接口

 @param oldPwd 旧密码
 @param newPwd 新密码
 @param object 请求成功后通知的对象
 */
- (void)resetPasswordWithOldPassword:(NSString *)oldPwd andNewPwd:(NSString *)newPwd withNotifiedObject:(id<UserModule_ResetPwdProtocol>)object;


// 忘记密码
- (void)forgetPsdWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ForgetPasswordProtocol>)object;

// 获取验证码
- (void)getVerifyCodeWithPhoneNumber:(NSDictionary *)info withNotifiedObject:(id<UserModule_VerifyCodeProtocol>)object;

- (void)getVerifyAccountWithAccountNumber:(NSString *)accountNumber withNotifiedObject:(id<UserModule_VerifyAccountProtocol>)object;



- (void)bindRegCodeWithRegCode:(NSString *)regCode withNotifiedObject:(id<UserModule_bindRegCodeProtocol>)object;



/**
 请求app版本信息

 @param object 请求成功后通知的对象
 */
- (void)didRequestAppVersionInfoWithNotifiedObject:(id<UserModule_AppInfoProtocol>)object;



/**
 绑定极光账号
 
 */
- (void)didRequestBindJPushWithCID:(NSString *)cid withNotifiedObject:(id<UserModule_BindJPushProtocol>)object;

/**
 预约直播课
 
 */
- (void)didRequestOrderLivingCourseOperationWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_OrderLivingCourseProtocol>)object;

/**
 取消预约直播课
 
 */
- (void)didRequestCancelOrderLivingCourseOperationWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_CancelOrderLivingCourseProtocol>)object;

//- (void)refreshRCDUserInfoWithNickName:(NSString *)nickName andWithPortraitUrl:(NSString *)portraitUrl;



/**
 获取是否显示邀请码
 
 @return 邀请码是否显示
 */
- (int)getCodeview;

- (void)changeCodeViewWith:(int)codeView;



/**
 获取融云token
 
 @return 融云tokrn
 */
- (NSString *)getRongToken;

- (NSString *)getIconUrl;



- (int)getUserLevel;

- (NSString *)getLevelStr;

- (NSDictionary *)getUpdateInfo;





/**
 获取优惠券
 
 */
- (void)didRequestMyDiscountCouponWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_discountCouponProtocol>)object;
- (NSArray *)getAllDiscountCoupon;
- (NSArray *)getNormalDiscountCoupon;
- (NSArray *)getexpireDiscountCoupon;
- (NSArray *)getCannotUseDiscountCoupon:(double)price;
- (NSArray *)getHaveUsedDiscountCoupon;

- (void)didRequestAcquireDiscountCouponWithCourseInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_AcquireDiscountCouponProtocol>)object;
- (NSArray *)getAcquireDiscountCoupon;
- (void)didRequestAcquireDiscountCouponSuccessWithCourseInfo:(NSDictionary *)infoDic;



// 客服信息
- (void)didRequestAssistantWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_AssistantCenterProtocol>)object;
- (NSArray *)getAssistantList;
- (NSArray *)getTelephoneList;

// 会员详情信息
- (void)didRequestLevelDetailWithNotifiedObject:(id<UserModule_LevelDetailProtocol>)object;
- (NSArray *)getLevelDetailList;

// 意见反馈
- (void)didRequestSubmitOpinionWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_SubmitOperationProtocol>)object;


// 常见问题
- (void)didRequestCommonProblemWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_CommonProblem>)object;
- (NSArray *)getCommonProblemList;

// 获取往期回放年份列表
- (void)didRequestLivingBackYearListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_LivingBackYearList>)object;
- (NSArray *)getLivingBackYearList;

// 福利
- (void)didRequestGiftListWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_GiftList>)object;
- (NSArray *)getGiftList;

- (void)didRequestSubmitGiftCodeWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_SubmitGiftCode>)object;

// 验证苹果支付结果
- (void)didRequestVerifyInAppPurchaseWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_VerifyInAppPurchase>)object;
- (void)resetGoldCoinCount:(int )count;

// 获取我的金币
- (int)getMyGoldCoins;
- (void)didRequestMyCoinsWithInfo:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_MyCoin>)object;
@end
