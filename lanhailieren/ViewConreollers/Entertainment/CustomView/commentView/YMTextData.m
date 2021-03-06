//
//  YMTextData.m
//  WFCoretext
//
//  Created by 阿虎 on 14/10/29.
//  Copyright (c) 2014年 tigerwf. All rights reserved.
//

#import "YMTextData.h"
#import "ILRegularExpressionManager.h"
#import "NSString+NSString_ILExtension.h"
#import "WFReplyBody.h"
#import "WFTextView.h"

@implementation YMTextData{
    
    TypeView typeview;
    int tempInt;
}



- (id)init
{
    self = [super init];
    if (self) {
        
        self.completionReplySource = [[NSMutableArray alloc] init];
        self.attributedDataReply = [[NSMutableArray alloc] init];
        self.attributedDataShuoshuo = [[NSMutableArray alloc] init];
        self.attributedDataFavour = [[NSMutableArray alloc] init];
        
        _foldOrNot = YES;
        _islessLimit = NO;
        
           }
    return self;
}

- (void)setMessageBody:(WFMessageBody *)messageBody{

    _messageBody = messageBody;
    _showImageArray = messageBody.posterPostImage;
    _thumbnailShowImageArray = messageBody.thumbnailPosterImage;
    _foldOrNot = YES;
    _showShuoShuo = messageBody.posterContent;
    _defineAttrData = [self findAttrWith:messageBody.posterReplies];
    _replyDataSource = messageBody.posterReplies;
    _favourArray = messageBody.posterFavour;
    _hasFavour = messageBody.isFavour;
}


- (NSMutableArray *)findAttrWith:(NSMutableArray *)replies{
    
    NSMutableArray *feedBackArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < replies.count; i++) {
        WFReplyBody *replyBody = (WFReplyBody *)[replies objectAtIndex:i];
        NSMutableArray *tempArr = [[NSMutableArray alloc] init];
        if ([replyBody.repliedUser isEqualToString:@""]) {
            
            NSString *range = NSStringFromRange(NSMakeRange(0, replyBody.replyUser.length));
            [tempArr addObject:range];
            
        }else{
            NSString *range1 = NSStringFromRange(NSMakeRange(0, replyBody.replyUser.length));
            NSString *range2 = NSStringFromRange(NSMakeRange(replyBody.replyUser.length + 2, replyBody.repliedUser.length));
            [tempArr addObject:range1];
            [tempArr addObject:range2];
        }
        [feedBackArray addObject:tempArr];
    }
    return feedBackArray;
    
}

- (float)calculateFavourHeightWithWidth:(float)sizeWidth{
    
    typeview = TypeFavour;
    float height = .0f;
  
    NSString *matchString = [_favourArray componentsJoinedByString:@","];
    _showFavour = matchString;
    NSArray *itemIndexs = [ILRegularExpressionManager itemIndexesWithPattern:EmotionItemPattern inString:matchString];
    
    NSString *newString = [matchString replaceCharactersAtIndexes:itemIndexs
                                                       withString:PlaceHolder];
    //存新的
    self.completionFavour = newString;
    
    [self matchString:newString fromView:typeview];
    
    WFTextView *_wfcoreText = [[WFTextView alloc] initWithFrame:CGRectMake(offSet_X + 30,10, sizeWidth - offSet_X_right - offSet_X - 30, 0)];
    
    _wfcoreText.isFold = NO;
    _wfcoreText.isDraw = NO;
    
    [_wfcoreText setOldString:_showFavour andNewString:newString];
   
    return [_wfcoreText getTextHeight];
    
    return height;
}

//计算replyview高度
- (float) calculateReplyHeightWithWidth:(float)sizeWidth{
    
    typeview = TypeReply;
    float height = .0f;
    
    for (int i = 0; i < self.replyDataSource.count; i ++ ) {
        
        tempInt = i;
        
        WFReplyBody *body = (WFReplyBody *)[self.replyDataSource objectAtIndex:i];
        
        NSString *matchString;
        
        if ([body.repliedUser isEqualToString:@""]) {
            matchString = [NSString stringWithFormat:@"%@:%@",body.replyUser,body.replyInfo];
            
        }else{
            matchString = [NSString stringWithFormat:@"%@回复%@:%@",body.replyUser,body.repliedUser,body.replyInfo];
          
        }
        NSArray *itemIndexs = [ILRegularExpressionManager itemIndexesWithPattern:EmotionItemPattern inString:matchString];
        
        NSString *newString = [matchString replaceCharactersAtIndexes:itemIndexs
                                                           withString:PlaceHolder];
        //存新的
        [self.completionReplySource addObject:newString];
        
        [self matchString:newString fromView:typeview];
        
        WFTextView *_ilcoreText = [[WFTextView alloc] initWithFrame:CGRectMake(0,0, sizeWidth, 0)];
        
        _ilcoreText.isFold = NO;
        _ilcoreText.isDraw = NO;
        
        [_ilcoreText setOldString:matchString andNewString:newString];
        
        height =  height + [_ilcoreText getTextHeight] + 5;
        
    }
    
    [self calculateShowImageHeight];
    
    return height;
    
}

//计算replyview高度
- (float) DetailcalculateReplyHeightWithWidth:(float)sizeWidth{
    
    typeview = TypeReply;
    float height = .0f;
    
    for (int i = 0; i < self.replyDataSource.count; i ++ ) {
        
        tempInt = i;
        
        WFReplyBody *body = (WFReplyBody *)[self.replyDataSource objectAtIndex:i];
        
        NSString *matchString;
        
        if ([body.repliedUser isEqualToString:@""]) {
            matchString = [NSString stringWithFormat:@"%@:%@",body.replyUser,body.replyInfo];
            
        }else{
            matchString = [NSString stringWithFormat:@"%@回复%@:%@",body.replyUser,body.repliedUser,body.replyInfo];
            
        }
        NSArray *itemIndexs = [ILRegularExpressionManager itemIndexesWithPattern:EmotionItemPattern inString:matchString];
        
        NSString *newString = [matchString replaceCharactersAtIndexes:itemIndexs
                                                           withString:PlaceHolder];
        //存新的
        [self.completionReplySource addObject:newString];
        
        [self matchString:newString fromView:typeview];
        
        WFTextView *_ilcoreText = [[WFTextView alloc] initWithFrame:CGRectMake(0,0, sizeWidth, 0)];
        
        _ilcoreText.isFold = NO;
        _ilcoreText.isDraw = NO;
        
        [_ilcoreText setOldString:matchString andNewString:newString];
        
        height =  height + [_ilcoreText getTextHeight] + 5;
        
    }
    
    [self calculateShowImageHeight];
    
    return height;
    
}


//图片高度
- (void)calculateShowImageHeight{
    
    if (self.showImageArray.count == 0) {
        self.showImageArray = 0;
        self.showImageWidth = 0;
    }else{
        if (self.showImageArray.count > 1) {
            self.showImageHeight = (ShowImage_H + 5) * ((self.showImageArray.count - 1)/3 + 1);
            self.showImageWidth = ShowImage_H;
        }else
        {
            [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:self.showImageArray.firstObject] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                ;
            } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"imagedownLoadComplete" object:nil];
                if (image) {
                    self.showImageHeight = [self getImageSizeWithImage:image];
                }else
                {
                    self.showImageHeight = (ShowImage_H + 5) * ((self.showImageArray.count - 1)/3 + 1);
                    self.showImageWidth = ShowImage_H;
                }
            }];
            
//            [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:self.showImageArray.firstObject] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//                ;
//            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"imagedownLoadComplete" object:nil];
//                if (image) {
//                    self.showImageHeight = [self getImageSizeWithImage:image];
//                }else
//                {
//                    self.showImageHeight = (ShowImage_H + 5) * ((self.showImageArray.count - 1)/3 + 1);
//                    self.showImageWidth = ShowImage_H;
//                }
//            }];
        }
    }
    
}

- (void)matchString:(NSString *)dataSourceString fromView:(TypeView) isReplyV{
    
    if (isReplyV == TypeReply) {
        
        NSMutableArray *totalArr = [NSMutableArray arrayWithCapacity:0];
        
        //**********号码******
        
        NSMutableArray *mobileLink = [ILRegularExpressionManager matchMobileLink:dataSourceString];
        for (int i = 0; i < mobileLink.count; i ++) {
            
            [totalArr addObject:[mobileLink objectAtIndex:i]];
        }
        
        //*************************
        
        
        //***********匹配网址*********
        
        NSMutableArray *webLink = [ILRegularExpressionManager matchWebLink:dataSourceString];
        for (int i = 0; i < webLink.count; i ++) {
            
            [totalArr addObject:[webLink objectAtIndex:i]];
        }
        
        //******自行添加**********
        
        if (_defineAttrData.count != 0) {
            NSArray *tArr = [_defineAttrData objectAtIndex:tempInt];
            for (int i = 0; i < [tArr count]; i ++) {
                NSString *string = [dataSourceString substringWithRange:NSRangeFromString([tArr objectAtIndex:i])];
                [totalArr addObject:[NSDictionary dictionaryWithObject:string forKey:NSStringFromRange(NSRangeFromString([tArr objectAtIndex:i]))]];
            }
            
        }
       
        
        //***********************
        [self.attributedDataReply addObject:totalArr];
        
        
    }
    
    if(isReplyV == TypeShuoshuo){
        
         [self.attributedDataShuoshuo removeAllObjects];
        //**********号码******
        
        NSMutableArray *mobileLink = [ILRegularExpressionManager matchMobileLink:dataSourceString];
        for (int i = 0; i < mobileLink.count; i ++) {
            
            [self.attributedDataShuoshuo addObject:[mobileLink objectAtIndex:i]];
        }
        
        //*************************
        
        
        //***********匹配网址*********
        
        NSMutableArray *webLink = [ILRegularExpressionManager matchWebLink:dataSourceString];
        for (int i = 0; i < webLink.count; i ++) {
            
            [self.attributedDataShuoshuo addObject:[webLink objectAtIndex:i]];
        }
       
    }
    
    if (isReplyV == TypeFavour) {
        
        [self.attributedDataFavour removeAllObjects];
        int originX = 0;
        for (int i = 0; i < _favourArray.count; i ++) {
            NSString *text = [_favourArray objectAtIndex:i];
            NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:text,NSStringFromRange(NSMakeRange(originX, text.length)), nil];
            [self.attributedDataFavour addObject:dic];
            originX += (1 + text.length);
        }
    }
}

//说说高度
- (float) calculateShuoshuoHeightWithWidth:(float)sizeWidth withUnFoldState:(BOOL)isUnfold{
    
    typeview = TypeShuoshuo;
    
    NSString *matchString =  _showShuoShuo;
    
    NSArray *itemIndexs = [ILRegularExpressionManager itemIndexesWithPattern:EmotionItemPattern inString:matchString];
    
    //用PlaceHolder 替换掉[em:02:]这些
    NSString *newString = [matchString replaceCharactersAtIndexes:itemIndexs
                                                       withString:PlaceHolder];
    //存新的
    self.completionShuoshuo = newString;
    
    [self matchString:newString fromView:typeview];
    
    WFTextView *_wfcoreText = [[WFTextView alloc] initWithFrame:CGRectMake(20,10, sizeWidth - 2*20, 0)];
    
    _wfcoreText.isDraw = NO;
    
    [_wfcoreText setOldString:_showShuoShuo andNewString:newString];
    
    if ([_wfcoreText getTextLines] <= limitline) {
        self.islessLimit = YES;
    }else{
        self.islessLimit = NO;
    }
    
    if (!isUnfold) {
        _wfcoreText.isFold = YES;
        
    }else{
        _wfcoreText.isFold = NO;
    }
    return [_wfcoreText getTextHeight];
    
}

- (CGFloat)getImageSizeWithImage:(UIImage *)image1
{
    UIImage * image = image1;
    CGSize imageSize = image.size;
    
    CGFloat maxWidth = screenWidth - 97;
    
    if (imageSize.width > maxWidth) {
        imageSize.height *= maxWidth / imageSize.width;
        imageSize.width = maxWidth;
    }
    if (imageSize.height > ShowImage_H * 2 + 5) {
        imageSize.width *= (ShowImage_H * 2 + 5) / imageSize.height;
        imageSize.height = ShowImage_H * 2 + 5;
    }
    
    self.showImageWidth = imageSize.width;
    return imageSize.height;
}

- (void)loadRequestData:(NSArray *)array
{
    for (int i= 0; i < array.count; i++) {
        NSDictionary * friendCircleDic = [array objectAtIndex:i];
        
        NSDictionary *publishUserDic = [friendCircleDic objectForKey:@"User"];
        
        
        // 点赞数据
        BOOL isFavor = NO;
        NSMutableArray *posterFavourArr = [NSMutableArray array];
        NSMutableArray *posterFavourUserArr = [NSMutableArray array];
        NSArray * FavoriteLists = [friendCircleDic objectForKey:@"FavoriteLists"];
        for (int j = 0; j < FavoriteLists.count; j++) {
            
            NSDictionary * favoriteDic = [FavoriteLists objectAtIndex:j];
            
            NSNumber * FavoriteId = [favoriteDic objectForKey:@"FavoriteId"];
            NSDictionary * favoriteUserDic = [favoriteDic objectForKey:@"User"];
            
            
            if (isFavor) {
                continue;
            }
            
        }
        
        // 评论数据源
        NSArray * CommentLists = [friendCircleDic objectForKey:@"CommentLists"];
        NSMutableArray * posterReplies = [NSMutableArray array];
        for (int j = 0; j < CommentLists.count; j++) {
            NSDictionary * replyDic = [CommentLists objectAtIndex:j];
            WFReplyBody * body = [[WFReplyBody alloc]init];
            body.commentId = [replyDic objectForKey:@"CommentId"];
            body.replyInfo = [replyDic objectForKey:@"Content"];
            
            NSDictionary * userDic = [replyDic objectForKey:@"User"];
            
            body.replyUser = [userDic objectForKey:@"name"];
            
            
            NSDictionary * ToReplyUserDic = [replyDic objectForKey:@"ToReplyUser"];
            if (![ToReplyUserDic isEqual:[NSNull null]]) {
                
                body.repliedUser = [ToReplyUserDic objectForKey:@"name"];
                
                
            }else{
                body.repliedUser = @"";
                
            }
            [posterReplies addObject:body];
        }
        
        WFMessageBody * messageBody = [[WFMessageBody alloc]init];
        messageBody.posterContent = [friendCircleDic objectForKey:@"TakeContent"];
        messageBody.posterId = [friendCircleDic objectForKey:@"TakeId"];
        messageBody.publishTime = [friendCircleDic objectForKey:@"CreateTime"];
        messageBody.memberState = friendCircleDic[@"MemberState"];
        messageBody.videoId = friendCircleDic[@"VideoId"];
        messageBody.videoTitle = friendCircleDic[@"VideoTitle"];
        messageBody.videoPicUrl = friendCircleDic[@"VideoPicUrl"];
        messageBody.detailId = friendCircleDic[@"DetailId"];
        
        messageBody.favoriteLists = FavoriteLists;
        messageBody.commentLists = CommentLists;
        
        NSString * photoLists = [friendCircleDic objectForKey:@"PhotoLists"];
        if (![photoLists isEqual:[NSNull null]]) {
            if ([photoLists containsString:@","]) {
                NSArray * imageArr = [[friendCircleDic objectForKey:@"PhotoLists"] componentsSeparatedByString:@","];
                NSMutableArray * thumbnailImageArr = [NSMutableArray array];
                if (imageArr.count > 1) {
                    messageBody.posterPostImage = imageArr;
                    for (NSString * imageUrl in imageArr) {
                        NSString * newImageAtr = [imageUrl stringByAppendingString:@".w150.png"];
                        
                        [thumbnailImageArr addObject:newImageAtr];
                    }
                    
                }else
                {
                    messageBody.posterPostImage = @[imageArr.firstObject];
                    for (NSString * imageUrl in imageArr) {
                        NSString * newImageAtr = [imageUrl stringByAppendingString:@".w375.png"];
                        [thumbnailImageArr addObject:newImageAtr];
                    }
                }
                
                messageBody.thumbnailPosterImage = [thumbnailImageArr copy];
                //                messageBody.posterPostImage = [[friendCircleDic objectForKey:@"PhotoLists"] componentsSeparatedByString:@","];
            }else
            {
                //268.994 218.333
                messageBody.posterPostImage = @[[friendCircleDic objectForKey:@"PhotoLists"]];
                messageBody.thumbnailPosterImage = @[[NSString stringWithFormat:@"%@%@", [friendCircleDic objectForKey:@"PhotoLists"],@".w375.png" ]];
            }
        }
        messageBody.posterReplies = posterReplies;
//        messageBody.posterImgstr = publishUser.portraitUri;
//        messageBody.posterName = publishUser.name;
//        messageBody.posterUserId = publishUser.userId;
        messageBody.posterFavour = posterFavourArr;
        messageBody.posterFavourUserArr = posterFavourUserArr;
        messageBody.isFavour = isFavor;
        messageBody.user = publishUserDic;
//        [_contentDataSource addObject:messageBody];
    }
//    [self loadTextData];
}

@end
