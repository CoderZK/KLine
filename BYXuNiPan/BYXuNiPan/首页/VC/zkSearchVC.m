//
//  zkSearchVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/16.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkSearchVC.h"
#import "zkSearchView.h"
#import "zkTieZiSearchResultTVC.h"
#import "zkSearchJiLuCell.h"

@interface zkSearchVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,zkContrainTitlesVCDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)UIButton *clearBtn;
@property(nonatomic,strong)zkSearchView *seachV;
@property(nonatomic,assign)BOOL isSearch;
@property(nonatomic,assign)NSInteger type;
@end

@implementation zkSearchVC

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
    self.type = 1;
    [self setRightNavItem];
    self.dataArr = [NSMutableArray arrayWithArray:[zkSignleTool shareTool].serachTiezi];
    
    NSArray * titleArr = @[@"帖子",@"交易",@"用户"];
    NSMutableArray * vcsArr = @[].mutableCopy;
    for (int i = 0 ; i < titleArr.count ; i++) {
        zkTieZiSearchResultTVC * tvc = [[zkTieZiSearchResultTVC alloc] init];
        tvc.type = i;
        self.delegate = tvc;
        tvc.pageNumber = 1;
        [vcsArr addObject:tvc];
    }
     zkContrainTitlesFatherVC * vc =[[zkContrainTitlesFatherVC alloc] initFrame:self.view.bounds titleArr:titleArr vcsArr:vcsArr];
    vc.delegate = self;
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    
    [self setTableView];
    [self configFootView];
    
}

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
    

    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickSearchStr:withType:)]) {
        self.tableView.hidden = YES;
        [self.delegate didClickSearchStr:_dataArr[indexPath.row] withType:self.type];
        [self searchWithText:_dataArr[indexPath.row]];
        [self.seachV.textTF resignFirstResponder];
    }

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
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickSearchStr:withType:)]) {
            [self.delegate didClickSearchStr:textField.text withType:self.type];
            [self searchWithText:textField.text];
        }
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

- (void)didSelectTopTitleButton:(UIButton *)button index:(NSInteger)index isSame:(BOOL)isSame {
    
    self.type = index+1;
    
}

- (void)searchWithText:(NSString *)text{
    
    for (zkTieZiSearchResultTVC * tvc in [self.childViewControllers firstObject].childViewControllers) {
        tvc.searchStr = text;
    }
    
}


- (void)rightAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
