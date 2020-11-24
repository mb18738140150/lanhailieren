//
//  OrderStateOperationView.h
//  lanhailieren
//
//  Created by aaa on 2020/3/12.
//  Copyright © 2020 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    OrderState_nop_a_y,
    OrderState_delivery,
    OrderState_no_delivery,
    OrderState_goods,
    OrderState_complate,
    OrderState_cancel,
    OrderState_void,
} OrderState;

typedef enum : NSUInteger {
    OrderOpreation_buy,
    OrderOpreation_orderDetail,
    OrderOpreation_cancelOrder,
    OrderOpreation_recieve,
    OrderOpreation_delivery,
} OrderOpreation;

@interface OrderStateOperationView : UIView

@property (nonatomic, strong)UIButton * cancelOrderBtn;
@property (nonatomic, strong)UIButton * orderDetailBtn;
@property (nonatomic, strong)UIButton * buyBtn;
@property (nonatomic, strong)UIButton * deliveryBtn;
@property (nonatomic, strong)UIButton * recieveBtn;

@property (nonatomic, assign)OrderState orderState;

@property (nonatomic, copy)void(^orderOperationBlock)(OrderOpreation orderOperation);

@end
