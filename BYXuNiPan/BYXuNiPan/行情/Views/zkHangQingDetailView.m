//
//  zkHangQingDetailView.m
//  BYXuNiPan
//
//  Created by zk on 2018/8/4.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkHangQingDetailView.h"
#import "Y_KLineGroupModel.h"
#import "zkHeadHeadView.h"
#import "WebSocketManager.h"
#import "Y_KLineModel.h"
static NSInteger aa = 0;
@interface zkHangQingDetailView()<Y_StockChartViewDataSource,WebSocketManagerDelegate>

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) Y_KLineGroupModel *groupModel;
@property (nonatomic, copy) NSMutableDictionary <NSString*, Y_KLineGroupModel*> *modelsDict;
@property(nonatomic,strong)zkHeadHeadView *headHeadV;
@property(nonatomic,strong)NSString *timeStr ;
@property(nonatomic,strong)NSString *kLineStr;
@property(nonatomic,strong)NSString *oneMinStr,*fiveMinStr,*oneHourStr,*onedayStr,*oneWeekStr,*oneMonthStr;
@property(nonatomic,assign)BOOL oneTimeClick,fiveTimeClick,hourTimeClick,dayClick,weekClick,monthClcik;
@property(nonatomic,strong)NSArray *titleArr;

@property(nonatomic,assign)NSInteger timeNumber; //当有其他操作是用
@property(nonatomic,strong)NSTimer *timer; //当有其他操作是用

@end


@implementation zkHangQingDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        self.timeNumber = 0;
        self.oneMinStr = @"1min";
        self.fiveMinStr = @"5min";
        self.oneHourStr = @"60min";
        self.onedayStr = @"1day";
        self.oneWeekStr = @"1week";
        self.oneMonthStr = @"1mon";
        self.titleArr = @[@"1min",@"5min",@"60min", @"1day",@"1week",@"1mon"];
 
        self.kLineStr = [NSString stringWithFormat:@"Kline:market.%@usdt.kline.%@#kline:%@:%@",self.biZhongStr,self.oneMinStr,self.biZhongStr,self.oneMinStr];
        self.timeStr = [NSString stringWithFormat:@"Depth:market.%@usdt.depth.step0",self.biZhongStr];
        self.backgroundColor = [UIColor redColor];
        [self addSubview:self.headHeadV];
        [self addSubview:self.stockChartView];
        self.currentIndex = 0;
//        [self getDater];
       
      
        
        [[WebSocketManager instance] WebSocketOpenWithURLString:stocketURL];
        [WebSocketManager instance].delegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SRWebSocketDidOpen) name:kWebSocketDidOpenNote object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"stop" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jiaoyi:) name:@"jiaoyi" object:nil];
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kaishi:) name:@"kaishi" object:nil];
    }
    return self;
}
- (NSMutableDictionary<NSString *,Y_KLineGroupModel *> *)modelsDict
{
    if (!_modelsDict) {
        _modelsDict = @{}.mutableCopy;
    }
    return _modelsDict;
}


- (Y_StockChartView *)stockChartView
{
    if(!_stockChartView) {
        _stockChartView = [Y_StockChartView new];
        _stockChartView.itemModels = @[
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"1分" type:Y_StockChartcenterViewTypeTimeLine],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"5分" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"60分" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"日线" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"周线" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"月线" type:Y_StockChartcenterViewTypeKline],
                                       
                                       ];
        _stockChartView.backgroundColor = [UIColor whiteColor];
        _stockChartView.dataSource = self;
        [self addSubview:_stockChartView];
        [_stockChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self);
            make.top.equalTo(self.mas_top).offset(80);
            
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        tap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:tap];
    }
    return _stockChartView;
}

-  (zkHeadHeadView *)headHeadV {
    if (_headHeadV == nil) {
        _headHeadV = [zkHeadHeadView new];
        [self addSubview:_headHeadV];
        [_headHeadV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.top.right.equalTo(self);
            make.height.equalTo(@80);
            
        }];
    }
  
    return _headHeadV;
}


//双击透视图
- (void)dismiss {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didDoubleClickView)]) {
        [self.delegate didDoubleClickView];
    }
    
}

-(id) stockDatasWithIndex:(NSInteger)index {
    NSString *type;
    type = self.titleArr[index];
    self.currentIndex = index;
    self.type = type;
    if(![self.modelsDict objectForKey:type])
    {
//        [self.stockChartView reloadData];
        [self getDateWithType:index];
//        [self getDater];
        
    } else {
        return [self.modelsDict objectForKey:type].models;
    }
    return nil;
}

- (void)getDater {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"type"] = self.type;
    param[@"market"] = @"btc_usdt";
    param[@"size"] = @"100";
   
    [zkRequestTool networkingPOST:@"http://api.bitkk.com/data/v1/kline" parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        Y_KLineGroupModel *groupModel = [Y_KLineGroupModel objectWithArray:responseObject[@"data"]];
        self.groupModel = groupModel;
        [self.modelsDict setObject:groupModel forKey:self.type];
//        NSLog(@"%@",groupModel);
        [self.stockChartView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

//切换横竖屏
- (void)updateLayoutWithLandscape:(BOOL)isLandscape {
    [self.stockChartView updateLayoutWithIsLace:isLandscape];
    if (isLandscape) {
        [self.stockChartView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
        }];
        self.headHeadV.hidden = YES;
    }else {
        [self.stockChartView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@80);
        }];
        self.headHeadV.hidden = NO;
    }
}



- (void)SRWebSocketDidOpen {
    NSLog(@"开启成功");
    //在成功后需要做的操作。。。
    NSDictionary * dd = @{@"type":@"1",@"clientId":deviceID,@"sentMsg":@"666666666"};
    NSString * str = [NSString convertToJsonDataWithDict:dd];
    [[WebSocketManager instance] sendData:str];
  
    
}

#pragma mark --- 获取不同类型的数据 -------
- (void)getDateWithType:(NSInteger)type {
    if (aa == 0) {
        NSDictionary * dd = @{@"type":@"1",@"clientId":deviceID,@"sentMsg":@"666666666"};
        NSString * str = [NSString convertToJsonDataWithDict:dd];
        [[WebSocketManager instance] sendData:str];
    }else {
        if (type == 0) {
            self.kLineStr = [NSString stringWithFormat:@"Kline:market.%@usdt.kline.%@#kline:%@:%@",self.biZhongStr,self.oneMinStr,self.biZhongStr,self.oneMinStr];
            if (self.oneTimeClick) {
                return;
            }
        }else if (type ==1) {
            self.kLineStr = [NSString stringWithFormat:@"Kline:market.%@usdt.kline.%@#kline:%@:%@",self.biZhongStr,self.fiveMinStr,self.biZhongStr,self.fiveMinStr];
            if (self.fiveTimeClick) {
                return;
            }
        }else if (type == 2) {
            self.kLineStr = [NSString stringWithFormat:@"Kline:market.%@usdt.kline.%@#kline:%@:%@",self.biZhongStr,self.oneHourStr,self.biZhongStr,self.oneHourStr];
            if (self.hourTimeClick) {
                return;
            }
        }else if (type == 3) {
            self.kLineStr = [NSString stringWithFormat:@"Kline:market.%@usdt.kline.%@#kline:%@:%@",self.biZhongStr,self.onedayStr,self.biZhongStr,self.onedayStr];
            if (self.dayClick) {
                return;
            }
        }else if (type == 4) {
            self.kLineStr = [NSString stringWithFormat:@"Kline:market.%@usdt.kline.%@#kline:%@:%@",self.biZhongStr,self.oneWeekStr,self.biZhongStr,self.oneWeekStr];
            if (self.weekClick) {
                return;
            }
        }else if (type == 5){
            self.kLineStr = [NSString stringWithFormat:@"Kline:market.%@usdt.kline.%@#kline:%@:%@",self.biZhongStr,self.oneMonthStr,self.biZhongStr,self.oneMonthStr];
            if (self.monthClcik) {
                return;
            }
        }
        NSDictionary * timeNow = @{@"type":@"2",@"clientId":deviceID,@"sentMsg":self.kLineStr};
        NSString * str2 = [NSString convertToJsonDataWithDict:timeNow];
        [[WebSocketManager instance] sendData:str2];
    }
}

#pragma mark --- 对收到数据第   1   步进行处理 ------
- (void)chuLiData:(NSString *)message {
    NSDictionary * dict = [NSString GetJsonWithData:message];
    if ([dict.allKeys containsObject:@"type"]) {
        NSInteger type = [[NSString stringWithFormat:@"%@",dict[@"type"]] integerValue];
        if (type == 1) {
            //实时价格
            NSArray * arr = [zkKLineModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
            if (arr.count>0) {
                self.shiShiModel = arr[0];
            }
            //价格颜色
//            self.stockChartView.nowPriceStr = self.shiShiModel.kline.price;
            
        }else if (type == 2){
            //实时交易价格
            NSArray * arr = dict[@"data"];
            self.stockChartView.shiDangArr = arr;
            
        }else if (type == 3){
           //k 线图
            [self getKModesWithDict:dict];
        }else if (type == 4) {
            //买卖五档
            NSArray * arr1 = @[];
            NSArray * arr2 = @[];
            if ([dict.allKeys containsObject:@"marketDepthResponse"] && [[dict[@"marketDepthResponse"] allKeys] containsObject:@"tick"] && [[dict[@"marketDepthResponse"][@"tick"] allKeys] containsObject:@"asks"]) {
                arr1 = dict[@"marketDepthResponse"][@"tick"][@"asks"];
            }
            if ([dict.allKeys containsObject:@"marketDepthResponse"] && [[dict[@"marketDepthResponse"] allKeys] containsObject:@"tick"] && [[dict[@"marketDepthResponse"][@"tick"] allKeys] containsObject:@"asks"]) {
                arr1 = dict[@"marketDepthResponse"][@"tick"][@"asks"];
            }
            if ([dict.allKeys containsObject:@"marketDepthResponse"] && [[dict[@"marketDepthResponse"] allKeys] containsObject:@"tick"] && [[dict[@"marketDepthResponse"][@"tick"] allKeys] containsObject:@"bids"]) {
                arr2 = dict[@"marketDepthResponse"][@"tick"][@"bids"];
            }
            NSMutableArray * dataArr = [NSMutableArray arrayWithArray:arr1];
            [dataArr addObjectsFromArray:arr2];
            self.stockChartView.shiDangArr = dataArr;
        }
    }else {
        return;
    }
}

#pragma mark --- 对收到数据第  2 步进行处理 ------
- (void)getKModesWithDict:(NSDictionary *)dict  {
    NSString * str = [NSString stringWithFormat:@"%@",dict[@"ch"]];
    if ([str containsString:self.oneMinStr]) {
        self.oneTimeClick = YES;
//        NSArray * arr = [zkKLineModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
//        Y_KLineGroupModel *groupModel = [self getarrWiethArr:arr];
//        self.groupModel = groupModel;
//        [self.modelsDict setObject:groupModel forKey:self.oneMinStr];
//        if (self.currentIndex == 0 && self.timeNumber <=0) {
//            [self.stockChartView reloadData];
//        }
        if (![self.modelsDict objectForKey:self.oneMinStr]) {
            //  内部没有数据
//            dispatch_queue_t que = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, DISPATCH_QUEUE_CONCURRENT);
            dispatch_queue_t queue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(queue, ^{
                // 异步追加任务
                NSArray * arr = [zkKLineModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
                Y_KLineGroupModel *groupModel = [self getarrWiethArr:arr];
                 [self.modelsDict setObject:groupModel forKey:self.oneMinStr];
                // 回到主线程
                dispatch_async(mainQueue, ^{
                    // 追加在主线程中执行的任务
                    if (self.currentIndex == 0 && self.timeNumber <=0) {
                        [self.stockChartView reloadData];
                    }
                     // 打印当前线程
                    NSLog(@"2---%@",[NSThread currentThread]);
                });
            });
            if (self.currentIndex == 0 && self.timeNumber <=0) {
                [self.stockChartView reloadData];
            }
        }else {
           //内部有数据
            dispatch_queue_t queue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(queue, ^{
                // 异步追加任务
                NSArray<zkKLineModel *> * arr = [zkKLineModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
                Y_KLineGroupModel *groupModel = [self getarrWiethArr:arr];
                NSArray<Y_KLineModel *> * lineArr = self.modelsDict[self.oneMinStr].models;
                if ([[arr firstObject].ts doubleValue]- [[lineArr lastObject].Date doubleValue] > 5000) {
                     [self.modelsDict setObject:groupModel forKey:self.oneMinStr];
                    // 回到主线程
                    dispatch_async(mainQueue, ^{
                        // 追加在主线程中执行的任务
                       
                        if (self.currentIndex == 0 && self.timeNumber <=0) {
                            [self.stockChartView reloadData];
                        }
                        // 打印当前线程
                        //     NSLog(@"2---%@",[NSThread currentThread]);
                    });
                    
                  
                }
                

            });
 
        }
    }else if ([str containsString:self.fiveMinStr]) {
        self.fiveTimeClick = YES;
        if (![self.modelsDict objectForKey:self.fiveMinStr]) {
            //  内部没有数据
            
            dispatch_queue_t queue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(queue, ^{
                // 异步追加任务
                NSArray<zkKLineModel *> * arr = [zkKLineModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
                Y_KLineGroupModel *groupModel = [self getarrWiethArr:arr];
                NSArray<Y_KLineModel *> * lineArr = self.modelsDict[self.oneMinStr].models;
                if ([[arr firstObject].ts doubleValue]- [[lineArr lastObject].Date doubleValue] > 10000) {
                    [self.modelsDict setObject:groupModel forKey:self.fiveMinStr];
                    // 回到主线程
                    dispatch_async(mainQueue, ^{
                        // 追加在主线程中执行的任务
                        if (self.currentIndex == 1 && self.timeNumber <=0) {
                            [self.stockChartView reloadData];
                        }
                        // 打印当前线程
                        //     NSLog(@"2---%@",[NSThread currentThread]);
                    });
                }
            });

        }else {
            //内部有数据
            dispatch_queue_t queue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(queue, ^{
                // 异步追加任务
                NSArray<zkKLineModel *> * arr = [zkKLineModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
                Y_KLineGroupModel *groupModel = [self getarrWiethArr:arr];
                NSArray<Y_KLineModel *> * lineArr = self.modelsDict[self.oneMinStr].models;
                // 回到主线程
                dispatch_async(mainQueue, ^{
                    // 追加在主线程中执行的任务
                    if ([[arr firstObject].ts doubleValue]- [[lineArr lastObject].Date doubleValue] > 60000) {
                        [self.modelsDict setObject:groupModel forKey:self.oneMinStr];
                        if (self.currentIndex == 0 && self.timeNumber <=0) {
                            [self.stockChartView reloadData];
                        }
                    }
                    // 打印当前线程
                    //  NSLog(@"2---%@",[NSThread currentThread]);
                });
            });
            
        }
        
    }else if ([str containsString:self.oneHourStr]) {
        self.hourTimeClick = YES;
        if (![self.modelsDict objectForKey:self.oneHourStr]) {
            //内部没有数据
            NSArray * arr = [zkKLineModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
            Y_KLineGroupModel *groupModel = [self getarrWiethArr:arr];
            self.groupModel = groupModel;
            [self.modelsDict setObject:groupModel forKey:self.oneHourStr];
//            NSLog(@"%@",groupModel);
            [self.stockChartView reloadData];
            if (self.currentIndex == 2) {
                [self.stockChartView reloadData];
            }
        }else {
            //内部有数据
            
        }
       
    }else if ([str containsString:self.onedayStr]) {
        self.dayClick = YES;
        if (![self.modelsDict objectForKey:self.onedayStr]) {
            //内部没有数据
            NSArray * arr = [zkKLineModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
            Y_KLineGroupModel *groupModel = [self getarrWiethArr:arr];
            self.groupModel = groupModel;
            [self.modelsDict setObject:groupModel forKey:self.onedayStr];
//            NSLog(@"%@",groupModel);
            [self.stockChartView reloadData];
            if (self.currentIndex == 3) {
                [self.stockChartView reloadData];
            }
        }else {
            //内部有数据
            
        }

    }else if ([str containsString:self.oneWeekStr]) {
        self.weekClick = YES;
        if (![self.modelsDict objectForKey:self.oneWeekStr]) {
            //内部没有数据
            NSArray * arr = [zkKLineModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
            Y_KLineGroupModel *groupModel = [self getarrWiethArr:arr];
            self.groupModel = groupModel;
            [self.modelsDict setObject:groupModel forKey:self.oneWeekStr];
//            NSLog(@"%@",groupModel);
            [self.stockChartView reloadData];
            if (self.currentIndex == 4) {
                [self.stockChartView reloadData];
            }
        }else {
            //内部有数据
            
        }
        
    }else if ([str containsString:self.oneMonthStr]) {
        self.monthClcik = YES;
        if (![self.modelsDict objectForKey:self.oneMonthStr]) {
            //内部没有数据
            NSArray * arr = [zkKLineModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
            Y_KLineGroupModel *groupModel = [self getarrWiethArr:arr];
            self.groupModel = groupModel;
            [self.modelsDict setObject:groupModel forKey:self.oneMonthStr];
//            NSLog(@"%@",groupModel);
            [self.stockChartView reloadData];
            if (self.currentIndex == 5) {
                [self.stockChartView reloadData];
            }
        }else {
            //内部有数据
            
        }
    }
    
    
}

#pragma  mark ---对收到数据第  3 步进行处理 把获取的数据转化成所需model数组 ----
- (Y_KLineGroupModel *)getarrWiethArr:(NSArray<zkKLineModel*>*)arr {
   
//     NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    
    NSMutableArray * arrMu = @[].mutableCopy;
    
    for (int i = 0 ; i < arr.count; i ++) {
        zkKLineModel * model = arr[i];
        
        NSMutableArray * aa = @[].mutableCopy;
        [aa addObject:model.ts];
        [aa addObject:model.kline.kline.open];
        [aa addObject:model.kline.kline.high];
        [aa addObject:model.kline.kline.low];
        [aa addObject:model.kline.kline.close];
        [aa addObject:model.kline.kline.amount];
        [aa addObject:model.kline.increase];
        [arrMu insertObject:aa atIndex:0];
        
    }
    
    Y_KLineGroupModel *groupModel = [Y_KLineGroupModel objectWithArray:arrMu];
    return groupModel;
}


#pragma  mark ---对收到数据第  3 步进行处理 把获取的数据转化成所需model数组 ----
- (Y_KLineGroupModel *)getGroupModelWithArr:(NSArray<zkKLineModel*>*)arr {
    Y_KLineGroupModel * groupModel = [Y_KLineGroupModel new];
    NSMutableArray *mutableArr = @[].mutableCopy;
    __block Y_KLineModel *preModel = [Y_KLineModel new];
    [arr enumerateObjectsUsingBlock:^(zkKLineModel * tempModel , NSUInteger idx, BOOL * _Nonnull stop) {
        Y_KLineModel * model = [Y_KLineModel new];
        model.PreviousKlineModel = preModel;
        model.Date = tempModel.kline.ts;
        model.Open = @([tempModel.kline.kline.open floatValue]);
        model.High = @([tempModel.kline.kline.high floatValue]);
        model.Low = @([tempModel.kline.kline.low floatValue]);
        model.Close = @([tempModel.kline.kline.close floatValue]);
        model.Volume = [tempModel.kline.kline.amount floatValue];
        model.SumOfLastClose = @([tempModel.kline.kline.close floatValue] + model.PreviousKlineModel.SumOfLastClose.floatValue);
        model.SumOfLastVolume = @([tempModel.kline.kline.amount floatValue] + model.PreviousKlineModel.SumOfLastVolume.floatValue);
        model.ParentGroupModel = groupModel;
        [mutableArr insertObject:model atIndex:0];
        preModel = model;

    }];
    
//    for (zkKLineModel * tempModel  in arr) {
//
//        Y_KLineModel * model = [[Y_KLineModel alloc] init];
//        model.PreviousKlineModel = preModel;
//        model.Date = tempModel.kline.ts;
//        model.Open = @([tempModel.kline.kline.open floatValue]);
//        model.High = @([tempModel.kline.kline.high floatValue]);
//        model.Low = @([tempModel.kline.kline.low floatValue]);
//        model.Close = @([tempModel.kline.kline.close floatValue]);
//        model.Volume = [tempModel.kline.kline.amount floatValue];
//        model.SumOfLastClose = @([tempModel.kline.kline.close floatValue] + model.PreviousKlineModel.SumOfLastClose.floatValue);
//        model.SumOfLastVolume = @([tempModel.kline.kline.vol floatValue] + model.PreviousKlineModel.SumOfLastVolume.floatValue);
//        model.ParentGroupModel = groupModel;
//        [mutableArr insertObject:model atIndex:0];
//        preModel = model;
//
//    }
    
    groupModel.models = mutableArr;
    //初始化第一个Model的数据
    if (mutableArr.count > 0) {
        Y_KLineModel *firstModel = mutableArr[0];
        [firstModel initFirstModel];
    }
    //初始化其他Model的数据
    [mutableArr enumerateObjectsUsingBlock:^(Y_KLineModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"\n初始化第几个====%d",idx);

        [model initData];
    }];
    return groupModel;
}


- (void)setShiShiModel:(zkKLineModel *)shiShiModel {
    _shiShiModel = shiShiModel;
    self.headHeadV.headModel = shiShiModel.kline;
    self.headHeadV.shiZhiLB.text = [NSString stringWithFormat:@"%0.2f亿",[self.shiZhiStr floatValue]];
    if (self.sendShiSHiModel != nil ) {
        self.sendShiSHiModel(shiShiModel.kline);
    }
}


- (void)didReceivemessage:(id)message {
    
    //    NSDictionary * dict = [NSString GetJsonWithData:message];
    //    NSLog(@"==%@\n",dict);
//    NSLog(@"\n---%@",message);

    if ([message isKindOfClass:[NSString class]]) {
        NSString * str = message;
        if ([str containsString:@"注册成功"]) {
            
              aa = 1;
            //实时交易数据
            NSDictionary * dd = @{@"type":@"2",@"clientId":deviceID,@"sentMsg":[NSString stringWithFormat:@"Depth:market.%@usdt.depth.step0",self.biZhongStr]};
            NSString * str = [NSString convertToJsonDataWithDict:dd];
            [[WebSocketManager instance] sendData:str];

            //注册成功就要发分钟的
            [self getDateWithType:0];
            [self getDateWithType:1];
            [self getDateWithType:2];
            [self getDateWithType:3];
            [self getDateWithType:4];

            //获取实时价格
            NSDictionary * timeNow = @{@"type":@"2",@"clientId":deviceID,@"sentMsg":[NSString stringWithFormat:@"Kline:market.%@usdt.kline.1day",self.biZhongStr]};
            NSString * str2 = [NSString convertToJsonDataWithDict:timeNow];
            [[WebSocketManager instance] sendData:str2];
           
        }else if ([str containsString:@"在线"]) {
            //需要重新注册
            aa = 0;
            self.oneTimeClick = self.fiveTimeClick = self.hourTimeClick = self.dayClick = self.weekClick = self.monthClcik = NO;
        }else {
//            NSDictionary * dict = [NSString GetJsonWithData:message];
//            NSLog(@"==%@\n",dict);
//            NSArray * arr = dict[@"data"];
//            self.stockChartView.shiDangArr = arr;
            
            [self chuLiData:message];
            
            
        }
    }
}

//收到K线图备操作时的操作
- (void)tongzhi:(NSNotification *)text{
    
    NSLog(@"%@",text.userInfo[@"textOne"]);
    NSLog(@"－－－－－接收到通知------");
//    [self.timer invalidate];
//    self.timer = nil;
//    self.timeNumber = 5;
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeAction) userInfo:nil  repeats:NO];
    self.timeNumber = 5;
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeAction) userInfo:nil  repeats:YES];
    }
  
}

- (void)jiaoyi:(NSNotification *)text{
    
    NSLog(@"%@",text.userInfo[@"textOne"]);
    NSLog(@"－－－－－接收到通知------");

    self.timeNumber = 15;
    
}

- (void)kaishi:(NSNotification *)text{
    
    NSLog(@"%@",text.userInfo[@"textOne"]);
    NSLog(@"－－－－－接收到通知------");
 
    self.timeNumber = 0;
    
}


- (void)timeAction {
    self.timeNumber--;
    if (self.timeNumber<=0) {
        [self.timer invalidate];
        self.timer = nil;
        [self.stockChartView reloadData];
    }
}




- (void)dealloc {
    aa = 0;
    [[WebSocketManager instance] WebSocketClose];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
