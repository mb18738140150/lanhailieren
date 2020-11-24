//
//  CommonMacro.h
//  Accountant
//
//  Created by aaa on 2017/3/1.
//  Copyright © 2017年 tianming. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h


#define isObjectNotNil(a) (a != nil)

#define kAppointUserID      @"53301"

/*
 channel
 
 club = "club" // 关于俱乐部
 
 activity = "activity" // 俱乐部活动
 
 game = "game" // 俱乐部比赛
 
 service = "service" // 俱乐部服务
 
 shop = "shop" // 门店管理
 
 goods = "goods" // 购物商城
 
 arder = "arder" // 休闲视频
 
 food = "food" // 美食制作
 
 report = "report" // 检测报告
 
 fish = "fish" // 鱼获
 
 dish = ”dish“ // 西沙美食
 
 sort
 
 排序 (0:默认 1：销量 2:最新 3：最热 4:离我最近)
 
 */

#define kCourseName         @"courseName"
#define kCourseURL          @"courseURLString"
#define kCourseCover        @"courseCover"
#define kCourseTeacherName  @"courseTeachrename"
#define kteacherId          @"tacherId"
#define kCourseID           @"courseID"
#define kCoursePath         @"coursePath"
#define kCourseChapterInfos @"courseChapterInfos"
#define kCourseIsCollect    @"courseIsCollect"
#define kCourseCanDownLoad  @"courseCanDownload"
#define kCanWatch           @"courseCanWatch"
#define kLearnProgress      @"courseLearnProgress"
#define kPrice              @"price"
#define kOldPrice           @"oldPrice"
#define kRealityPrice       @"realityPrice"
#define kIsDownload         @"isDownload"
#define kIsRecommend        @"isRecommend"

#define kLivingTime         @"livingTime"
#define kLivinglastTime     @"lastTime"
#define kLivingState        @"livingState"
#define kTeacherDetail      @"teacherDetail"
#define kLivingDetail       @"livingDetail"
#define kTeacherPortraitUrl @"teacherPortraitUrl"
#define kChatRoomID         @"chatRoomId"
#define kAssistantID        @"assistantId"
#define kPlayBackUrl        @"playBackUrl"
#define kHaveJurisdiction   @"haveJurisdiction"
#define kIsLivingCourseFree @"isLivingCOurseFree"
#define kIsBack             @"isBack"
#define kRtmpUrl            @"rtmpUrl"

#define kLivingCourseArr    @"livingCourseArr"
#define kSectionArray       @"sectionArray"

#define kCourseSecondName         @"courseSecondName"
#define kCourseSecondCover        @"courseSecondCover"
#define kCourseSecondID           @"courseSecondID"
#define kCourseCategorySecondCourseInfos      @"courseCategorySecondCourseInfos"

#define kIsFold                 @"isFold"

#define kChapterName        @"chapterName"
#define kChapterURL         @"chapterURLString"
#define kChapterId          @"chapterId"
#define kChapterPath        @"chapterPath"
#define kChapterSort        @"chapterSort"
#define kIsSingleChapter    @"isSingleChapter"
#define kChapterCourseId    @"chapterCourseId"
#define kChapterVideoInfos  @"chapterVideoInfos"

#define kVideoName          @"videoName"
#define kVideoURL           @"videoURL"
#define kVideoId            @"videoId"
#define kVideoSort          @"videoSort"
#define kVideoPath          @"videoPath"
#define kVideoPlayTime      @"videoPlayTime"
#define kVideoChapterId     @"videoChapterId"
#define kVideoIsChapterVideo    @"videoIsChapterVideo"
#define kCanDownload        @"videoCanDownload"

#define kQuestionContent                @"questionContent"
#define kQuestionQuizzerHeaderImageUrl  @"questionQuizzerHeaderImageUrl"
#define kQuestionQuizzerUserName        @"questionQuizzerName"
#define kQuestionQuizzerUserNickName    @"questionQuizzerNickName"
#define kQuestionQuizzerId              @"questionQuizzerId"
#define kQuestionId                     @"questionId"
#define kQuestionTitle                  @"questionTitle"
#define kQuestionClassId                @"questionClassId"
#define kQuestionTime                   @"questionTime"
#define kQuestionSeePeopleCount         @"questionSeePeopleCount"
#define kQuestionReplyCount             @"questionReplyCount"
#define kQuestionImgStr                 @"questionImagesStr"


#define kUserId                         @"userId"
#define kUserName                       @"userName"
#define kUserNickName                   @"userNickName"
#define kUserLevel                      @"userLevel"
#define kUserHeaderImageUrl             @"userHeaderImageUrl"
#define kUserTelephone                  @"userTelephone"
#define kUserLevel                      @"userLevel"
#define kUserLevelDetail                @"levelDetail"
#define kAmount                         @"amount"
#define kPoint                         @"point"
#define kExp                         @"exp"
#define kStatus                         @"status"
#define kGroup_id                         @"group_id"
#define kGroup_name                        @"Group_name"


#define kMemberLevel                    @"memberLevel"
#define kMemberLevelId                  @"memberID"
#define kMemberLevelDetailIconUrl       @"memberDeUrl"


#define kCourseCategoryName             @"courseCategoryName"
#define kCourseCategoryId               @"courseCategoryId"
#define kCourseCategoryCoverUrl         @"courseCategoryCoverUrl"
#define kCourseCategoryCourseInfos      @"courseCategoryCourseInfos"
#define kCourseIsStartFromLoaction      @"courseIsStartFromLocation"

#define kReplyContent                   @"replyContent"
#define kReplyTime                      @"replyTime"
#define kReplierHeaderImage             @"replierHeaderImageUrl"
#define kReplierUserName                @"replierUserName"
#define kAskedArray                     @"askedArray"

#define kTestCategoryName               @"testCategoryName"
#define kTestCategoryImageName          @"testCategoryImageName"
#define kTestCategoryId                 @"testCategoryId"
#define kTestSimulateTestId             @"testSimulateTestId"
#define kTestSimulateTestAnswers        @"testSimulateTestAnswers"
#define kTestChapterName                @"testChapterName"
#define kTestChapterId                  @"testChapterId"
#define kTestChapterQuestionCount       @"testChapterQuestionCount"
#define kTestChapterSectionArray        @"testChapterSectionArray"
#define kTestSectionQuestionCount        @"testSectionQuestionCount"
#define kTestSectionId                  @"testSectionId"
#define kTestSectionName                @"testSectionName"
#define kTestSectionQuestionArray       @"testSectionQuestionArray"
#define kTestSimulateName               @"testSimulateName"
#define kTestSimulateId                 @"testSimulateId"
#define kTestQuestionResult             @"testQuestionResult"
#define kTestSimulateQuestionCount      @"testSimulateQuestionCount"
#define kTestQuestionId                 @"testQuestionId"
#define kTestQuestionIndex              @"testQuestionIndex"
#define kTestQuestionIsAnswered         @"testQuestionIsAnswered"
#define kTestQuestionIsShowAnswer       @"testQuestionIsShowAnswer"
#define kTestQuestionAnswers            @"testQuestionAnswers"
#define kTestQuestionSelectedAnswers    @"testQuestionSelectAnswers"
#define kTestQuestionSelectedAnswersId  @"testQuestionSelectAnswersId"
#define kTestQuestionComplain           @"testQuestionComplain"
#define kTestQuestionContent            @"testQuestionContent"
#define kTestQuestionType               @"testQuestionType"
#define kTestQuestionTypeId             @"testQuestionTypeId"
#define kTestQuestionCorrectAnswersId   @"testQuestionCorrectAnswersId"
#define kTestQuestionIsCollected        @"testQuestionIsCollected"
#define kTestQuestionIsAnswerCorrect    @"testQuestionIsAnswerCorrect"
#define kTestQuestionNumber             @"testQuestionNumber"
#define kTestAnswerContent              @"testAnswerContent"
#define kTestAnserId                    @"testAnswerId"
#define kTestAddHistoryType             @"testHistoryType"
#define kTestAddDetailHistoryLogId      @"testAddQuestionLogId"
#define kQuestionCaseInfo               @"testSimulateQuestionCaseInfo"
#define kLastLogId                      @"lastLogId"

#define kTestIsEasyWrong                @"isEasyWrong"
#define kLogName                        @"logName"
#define kLID                            @"directionId"
#define kKID                            @"subjectId"
#define kTestMyanswer                   @"myAnswer"
#define kTestIsResponse                 @"isResponse"


#define kRightquistionArr               @"rightquestionarr"
#define kWrongquistionArr               @"wrongquestionarr"
#define kDataArray                      @"dataArray"
#define kSinglequistionArr              @"singlequestionarr"
#define kMultiplequistionArr            @"multiplequestionarr"
#define kJudgequistionArr               @"judgequestionarr"
#define kMaterailQuestionArray          @"materailQuestionArr"
#define kJiandaQuestionArray            @"jiandaQuestionArray"
#define kAnalisisQuestionArray          @"analisisQuestionArray"
#define kZongheQuestionArray            @"zongheQuestionArray"

#define kDownloadTaskId                 @"downloadTaskId"
#define kDownloadState                  @"downloadState"

#define kHistoryTime                    @"historyTime"
#define kHistoryInfos                   @"historyInfos"

#define kNoteVideoNoteId                @"videoNoteId"
#define kNoteVideoNoteContent           @"videoNoteContent"

#define kAppUpdateInfoUrl               @"appUpdateInfoUrl"
#define kAppUpdateInfoVersion           @"appUpdateInfoVersion"
#define kAppUpdateInfoContent           @"appUpdateInfoContent"
#define kAppUpdateInfoIsForce           @"appUpdateInfoIsForce"

#define kDBErrorType_Mywrong            @"myWrong"
#define kDBErrorType_Easywrong            @"easyWrong"
#define kDBErrorType_Collect            @"colection"

#define kOrderId                        @"orderID"
#define kOrderTime                      @"orderTime"
#define kOrderDetail                    @"orderDetail"
#define kRemark                         @"remark"
#define kDeadLineTime                   @"deadLineTime"
#define kOrderStatus                    @"orderStatus"

#define kRecommendPackageId             @"recommendPackageId"
#define kRecommendPackageCover          @"recommendPackageCover"

#define kPackageTypeId                  @"packageTypeId"
#define kPackageTypename                @"packageTypename"
#define kPackageId                      @"packageId"
#define kPackageName                    @"packageName"
#define kPackageCover                   @"packageCover"
#define kPackagePrice                   @"packagePrice"


#endif /* CommonMacro_h */

