//
//  SYListVC.m
//  SYControlSet
//
//  Created by yujiao yang on 2019/3/4.
//  Copyright © 2019 Echo. All rights reserved.
//

#import "SYListVC.h"
#import "SYCellData.h"

#import "SYTradePwdVC.h"

@interface SYListVC ()
<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *dataSourceArray;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation SYListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self configDataSource];
    [self.view addSubview:self.tableView];
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.tableView setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
}
- (void)configDataSource{
    SYCellData *pwdInput = [[SYCellData alloc] initWithName:@"交易密码输入" action:^{
        SYTradePwdVC *vc = [[SYTradePwdVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    self.dataSourceArray = @[pwdInput];
}
#pragma mark - Getter
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SYCell"];
    }
    SYCellData *data = self.dataSourceArray[indexPath.row];
    cell.textLabel.text = data.cellName;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SYCellData *data = self.dataSourceArray[indexPath.row];
    data.cellAction();
}

@end
