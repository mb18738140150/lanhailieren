//
//  OrderStateOperationView.m
//  lanhailieren
//
//  Created by aaa on 2020/3/12.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "OrderStateOperationView.h"

@implementation OrderStateOperationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    self.buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buyBtn.frame = CGRectMake(self.hd_width - 100, 12, 85, 26);
    self.buyBtn.layer.cornerRadius = self.buyBtn.hd_height / 2;
    self.buyBtn.layer.masksToBounds = YES;
    self.buyBtn.backgroundColor = kMainRedColor;
    [self.buyBtn setTitle:@"立即付款" forState:UIControlStateNormal];
    [self.buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.buyBtn.titleLabel.font = kMainFont_12;
    [self addSubview:self.buyBtn];
    
    self.orderDetailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.orderDetailBtn.frame = CGRectMake(self.buyBtn.hd_x - 100, 12, 85, 26);
    self.orderDetailBtn.layer.cornerRadius = self.buyBtn.hd_height / 2;
    self.orderDetailBtn.layer.masksToBounds = YES;
    self.orderDetailBtn.layer.borderWidth = 1;
    self.orderDetailBtn.layer.borderColor = kMainRedColor.CGColor;
    self.orderDetailBtn.backgroundColor = [UIColor whiteColor];
    [self.orderDetailBtn setTitle:@"查看看详情" forState:UIControlStateNormal];
    [self.orderDetailBtn setTitleColor:kMainRedColor forState:UIControlStateNormal];
    self.orderDetailBtn.titleLabel.font = kMainFont_12;
    [self addSubview:self.orderDetailBtn];
    
    self.cancelOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelOrderBtn.frame = CGRectMake(self.orderDetailBtn.hd_x - 100, 12, 85, 26);
    self.cancelOrderBtn.layer.cornerRadius = self.buyBtn.hd_height / 2;
    self.cancelOrderBtn.layer.masksToBounds = YES;
    self.cancelOrderBtn.layer.borderWidth = 1;
    self.cancelOrderBtn.layer.borderColor = UIColorFromRGB(0x696969).CGColor;
    self.cancelOrderBtn.backgroundColor = [UIColor whiteColor];
    [self.cancelOrderBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    [self.cancelOrderBtn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    self.cancelOrderBtn.titleLabel.font = kMainFont_12;
    [self addSubview:self.cancelOrderBtn];
    
    self.recieveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.recieveBtn.frame = CGRectMake(self.hd_width - 100, 12, 85, 26);
    self.recieveBtn.layer.cornerRadius = self.recieveBtn.hd_height / 2;
    self.recieveBtn.layer.masksToBounds = YES;
    self.recieveBtn.backgroundColor = kMainRedColor;
    [self.recieveBtn setTitle:@"确认收货" forState:UIControlStateNormal];
    [self.recieveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.recieveBtn.titleLabel.font = kMainFont_12;
    [self addSubview:self.recieveBtn];
    
    self.deliveryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deliveryBtn.frame = CGRectMake(self.buyBtn.hd_x - 100, 12, 85, 26);
    self.deliveryBtn.layer.cornerRadius = self.recieveBtn.hd_height / 2;
    self.deliveryBtn.layer.masksToBounds = YES;
    self.deliveryBtn.layer.borderWidth = 1;
    self.deliveryBtn.layer.borderColor = kMainRedColor.CGColor;
    self.deliveryBtn.backgroundColor = [UIColor whiteColor];
    [self.deliveryBtn setTitle:@"查看物流" forState:UIControlStateNormal];
    [self.deliveryBtn setTitleColor:kMainRedColor forState:UIControlStateNormal];
    self.deliveryBtn.titleLabel.font = kMainFont_12;
    [self addSubview:self.deliveryBtn];
    
    self.buyBtn.hidden = YES;
    self.orderDetailBtn.hidden = YES;
    self.cancelOrderBtn.hidden = YES;
    self.recieveBtn.hidden = YES;
    self.deliveryBtn.hidden = YES;
    
//    self.backgroundColor = [UIColor redColor];
    
    [self.buyBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.orderDetailBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelOrderBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.recieveBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.deliveryBtn addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)operationAction:(UIButton *)button
{
    OrderOpreation operation = OrderOpreation_buy;
    if ([button isEqual:self.buyBtn]) {
        operation = OrderOpreation_buy;
    }else if ([button isEqual:self.orderDetailBtn]){
        operation = OrderOpreation_orderDetail;
    }else if ([button isEqual:self.cancelOrderBtn]){
        operation = OrderOpreation_cancelOrder;
    }
    else if ([button isEqual:self.recieveBtn]){
        operation = OrderOpreation_recieve;
    }
    else if ([button isEqual:self.deliveryBtn]){
        operation = OrderOpreation_delivery;
    }
    
    if (self.orderOperationBlock) {
        self.orderOperationBlock(operation);
    }
    
}

- (void)setOrderState:(OrderState)orderState
{
    switch (orderState) {
        case OrderState_nop_a_y:
            {
                self.buyBtn.hidden = NO;
                self.orderDetailBtn.hidden = NO;
                self.cancelOrderBtn.hidden = NO;
            }
            break;
        case OrderState_delivery:
        {
            self.deliveryBtn.hidden = NO;
            self.orderDetailBtn.hidden = NO;
            self.cancelOrderBtn.hidden = NO;
            self.deliveryBtn.frame = CGRectMake(self.hd_width - 100, 12, 85, 26);
            self.orderDetailBtn.frame = CGRectMake(self.deliveryBtn.hd_x - 100, 12, 85, 26);
            self.cancelOrderBtn.frame = CGRectMake(self.orderDetailBtn.hd_x - 100, 12, 85, 26);
        }
            break;
        case OrderState_no_delivery:
        {
            self.deliveryBtn.hidden = NO;
            self.orderDetailBtn.hidden = NO;
            self.cancelOrderBtn.hidden = NO;
            self.deliveryBtn.frame = CGRectMake(self.hd_width - 100, 12, 85, 26);
            self.orderDetailBtn.frame = CGRectMake(self.deliveryBtn.hd_x - 100, 12, 85, 26);
            self.cancelOrderBtn.frame = CGRectMake(self.orderDetailBtn.hd_x - 100, 12, 85, 26);
        }
            break;
        case OrderState_complate:
        {
            self.orderDetailBtn.hidden = NO;
            self.orderDetailBtn.frame = CGRectMake(self.hd_width - 100, 12, 85, 26);
        }
            break;
        case OrderState_void:
        {
            self.orderDetailBtn.hidden = NO;
            self.orderDetailBtn.frame = CGRectMake(self.hd_width - 100, 12, 85, 26);
        }
            break;
        case OrderState_cancel:
        {
            self.orderDetailBtn.hidden = NO;
            self.orderDetailBtn.frame = CGRectMake(self.hd_width - 100, 12, 85, 26);
        }
            break;
            
        default:
            break;
    }
}

@end
