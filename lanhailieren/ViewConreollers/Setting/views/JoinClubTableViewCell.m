//
//  JoinClubTableViewCell.m
//  lanhailieren
//
//  Created by aaa on 2020/4/20.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "JoinClubTableViewCell.h"
#import "GeocodeAnnotation.h"
#import "ErrorInfoUtility.h"

@interface JoinClubTableViewCell()<AMapSearchDelegate,MAMapViewDelegate,AMapSearchDelegate>

@property (nonatomic, strong)AMapSearchAPI * search;

@end

@implementation JoinClubTableViewCell


- (void)refreshUIWith:(NSDictionary *)infoDic
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    self.infoDic = infoDic;
    
    self.iconImageVIew = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 22, 22)];
    self.iconImageVIew.image = [UIImage imageNamed:@"icon_stores"];
    [self.contentView addSubview:self.iconImageVIew];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageVIew.frame) + 7, self.iconImageVIew.hd_y, self.hd_width - 50, 20)];
    self.titleLB.font = kMainFont_12;
    self.titleLB.textColor = UIColorFromRGB(0000000);
    self.titleLB.attributedText = [self getAttributeStringWithBegainStr:@"" andContent:[NSString stringWithFormat:@"%@", [infoDic objectForKey:@"title"]]];
    [self.contentView addSubview:self.titleLB];
    
    self.connectPersonNameLB = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLB.hd_x, CGRectGetMaxY(self.titleLB.frame) + 5, self.titleLB.hd_width, 20)];
    self.connectPersonNameLB.font = kMainFont_12;
    self.connectPersonNameLB.textColor = UIColorFromRGB(0000000);
    self.connectPersonNameLB.attributedText = [self getAttributeStringWithBegainStr:@"联系人：" andContent:[NSString stringWithFormat:@"%@", [infoDic objectForKey:@"name"]]];
//    [self.contentView addSubview:self.connectPersonNameLB];
    
    self.phoneLB = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLB.hd_x, CGRectGetMaxY(self.titleLB.frame) + 5, self.titleLB.hd_width, 20)];
    self.phoneLB.font = kMainFont_12;
    self.phoneLB.textColor = UIColorFromRGB(0000000);
    self.phoneLB.attributedText = [self getAttributeStringWithBegainStr:@"电话：" andContent:[NSString stringWithFormat:@"%@", [infoDic objectForKey:@"mobile"]]];
    [self.contentView addSubview:self.phoneLB];
    
    self.wechatLB = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLB.hd_x, CGRectGetMaxY(self.phoneLB.frame) + 5, self.titleLB.hd_width, 20)];
    self.wechatLB.font = kMainFont_12;
    self.wechatLB.textColor = UIColorFromRGB(0000000);
    self.wechatLB.attributedText = [self getAttributeStringWithBegainStr:@"微信：" andContent:[NSString stringWithFormat:@"%@", [infoDic objectForKey:@"webchat"]]];
    [self.contentView addSubview:self.wechatLB];
    
    self.addressLB = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLB.hd_x, CGRectGetMaxY(self.wechatLB.frame) + 2, self.titleLB.hd_width, 30)];
    self.addressLB.numberOfLines = 0;
    self.addressLB.font = kMainFont_12;
    self.addressLB.textColor = UIColorFromRGB(0000000);
    self.addressLB.attributedText = [self getAttributeStringWithBegainStr:@"店铺地址：" andContent:[NSString stringWithFormat:@"%@", [infoDic objectForKey:@"address"]]];
    [self.contentView addSubview:self.addressLB];
    
    self.mapView = [[MAMapView alloc]initWithFrame:CGRectMake(self.titleLB.hd_x, CGRectGetMaxY(self.addressLB.frame) + 7, self.titleLB.hd_width, self.titleLB.hd_width * 0.5)];
    [self.contentView addSubview:self.mapView];
    
    
    self.applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.applyBtn.frame = CGRectMake(self.hd_width / 2 - 40, CGRectGetMaxY(self.mapView.frame) + 15, 80, 25);
    [self.applyBtn setTitle:@"申请入会" forState:UIControlStateNormal];
    [self.applyBtn setTitleColor:kMainRedColor forState:UIControlStateNormal];
    self.applyBtn.backgroundColor = [UIColor whiteColor];
    self.applyBtn.layer.cornerRadius = 1.5;
    self.applyBtn.layer.masksToBounds = YES;
    self.applyBtn.layer.borderColor = kMainRedColor.CGColor;
    self.applyBtn.layer.borderWidth = 1;
    self.applyBtn.titleLabel.font = kMainFont_12;
    [self.contentView addSubview:self.applyBtn];
    
    if ([[infoDic objectForKey:@"is_join"] intValue]) {
        [self.applyBtn setTitle:@"已申请" forState:UIControlStateNormal];
    }else
    {
        [self.applyBtn addTarget:self action:@selector(applyAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    if (IS_PAD) {
        self.iconImageVIew.frame = CGRectMake(58, 5, 22, 22);
        self.titleLB.frame = CGRectMake(CGRectGetMaxX(self.iconImageVIew.frame) + 7, self.iconImageVIew.hd_y, self.hd_width - 146, 20);
        
        self.phoneLB.frame = CGRectMake(self.titleLB.hd_x, CGRectGetMaxY(self.titleLB.frame) + 5, self.titleLB.hd_width, 20);
        
        self.wechatLB.frame = CGRectMake(self.titleLB.hd_x, CGRectGetMaxY(self.phoneLB.frame) + 5, self.titleLB.hd_width, 20);
       
        self.addressLB.frame = CGRectMake(self.titleLB.hd_x, CGRectGetMaxY(self.wechatLB.frame) + 5, self.titleLB.hd_width, 20);
        
        self.mapView.frame = CGRectMake(self.titleLB.hd_x, CGRectGetMaxY(self.addressLB.frame) + 5, self.titleLB.hd_width, self.titleLB.hd_width * 0.5);
        
        self.applyBtn.frame = CGRectMake(self.hd_width / 2 - 40, CGRectGetMaxY(self.mapView.frame) + 15, 80, 25);
    }
    
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
        [self.mapView setCenterCoordinate:[annotations[0] coordinate] animated:YES];
    }
    else
    {
        
    }
    
    [self.mapView addAnnotations:annotations];
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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
