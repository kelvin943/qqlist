//
//  contactsRootVC.m
//  qqList
//
//  Created by MAX-TECH on 16/4/1.
//  Copyright © 2016年 zhangq. All rights reserved.
//

#import "contactsRootVC.h"
#import "contactsCell.h"
#import "tableHeadView.h"
#import "categoryModel.h"
#import "authorsModel.h"
#import "contractModel.h"
#import "MJRefresh.h"
#import "categoryModelTool.h"

#import "MessageVC.h"

#import "sectionHeadView.h"

@interface contactsRootVC ()<HeaderViewDelegate,UISearchBarDelegate>
{

}
@property (strong, nonatomic)  tableHeadView *headView;  //表头视图
@property (nonatomic, strong) NSArray *dataArray;        //表数据源

@end

@implementation contactsRootVC

#pragma mark - 懒加载初始化数据
- (tableHeadView *) headView{
    if (_headView == nil) {
        _headView = [tableHeadView makeItem];
        _headView .frame = CGRectMake(0, 0, kScreenWidth-40, 140);
    }
    return _headView;
}
- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [self  getLocalGroupList];
        if (!_dataArray) {
            _dataArray = [NSMutableArray array];
        }
    }
    return _dataArray;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联系人";
    self.tableView.estimatedRowHeight =45;
    self.tableView.tableHeaderView =self.headView;
    [self.headView.friendBtn addTarget:self action:@selector(friendBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.headView.especialBtn addTarget:self action:@selector(especialBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.headView.groupBtn addTarget:self action:@selector(groupBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.headView.serviceBtn addTarget:self action:@selector(serviceBtnPress) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.sectionHeaderHeight = 45;
    // 去掉tableview 下面的多余的线
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    
    //使用MJRefresh 添加下拉刷新
    __unsafe_unretained typeof(self) weakSelf = self;
    __unsafe_unretained UITableView *tableView = self.tableView;
    
    tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf loadViewData];
//            [tableView.mj_header endRefreshing];
//        });
        [weakSelf loadViewData];
        
    }];
    tableView.mj_header.automaticallyChangeAlpha = YES;
    //本地加载不到数据就从服务器上去加载
    if (!self.dataArray  ||self.dataArray.count ==0) {
        [self loadViewData];
    }
    
}
//从本地读取数据
- (NSArray *) getLocalGroupList
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentDirectory = paths[0];
    NSString* fullPath =  [documentDirectory stringByAppendingString:@"/contract"];
    contractModel * localContract= [contractModel loadFromFile:fullPath];

    NSLog(@"fullPath%@",fullPath);
    return localContract.groupList;
}
//服务器上加载数据
-(void) loadViewData
{
    [categoryModelTool getQQGroupListWithSuccessBlock:^(id obj) {
    //这里更新UI
        if (obj) {
            contractModel* model =(contractModel *)obj;
            self.dataArray = model.groupList;
            [self.tableView reloadData];
            NSLog(@"self.dataArray %@",self.dataArray);
        }
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - click event
-(void) friendBtnPress
{
    //使用storyBoard跳转
     [self performSegueWithIdentifier:@"showNextView" sender:nil];
}
-(void) especialBtnPress
{
     [self performSegueWithIdentifier:@"showNextView" sender:nil];
}
-(void) groupBtnPress
{
   [self performSegueWithIdentifier:@"showNextView" sender:nil];
}
-(void) serviceBtnPress
{
     [self performSegueWithIdentifier:@"showNextView" sender:nil];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.headView.qqSearchBar resignFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    categoryModel *categorInfo = self.dataArray[section];
    NSInteger count = categorInfo.isOpen ? categorInfo.authors.count : 0;
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    contactsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contactsCell" forIndexPath:indexPath];
    categoryModel *categorInfo = self.dataArray[indexPath.section];
    authorsModel * authirsInfo =categorInfo.authors[indexPath.row];
    [cell setContentDetail:authirsInfo];
    
    return cell;
}

#pragma mark - UITableView delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    categoryModel *categorInfo = self.dataArray[section];
    NSDictionary *cate =   categorInfo.category;
    NSString *onlineStr = [NSString stringWithFormat:@"%ld/%lu", (long)categorInfo.onLine, (unsigned long)categorInfo.authors.count];
    
    sectionHeadView *headView = [[sectionHeadView alloc] initWithFrame:
            CGRectMake(0, 0, self.tableView.bounds.size.width, 45)
            title:cate[@"categoryName"]
            section:section
            OnLineString:onlineStr
            opened:categorInfo.isOpen
            delegate:self] ;
    return headView;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageVC *messageVC = [[MessageVC alloc] init];
    [self.navigationController pushViewController:messageVC animated:YES];
}


#pragma mark - HeaderViewDelegate
-(void)sectionHeaderView:(sectionHeadView*)sectionHeaderView sectionClosed:(NSInteger)section
{
    categoryModel *categorInfo = self.dataArray[section];
    categorInfo.isOpen = !categorInfo.isOpen;
    // 收缩+动画 (如果不需要动画直接reloaddata)
    NSInteger countOfRowsToDelete = [self.tableView numberOfRowsInSection:section];
    if (countOfRowsToDelete > 0) {
        categorInfo.indexPaths = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [categorInfo.indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:section]];
        }
       [self.tableView deleteRowsAtIndexPaths:categorInfo.indexPaths withRowAnimation:UITableViewRowAnimationRight];
    }
}

-(void)sectionHeaderView:(sectionHeadView*)sectionHeaderView sectionOpened:(NSInteger)section
{
    categoryModel *categorInfo = self.dataArray[section];
    categorInfo.isOpen = !categorInfo.isOpen;
    // 展开+动画 (如果不需要动画直接reloaddata)
    if(categorInfo.indexPaths){
        [self.tableView insertRowsAtIndexPaths:categorInfo.indexPaths withRowAnimation:UITableViewRowAnimationRight];
    }
    categorInfo.indexPaths = nil;
}




#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  //这里做跳转传值
}


@end
