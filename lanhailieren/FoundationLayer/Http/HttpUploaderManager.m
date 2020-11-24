//
//  HttpUploaderManager.m
//  Accountant
//
//  Created by aaa on 2017/3/15.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "HttpUploaderManager.h"
#import "AFNetworking.h"
#import "NetMacro.h"
#import "DateUtility.h"
#import "CommonMacro.h"

@implementation HttpUploaderManager

+ (instancetype)sharedManager
{
    static HttpUploaderManager *__manager__;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __manager__ = [[HttpUploaderManager alloc] init];
    });
    return __manager__;
}

- (void)uploadImage:(NSData *)imageData withProcessDelegate:(id<HttpUploadProtocol>)processObject andType:(NSString *)type
{
    self.type = type;
    [self uploadImage:imageData withProcessDelegate:processObject];
}

- (void)uploadImage:(NSData *)imageData withProcessDelegate:(id)processObject
{
//    NSString *picName = [NSString stringWithFormat:@"%@.png",[DateUtility getDateIdString]];
//    NSString *uploadPath = [NSString stringWithFormat:@"%@/%@",kUploadRootUrl,picName];
//    
//    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:uploadPath parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [formData appendPartWithFormData:imageData name:@"image"];
//    } error:nil];
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    
//    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"%@",error);
//            [processObject didUploadFailed:@"上传失败"];
//        }else{
//            NSLog(@"%@",responseObject);
//            [processObject didUploadSuccess:responseObject];
//        }
//    }];
//    [uploadTask resume];
    
    
    
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
    
    
    NSString * URLString = kUploadRootUrl;
    

    
    [manager POST:URLString parameters:@{@"type":self.type} headers:@{} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            /**
             *  压缩图片然后再上传(1.0代表无损 0~~1.0区间)
             */
            NSData *data = imageData;
            
            
    //        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", picModle.picName];
            
            [formData appendPartWithFileData:data name:@"" fileName:@"" mimeType:@"image/jpeg"];
            
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"[responseObject class] = %@", [responseObject class]);
            NSError *err;
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&err];
            
            [processObject didUploadSuccess:dic];
            NSLog(@"%@", [dic description]);
            
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        [processObject didUploadFailed:@"图片上传失败"];
    }];
    
    
    
    
/*    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *uploadPath = [NSString stringWithFormat:@"%@/%@/%@.png",kUploadRootUrl,[DateUtility getCurrentFormatDateString],[DateUtility getDateIdString]];
    
    NSURL *URL = [NSURL URLWithString:uploadPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromData:imageData progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            if (isObjectNotNil(processObject)) {
                [processObject didUploadSuccess:responseObject];
            }
        }else{
            if (isObjectNotNil(processObject)) {
                NSLog(@"%@",error);
                [processObject didUploadFailed:kNetError];
            }
        }
    }];
    [uploadTask resume];*/
}


@end
