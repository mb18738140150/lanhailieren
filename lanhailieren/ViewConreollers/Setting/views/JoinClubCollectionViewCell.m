//
//  JoinClubCollectionViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/6/16.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "JoinClubCollectionViewCell.h"

#import "GeocodeAnnotation.h"
#import "ErrorInfoUtility.h"
#import "AFNetworking.h"

@interface JoinClubCollectionViewCell()<AMapSearchDelegate,MAMapViewDelegate,AMapSearchDelegate>

@property (nonatomic, strong)AMapSearchAPI * search;
@property (nonatomic, strong)UIImageView * mapImageView;

@end

@implementation JoinClubCollectionViewCell


- (void)refreshUIWith:(NSDictionary *)infoDic
{
    [self.contentView removeAllSubviews];
    self.infoDic = infoDic;
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.hd_width, 100)];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 5;
    [self.contentView addSubview:self.backView];
    
    self.iconImageVIew = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.hd_width, self.hd_width * 0.5)];
    
    [self.iconImageVIew sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kRootImageUrl,[infoDic objectForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:@"placeholdImage"]];
    [self.backView addSubview:self.iconImageVIew];
    UIBezierPath * bezierpath = [UIBezierPath bezierPathWithRoundedRect:self.iconImageVIew.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer * shapLayer = [[CAShapeLayer alloc]init];
    shapLayer.frame = self.iconImageVIew.bounds;
    shapLayer.path = bezierpath.CGPath;
    [self.iconImageVIew.layer setMask: shapLayer];
    
    CGFloat seperateWidth = 5;
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(self.iconImageVIew.hd_x + 10, CGRectGetMaxY(self.iconImageVIew.frame) + seperateWidth, self.backView.hd_width - 20, 30)];
    self.titleLB.numberOfLines = 0;
    self.titleLB.font = kMainFont_12;
    self.titleLB.textColor = UIColorFromRGB(0000000);
    self.titleLB.attributedText = [self getAttributeStringWithBegainStr:@"" andContent:[NSString stringWithFormat:@"%@", [infoDic objectForKey:@"title"]]];
    [self.backView addSubview:self.titleLB];
    
    self.phoneLB = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLB.hd_x, CGRectGetMaxY(self.titleLB.frame) + seperateWidth, self.titleLB.hd_width, 20)];
    self.phoneLB.font = kMainFont_12;
    self.phoneLB.textColor = UIColorFromRGB(0000000);
    self.phoneLB.attributedText = [self getAttributeStringWithBegainStr:@"电话：" andContent:[NSString stringWithFormat:@"%@", [infoDic objectForKey:@"mobile"]]];
    [self.backView addSubview:self.phoneLB];
    
    self.wechatLB = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLB.hd_x, CGRectGetMaxY(self.phoneLB.frame) + seperateWidth, self.titleLB.hd_width, 20)];
    self.wechatLB.font = kMainFont_12;
    self.wechatLB.textColor = UIColorFromRGB(0000000);
    self.wechatLB.attributedText = [self getAttributeStringWithBegainStr:@"微信：" andContent:[NSString stringWithFormat:@"%@", [infoDic objectForKey:@"webchat"]]];
    [self.backView addSubview:self.wechatLB];
    
    self.addressLB = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLB.hd_x, CGRectGetMaxY(self.wechatLB.frame) + seperateWidth, self.titleLB.hd_width, 30)];
    self.addressLB.numberOfLines = 0;
    self.addressLB.font = kMainFont_12;
    self.addressLB.textColor = UIColorFromRGB(0000000);
    self.addressLB.attributedText = [self getAttributeStringWithBegainStr:@"店铺地址：" andContent:[NSString stringWithFormat:@"%@", [infoDic objectForKey:@"address"]]];
    [self.backView addSubview:self.addressLB];
    
    self.mapImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.titleLB.hd_x, CGRectGetMaxY(self.addressLB.frame) + seperateWidth, self.hd_width - 20, self.hd_width * 0.4)];
    [self.backView addSubview:self.mapImageView];
    self.mapImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.mapImageView.clipsToBounds = YES;
    
    
    self.applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.applyBtn.frame = CGRectMake(self.backView.hd_width / 2 - 30, CGRectGetMaxY(self.mapImageView.frame) + 10, 60, 25);
    [self.applyBtn setTitle:@"申请入会" forState:UIControlStateNormal];
    [self.applyBtn setTitleColor:kMainRedColor forState:UIControlStateNormal];
    self.applyBtn.backgroundColor = [UIColor whiteColor];
    self.applyBtn.layer.cornerRadius = 1.5;
    self.applyBtn.layer.masksToBounds = YES;
    self.applyBtn.layer.borderColor = kMainRedColor.CGColor;
    self.applyBtn.layer.borderWidth = 1;
    self.applyBtn.titleLabel.font = kMainFont_12;
    [self.backView addSubview:self.applyBtn];
    
    if ([[infoDic objectForKey:@"is_join"] intValue]) {
        [self.applyBtn setTitle:@"已申请" forState:UIControlStateNormal];
    }else
    {
        [self.applyBtn addTarget:self action:@selector(applyAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.backView.hd_height = CGRectGetMaxY(self.applyBtn.frame) + 10;
       self.backView.layer.shadowColor = UIColorFromRGB(0xeeeeee).CGColor;
       self.backView.layer.shadowOpacity = 1;
       self.backView.layer.shadowOffset = CGSizeMake(0, 0);
       self.backView.layer.shadowRadius = 3;
    
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];

    geo.address = [infoDic objectForKey:@"address"];
    
    [self.search AMapGeocodeSearch:geo];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}

#pragma mark - AMapSearchDelegate
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@ - %@", error, [ErrorInfoUtility errorDescriptionWithCode:error.code]);
}

- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    if (response.geocodes.count == 0)
    {
        return;
    }
    
    NSMutableArray *annotations = [NSMutableArray array];
    
    [response.geocodes enumerateObjectsUsingBlock:^(AMapGeocode *obj, NSUInteger idx, BOOL *stop) {
        GeocodeAnnotation *geocodeAnnotation = [[GeocodeAnnotation alloc] initWithGeocode:obj];
        
        [annotations addObject:geocodeAnnotation];
    }];
    
    if (annotations.count >= 1)
    {
//        [self.mapView setCenterCoordinate:[annotations[0] coordinate] animated:YES];
        
        
        [self getMapImage:[annotations[0] coordinate]];
    }
    else
    {
        
    }
    
//    [self.mapView addAnnotations:annotations];
}

- (void)getMapImage:(CLLocationCoordinate2D)coordinate
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
       
       NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
       [contentTypes addObject:@"text/html"];
       [contentTypes addObject:@"text/plain"];
       [contentTypes addObject:@"application/json"];
       [contentTypes addObject:@"text/json"];
       [contentTypes addObject:@"text/javascript"];
       [contentTypes addObject:@"text/xml"];
       [contentTypes addObject:@"image/*"];
       [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"If-None-Match"];
       
       manager.responseSerializer.acceptableContentTypes = contentTypes;
       
       
       //    manager.responseSerializer.acceptableContentTypes = self.acceptableContentTypes;
       
       manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 请求不使用AFN默认转换,保持原有数据
       manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // 响应不使用AFN默认转换,保持原有数据
       
       //  https://restapi.amap.com/v3/staticmap?markers=mid,0xFF0000,A:116.37359,39.92437;116.47359,39.92437&key=您的key
    NSString * URLString = [NSString stringWithFormat:@"https://restapi.amap.com/v3/staticmap?markers=mid,0xFF0000,:%f,%f&key=%@", coordinate.longitude, coordinate.latitude,kMapWebKey];
       
    [manager GET:URLString parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"^^^ %@ ^^^", responseObject);
        
        self.mapImageView.image = [UIImage imageWithData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"^^^ %@ ^^^", error);
    }];
}

- (NSMutableAttributedString *)getAttributeStringWithBegainStr:(NSString *)begainStr andContent:(NSString *)content
{
    NSString * str = [NSString stringWithFormat:@"%@%@", begainStr, content];
    NSDictionary * attribute = @{NSFontAttributeName:kMainFont_12,NSForegroundColorAttributeName:UIColorFromRGB(0x666666)};
    NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc]initWithString:str];
    [mStr addAttributes:attribute range:NSMakeRange(0, begainStr.length)];
    return mStr;
}

- (void)applyAction
{
    if (self.applyBlock) {
        self.applyBlock(self.infoDic);
    }
}

@end
