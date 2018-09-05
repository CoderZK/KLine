//
//  zkNewSearchVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/8/14.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkNewSearchVC.h"
#import "zkSearchView.h"
#import "zkTieZiSearchResultTVC.h"
#import "zkSearchJiLuCell.h"
@interface zkNewSearchVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)UIButton *clearBtn;
@property(nonatomic,strong)zkSearchView *seachV;
@property(nonatomic,assign)BOOL isSearch;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,strong)NSString *searchText;

/** 三个按钮的View buttonView */
@property(nonatomic , strong)UIView *buttonView;
/** 下面的红色指示剂 */
@property(nonatomic , strong)UIView *alertView;
/** 滚动视图 */
@property(nonatomic , strong)UIScrollView *scrollview;
/** 选中的button */
@property(nonatomic , strong)UIButton *selectBt;


@end

@implementation zkNewSearchVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationItem setHidesBackButton:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationItem setHidesBackButton:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置下面的三个按钮
    [self setupHeaderView];
    //添加字控制器
    [self addChildsVC];
    //添加滚动视图
    [self addScrollview];
    
    self.dataArr = [NSMutableArray arrayWithArray:[zkSignleTool shareTool].serachTiezi];
     [self setRightNavItem];
    [self setTableView];
    [self configFootView];
    //以上是搜索部分的内容
    

    
    
}


//设置三个按钮
- (void)setupHeaderView {
    NSArray *array = @[@"帖子",@"交易",@"用户"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 35)];
    
    self.buttonView = view;
    self.buttonView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:self.buttonView];
    
    self.alertView =[[UIView alloc] init];
    self.alertView.backgroundColor = BlueColor;
    self.alertView.height = 2;
    self.alertView.y = 35 - 3;
    
    for (int i = 0 ; i < array.count; i ++ ) {
        UIButton * button =[UIButton new];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:CharacterBlackColor30 forState:UIControlStateNormal];
        //不可以点击时时红色
        [button setTitleColor:BlueColor forState:UIControlStateSelected];
        button.tag =i;
        button.width = ScreenW / array.count;
        button.height = 35;
        button.x = i * ScreenW / array.count;
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.buttonView addSubview:button];
        [button addTarget:self action:@selector(clickbutton:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0 ) {
            [button layoutIfNeeded];
            [button.titleLabel sizeToFit];
            button.selected = YES;
            self.selectBt = button;
            self.alertView.width = button.titleLabel.width;
            self.alertView.centerX = button.centerX;
        }
    }
    [self.buttonView addSubview:self.alertView];
    
}

//点击上面分类按钮
- (void)clickbutton:(UIButton *)button {
    //设置当前的button 的选中状态
    self.selectBt.selected = NO;
    button.selected = NO;
    self.selectBt = button;
    [UIView animateWithDuration:0.2 animations:^{
        self.alertView.width = button.titleLabel.width;
        self.alertView.centerX = button.centerX;
        
    }];
    CGPoint Offset = self.scrollview.contentOffset;
    Offset.x = button.tag * self.scrollview.width;
    //设置偏移量,可以移动
    [self.scrollview setContentOffset:Offset animated:YES];
    
    zkTieZiSearchResultTVC * vc = self.childViewControllers[button.tag];
    switch (self.selectBt.tag) {
        case 0:{
            vc.type = 1;
            vc.searchStr = self.searchText;
            break;
        }
        case 1:{
            vc.type =2;
            vc.searchStr = self.searchText;
            break;
        }
        case 2:{
            vc.type =3;
            vc.searchStr = self.searchText;
            break;
        }
        default:
            break;
    }
    
    
    
    
}

//添加子控制器
- (void)addChildsVC {
    zkTieZiSearchResultTVC * daishenVC =[[zkTieZiSearchResultTVC alloc] init];
    daishenVC.type = 1;
    [self addChildViewController:daishenVC];
    
    
    zkTieZiSearchResultTVC * yishangVC =[[zkTieZiSearchResultTVC alloc] init];
    yishangVC.type = 2;
    [self addChildViewController:yishangVC];
    
    zkTieZiSearchResultTVC * yixiaVC =[[zkTieZiSearchResultTVC alloc] init];
    yixiaVC.type = 3;
    [self addChildViewController:yixiaVC];
    
    
    
    
}
//滚动停止时
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //调用动画结束时的方法.
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index =scrollView.contentOffset.x / scrollView.width;
    [self clickbutton:self.buttonView.subviews[index]];
}

//动画结束时的方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    BaseTableViewController * vc = self.childViewControllers[index];
    //要设置fram 不然系统会自动去掉状态栏高度
    vc.view.frame = CGRectMake(scrollView.contentOffset.x, 0, _scrollview.width, _scrollview.height);
    // vc.view.x = scrollView.contentOffset.x;
    // vc.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
    [scrollView addSubview:vc.view];
    
    
}


//添加滚动视图
- (void)addScrollview {
    //不需要调整inset
    //self.automaticallyAdjustsScrollViewInsets = NO;
    self.scrollview =[[UIScrollView alloc] init];
    self.scrollview.frame = CGRectMake(0, 35 , ScreenW, ScreenH  - 35 );
    
    self.scrollview.backgroundColor =[UIColor whiteColor];
    
    self.scrollview.contentSize = CGSizeMake(self.childViewControllers.count * ScreenW, 0);
    self.scrollview.delegate = self;
    self.scrollview.pagingEnabled = YES;
    [self.view insertSubview:_scrollview atIndex:1];
    self.scrollview.showsHorizontalScrollIndicator = NO;
    self.scrollview.scrollEnabled = YES;
    
    //调用动画结束时,使第一个界面有数据.
    [self scrollViewDidEndScrollingAnimation:_scrollview];
}







//一下部分是搜索要做的
- (void)setTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"zkSearchJiLuCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    
}

- (void)setRightNavItem {
    
    zkSearchView * searchV = [[zkSearchView alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 80, 26)];
    searchV.textTF.placeholder = @"搜索贴内容或者用户昵称";
    searchV.textTF.delegate = self;
    self.seachV = searchV;
    self.navigationItem.titleView = searchV;
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(ScreenW - 35 - 10, sstatusHeight + 5.5, 35, 35);
    right.titleLabel.font = kFont(14);
    [right setTitleColor:CharacterBlackColor30 forState:UIControlStateNormal];
    [right setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentRight)];
    [right setTitle:@"取消" forState:UIControlStateNormal];
    right.tag = 100;
    [right addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
}

- (void)configFootView{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 44)];
    _clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _clearBtn.frame = CGRectMake(0, 0, ScreenW, 44);
    [_clearBtn setTitle:@"清空历史记录" forState:UIControlStateNormal];
    [_clearBtn setTitleColor:CharacterLightGrayColor forState:UIControlStateNormal];
    _clearBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_clearBtn addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:_clearBtn];
    if (_dataArr.count < 1) {
        _clearBtn.hidden = YES;
    }else{
        _clearBtn.hidden = NO;
    }
    
    self.tableView.tableFooterView = footView;
}

- (void)clear{
    _clearBtn.hidden = YES;
    [_dataArr removeAllObjects];
    [zkSignleTool shareTool].serachTiezi = [NSMutableArray array];
    
    [self.tableView reloadData];
}

#pragma mark-tableview代理数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    zkSearchJiLuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLB.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row]];
    [cell.deBtn addTarget:self action:@selector(cellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.deBtn.tag = indexPath.row;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.tableView.hidden = YES;
    [self searchWithText:_dataArr[indexPath.row]];
    [self.seachV.textTF resignFirstResponder];
    self.searchText = _dataArr[indexPath.row];
    
    zkTieZiSearchResultTVC * vc = (zkTieZiSearchResultTVC *)self.childViewControllers[self.selectBt.tag];
    vc.searchStr = self.searchText;
    [vc searchWithStr:_dataArr[indexPath.row] type:self.selectBt.tag+1 BoolIsSearchOne:YES];
    
}

- (void)rightAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}


//删除一条记录
- (void)cellBtnClick:(UIButton *)sender{
    
    [_dataArr removeObjectAtIndex:sender.tag];
    if (_dataArr.count < 1) {
        _clearBtn.hidden = YES;
    }else{
        _clearBtn.hidden = NO;
    }
    
    [zkSignleTool shareTool].serachTiezi = [NSMutableArray arrayWithArray:_dataArr];
    
    [self.tableView reloadData];
}

#pragma mark -textfield代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length > 0) {
        _clearBtn.hidden = NO;
        BOOL isHave = NO;
        for (NSString *str in _dataArr) {
            if ([self.seachV.textTF.text isEqualToString:str]) {
                
                isHave = YES;
            }
        }
        if (!isHave) {
            [_dataArr insertObject:textField.text atIndex:0];
        }
        
        if (_dataArr.count > 20) {
            [_dataArr removeLastObject];
        }
        [zkSignleTool shareTool].serachTiezi = [NSMutableArray arrayWithArray:_dataArr];
        [self.tableView reloadData];
        self.tableView.hidden = YES;
        [self searchWithText:textField.text];
        [self.seachV.textTF resignFirstResponder];
        self.searchText = textField.text;
        zkTieZiSearchResultTVC * vc = (zkTieZiSearchResultTVC *)self.childViewControllers[self.selectBt.tag];
        [vc searchWithStr:textField.text type:self.selectBt.tag+1 BoolIsSearchOne:YES];
        return YES;
    }else {
        [SVProgressHUD showErrorWithStatus:@"请输入搜索内容"];
        return NO;
    }
}

//是否是输入框没有内容了
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if(string.length == 0) {
        
        if (textField.text.length - range.length == 0) {
            
            self.tableView.hidden = NO;
        }
        
    }
    return YES;
}

- (void)searchWithText:(NSString *)text{
    
    for (zkTieZiSearchResultTVC * tvc in self.childViewControllers) {
        tvc.searchStr = text;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
