//
//  UserModuleProtocol.h
//  Accountant
//
//  Created by aaa on 2017/3/2.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UserModule_LoginProtocol <NSObject>

- (void)didUserLoginSuccessed;

- (void)didUserLoginFailed:(NSString *)failedInfo;

@end

@protocol UserModule_SaveCommentProtocol <NSObject>

- (void)didSaveCommentSuccessed;

- (void)didSaveCommentFailed:(NSString *)failedInfo;

@end

@protocol UserModule_AddressListProtocol <NSObject>

- (void)didAddressListSuccessed;

- (void)didAddressListFailed:(NSString *)failedInfo;

@end


@protocol UserModule_XishameishiListProtocol <NSObject>

- (void)didXishameishiListSuccessed;

- (void)didXishameishiListFailed:(NSString *)failedInfo;

@end

@protocol UserModule_MeishizhizuoListProtocol <NSObject>

- (void)didMeishizhizuoListSuccessed;

- (void)didMeishizhizuoListFailed:(NSString *)failedInfo;

@end

@protocol UserModule_YuleshipinListProtocol <NSObject>

- (void)didYuleshipinListSuccessed;

- (void)didYuleshipinListFailed:(NSString *)failedInfo;

@end


@protocol UserModule_EditAddressProtocol <NSObject>

- (void)didEditAddressSuccessed;

- (void)didEditAddressFailed:(NSString *)failedInfo;

@end

@protocol UserModule_IntegerDetailListProtocol <NSObject>

- (void)didRequestIntegerDetailListSuccessed;
- (void)didRequestIntegerDetailListFailed:(NSString *)failedInfo;

@end

@protocol UserModule_RechargeDetailListProtocol <NSObject>

- (void)didRequestRechargeDetailListSuccessed;
- (void)didRequestRechargeDetailListFailed:(NSString *)failedInfo;

@end


@protocol UserModule_RecommendProtocol <NSObject>

- (void)didRequestRecommendSuccessed;
- (void)didRequestRecommendFailed:(NSString *)failedInfo;

@end

@protocol UserModule_GoodCategoryProtocol <NSObject>

- (void)didRequestGoodCategorySuccessed;
- (void)didRequestGoodCategoryFailed:(NSString *)failedInfo;

@end

@protocol UserModule_GoodListProtocol <NSObject>

- (void)didRequestGoodListSuccessed;
- (void)didRequestGoodListFailed:(NSString *)failedInfo;

@end

@protocol UserModule_GoodList_recommendProtocol <NSObject>

- (void)didRequestGoodList_recommendSuccessed;
- (void)didRequestGoodList_recommendFailed:(NSString *)failedInfo;

@end

@protocol UserModule_GoodList_qualityProtocol <NSObject>

- (void)didRequestGoodList_qualitySuccessed;
- (void)didRequestGoodList_qualityFailed:(NSString *)failedInfo;

@end

@protocol UserModule_GoodDetailProtocol <NSObject>

- (void)didRequestGoodDetailSuccessed;
- (void)didRequestGoodDetailFailed:(NSString *)failedInfo;

@end

@protocol UserModule_HotSearchProtocol <NSObject>

- (void)didRequestHotSearchKeyListSuccessed;
- (void)didRequestHotSearchKeyListFailed:(NSString *)failedInfo;

@end

@protocol UserModule_StoreListProtocol <NSObject>

- (void)didRequestStoreListKeyListSuccessed;
- (void)didRequestStoreListKeyListFailed:(NSString *)failedInfo;

@end
@protocol UserModule_AddShoppingCarProtocol <NSObject>

- (void)didRequestAddShoppingCarSuccessed;
- (void)didRequestAddShoppingCarFailed:(NSString *)failedInfo;

@end

@protocol UserModule_XishameishiDetailProtocol <NSObject>

- (void)didRequestXishameishiDetailSuccessed;
- (void)didRequestXishameishiDetailFailed:(NSString *)failedInfo;

@end


@protocol UserModule_DeleteShoppingCarProtocol <NSObject>

- (void)didRequestDeleteShoppingCarSuccessed;
- (void)didRequestDeleteShoppingCarFailed:(NSString *)failedInfo;

@end

@protocol UserModule_ShoppingCarListProtocol <NSObject>

- (void)didRequestShoppingCarListSuccessed;
- (void)didRequestShoppingCarListFailed:(NSString *)failedInfo;

@end

@protocol UserModule_CleanShoppingCarProtocol <NSObject>

- (void)didRequestCleanShoppingCarSuccessed;
- (void)didRequestCleanShoppingCarFailed:(NSString *)failedInfo;

@end
@protocol UserModule_OrderListProtocol <NSObject>

- (void)didRequestOrderListSuccessed;
- (void)didRequestOrderListFailed:(NSString *)failedInfo;

@end

@protocol UserModule_CreateOrderProtocol <NSObject>

- (void)didRequestCreateOrderSuccessed;
- (void)didRequestCreateOrderFailed:(NSString *)failedInfo;

@end

@protocol UserModule_AddSearchKeyWordProtocol <NSObject>

- (void)didRequestAddSearchKeyWordSuccessed;
- (void)didRequestAddSearchKeyWordFailed:(NSString *)failedInfo;

@end

@protocol UserModule_CleanSearchKeyWordProtocol <NSObject>

- (void)didRequestCleanSearchKeyWordSuccessed;
- (void)didRequestCleanSearchKeyWordFailed:(NSString *)failedInfo;

@end

@protocol UserModule_GetSearchKeyWordListProtocol <NSObject>

- (void)didRequestGetSearchKeyWordListSuccessed;
- (void)didRequestGetSearchKeyWordListFailed:(NSString *)failedInfo;

@end

@protocol UserModule_ChannelListProtocol <NSObject>

- (void)didRequestChannelListSuccessed;
- (void)didRequestChannelListFailed:(NSString *)failedInfo;

@end

@protocol UserModule_ChannelDetailProtocol <NSObject>

- (void)didRequestChannelDetailSuccessed;
- (void)didRequestChannelDetailFailed:(NSString *)failedInfo;

@end

@protocol UserModule_VIPCustomProtocol <NSObject>

- (void)didRequestVIPCustomSuccessed;
- (void)didRequestVIPCustomFailed:(NSString *)failedInfo;

@end

@protocol UserModule_GoodProtocol <NSObject>

- (void)didRequestGoodSuccessed;
- (void)didRequestGoodFailed:(NSString *)failedInfo;

@end

@protocol UserModule_CollectProtocol <NSObject>

- (void)didRequestCollectSuccessed;
- (void)didRequestCollectFailed:(NSString *)failedInfo;

@end

@protocol UserModule_CancelOrderProtocol <NSObject>

- (void)didRequestCancelOrderSuccessed;
- (void)didRequestCancelOrderFailed:(NSString *)failedInfo;

@end

@protocol UserModule_DeleteAddressProtocol <NSObject>

- (void)didRequestDeleteAddressSuccessed;
- (void)didRequestDeleteAddressFailed:(NSString *)failedInfo;

@end

@protocol UserModule_ChangePasswordProtocol <NSObject>

- (void)didRequestChangePasswordSuccessed;
- (void)didRequestChangePasswordFailed:(NSString *)failedInfo;

@end

@protocol UserModule_ChangePhoneProtocol <NSObject>

- (void)didRequestChangePhoneSuccessed;
- (void)didRequestChangePhoneFailed:(NSString *)failedInfo;

@end

@protocol UserModule_BannerProtocol <NSObject>

- (void)didRequestBannerSuccessed;
- (void)didRequestBannerFailed:(NSString *)failedInfo;

@end























@protocol UserModule_VerifyAccountProtocol <NSObject>

- (void)didVerifyAccountSuccessed;
- (void)didVerifyAccountFailed:(NSString *)failInfo;

@end

@protocol UserModule_RegistProtocol <NSObject>

- (void)didRegistSuccessed;
- (void)didRegistFailed:(NSString *)failInfo;

@end

@protocol UserModule_CompleteUserInfoProtocol <NSObject>

- (void)didCompleteUserSuccessed;
- (void)didCompleteUserFailed:(NSString *)failInfo;

@end

@protocol UserModule_ForgetPasswordProtocol <NSObject>

- (void)didForgetPasswordSuccessed;
- (void)didForgetPasswordFailed:(NSString *)failInfo;

@end

@protocol UserModule_VerifyCodeProtocol <NSObject>

- (void)didVerifyCodeSuccessed;
- (void)didVerifyCodeFailed:(NSString *)failInfo;

@end

@protocol UserModule_ResetPwdProtocol <NSObject>

- (void)didResetPwdSuccessed;
- (void)didResetPwdFailed:(NSString *)failInfo;

@end

@protocol UserModule_AppInfoProtocol <NSObject>

- (void)didRequestAppInfoSuccessed;
- (void)didRequestAppInfoFailed:(NSString *)failedInfo;

@end
@protocol UserModule_BindJPushProtocol <NSObject>

- (void)didRequestBindJPushSuccessed;
- (void)didRequestBindJPushFailed:(NSString *)failedInfo;

@end
@protocol UserModule_OrderLivingCourseProtocol <NSObject>

- (void)didRequestOrderLivingSuccessed;
- (void)didRequestOrderLivingFailed:(NSString *)failedInfo;

@end
@protocol UserModule_CancelOrderLivingCourseProtocol <NSObject>

- (void)didRequestCancelOrderLivingSuccessed;
- (void)didRequestCancelOrderLivingFailed:(NSString *)failedInfo;

@end
@protocol UserModule_bindRegCodeProtocol <NSObject>

- (void)didRequestbindRegCodeSuccessed;
- (void)didRequestbindRegCodeFailed:(NSString *)failedInfo;

@end



@protocol UserModule_discountCouponProtocol <NSObject>

- (void)didRequestDiscountCouponSuccessed;
- (void)didRequestDiscountCouponFailed:(NSString *)failedInfo;

@end

@protocol UserModule_AcquireDiscountCouponProtocol <NSObject>

- (void)didRequestAcquireDiscountCouponSuccessed;
- (void)didRequestAcquireDiscountCouponFailed:(NSString *)failedInfo;

@end





@protocol UserModule_AssistantCenterProtocol <NSObject>

- (void)didRequestAssistantCenterSuccessed;
- (void)didRequestAssistantCenterFailed:(NSString *)failedInfo;

@end

@protocol UserModule_LevelDetailProtocol <NSObject>

- (void)didRequestLevelDetailSuccessed;
- (void)didRequestLevelDetailFailed:(NSString *)failedInfo;

@end

@protocol UserModule_SubmitOperationProtocol <NSObject>

- (void)didRequestSubmitOperationSuccessed;
- (void)didRequestSubmitOperationFailed:(NSString *)failedInfo;

@end

@protocol UserModule_CommonProblem <NSObject>

- (void)didRequestCommonProblemSuccessed;
- (void)didRequestCommonProblemFailed:(NSString *)failedInfo;

@end

@protocol UserModule_LivingBackYearList <NSObject>

- (void)didRequestLivingBackYearListSuccessed;
- (void)didRequestLivingBackYearListFailed:(NSString *)failedInfo;

@end

@protocol UserModule_GiftList <NSObject>

- (void)didRequestGiftListSuccessed;
- (void)didRequestGiftListFailed:(NSString *)failedInfo;

@end

@protocol UserModule_SubmitGiftCode <NSObject>

- (void)didRequestSubmitGiftCodeSuccessed;
- (void)didRequestSubmitGiftCodeFailed:(NSString *)failedInfo;

@end

@protocol UserModule_VerifyInAppPurchase <NSObject>

- (void)didRequestInAppPurchaseSuccessed;
- (void)didRequestInAppPurchaseFailed:(NSString *)failedInfo;

@end

@protocol UserModule_MyCoin <NSObject>

- (void)didRequestMyCoinSuccessed;
- (void)didRequestMyCoinFailed:(NSString *)failedInfo;

@end
