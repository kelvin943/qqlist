//
//  newsRootVC.m
//  qqList
//
//  Created by MAX-TECH on 16/4/1.
//  Copyright © 2016年 zhangq. All rights reserved.
//

#import "newsRootVC.h"
#import "contractCell.h"
#import "categoryModel.h"
#import "authorsModel.h"
#import "contractModel.h"
#import "MJRefresh.h"
#import "MessageVC.h"
#import "newsObserverModel.h"

@interface newsRootVC ()<UISearchBarDelegate>
{
    UISearchBar *mySearchBar;
}
@property (strong, nonatomic) IBOutlet UISegmentedControl *FuncselectSegm;
@property (nonatomic, strong) NSArray *dataArray;        //表数据源

@property (nonatomic, strong) NSMutableArray *phoneArray;     //电话表数据源
@property (nonatomic, strong) newsObserverModel * observerModel;  //新消息数据源

@property (assign, nonatomic) NSInteger currentPageNum;
@end

@implementation newsRootVC
#pragma mark - 懒加载初始化数据
- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [self  getLocalGroupList];
        if (!_dataArray) {
            _dataArray = [NSMutableArray array];
        }
    }
    return _dataArray;
}
- (NSMutableArray *)phoneArray{
    if (!_phoneArray) {
        //随机初始化生成4条数据
         _phoneArray = [NSMutableArray  array];
        if (self.dataArray.count >0)
        {
            for (int i=0; i<4; i++)
            {
                NSInteger groupCount = self.dataArray.count ;
                categoryModel *categorInfo = self.dataArray[arc4random()%groupCount];
                NSInteger friendCount = categorInfo.authors.count ;
                authorsModel * authirsInfo =categorInfo.authors[arc4random()%friendCount];
                [_phoneArray addObject:authirsInfo];
            }

        }
        
    }
    return _phoneArray;
}

- (newsObserverModel *)observerModel{
    if (!_observerModel) {
        //随机初始化生成一些数据
        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString* documentDirectory = paths[0];
        NSString* fullPath =  [documentDirectory stringByAppendingString:@"/newsList"];
        _observerModel= [newsObserverModel loadFromFile:fullPath];
        NSLog(@"fullPath%@",fullPath);
        if(_observerModel ==nil)
        {
          _observerModel =[newsObserverModel new];
          _observerModel.name =@"observerModel";
          _observerModel.newsArray = [NSMutableArray array];
        }
     
    }
    return _observerModel;
}

//从本地读取联系人列表的缓存数据
- (NSArray *) getLocalGroupList
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentDirectory = paths[0];
    NSString* fullPath =  [documentDirectory stringByAppendingString:@"/contract"];
    contractModel * localContract= [contractModel loadFromFile:fullPath];
    
    NSLog(@"fullPath%@",fullPath);
    return localContract.groupList;
}

#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    
    UIView * searBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    searBackView.backgroundColor= [UIColor whiteColor];
    mySearchBar = [[UISearchBar alloc] init];
    mySearchBar= [[UISearchBar alloc] initWithFrame:CGRectMake(8, 8, kScreenWidth-16, 30)];
    mySearchBar.searchBarStyle = UISearchBarStyleMinimal;
    mySearchBar.placeholder = @"搜索";
    [searBackView addSubview:mySearchBar];
    self.tableView.tableHeaderView =searBackView;
    self.tableView.estimatedRowHeight =45;
    // 去掉tableview 下面的多余的线
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    //使用MJRefresh 添加下拉刷新
    __unsafe_unretained typeof(self) weakSelf = self;
    __unsafe_unretained UITableView *tableView = self.tableView;
    
    tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //默认显示第一页 10条数据;
        weakSelf.currentPageNum =1;
        [weakSelf refreshElement];
        [tableView.mj_header endRefreshing];
    }];
    tableView.mj_header.automaticallyChangeAlpha = YES;
    
    //上拉加载
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 设置了底部inset
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    // 忽略掉底部inset
    self.tableView.mj_footer.ignoredScrollViewContentInsetBottom = 30;
    //进来刷新数据
    [tableView.mj_header beginRefreshing];
    [self updateTabarBadgeValue];
    //

    
    //添加监听 有新消息
    [self.observerModel  addObserver:self forKeyPath:@"newsArray" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    
    
    //10秒钟执行一次插入新消息数据
    __block int timeout=3; //插入3次
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),10.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.dataArray.count >0) {
                    NSInteger groupCount = self.dataArray.count ;
                    categoryModel *categorInfo = self.dataArray[arc4random()%groupCount];
                    NSInteger friendCount = categorInfo.authors.count ;
                    authorsModel * authirsInfo =categorInfo.authors[arc4random()%friendCount];
                    //authirsInfo发来一条新消息
                    authirsInfo.newsCount =1;
                    [[_observerModel mutableArrayValueForKey:@"newsArray"] insertObject: authirsInfo atIndex:0 ];
                    
                }
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
    

}

//仿写刷新加载数据
//下拉刷新数组前10个元素
-(void)refreshElement
{
   //这里做数据源更新
    if (self.FuncselectSegm.selectedSegmentIndex ==0) {
            [self.tableView reloadData];
    }

    
}
//上啦拉加载10个元素
-(void) loadMoreData;
{
    if (self.FuncselectSegm.selectedSegmentIndex ==0)
    {
        self.currentPageNum +=1;
        //这里数据源添加
        [self.tableView reloadData];

        if (self.observerModel.newsArray.count < self.currentPageNum*10) {
             [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.tableView.mj_footer endRefreshing];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [mySearchBar resignFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.FuncselectSegm.selectedSegmentIndex ==0) {
        
        //根据下拉次数显示多少条数据
        if (self.observerModel.newsArray.count < self.currentPageNum*10) {
            return self.observerModel.newsArray.count;
        }
        else{
            return self.currentPageNum * 10;
        }
      
    }
    else
    {
      return self.phoneArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.FuncselectSegm.selectedSegmentIndex ==0) {
        contractCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contractCell" forIndexPath:indexPath];
        
        authorsModel * authirsInfo =self.observerModel.newsArray[indexPath.row];
        [cell setContentDetail:authirsInfo];
        
        return cell;
    }else
    {
        contractCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contractCell" forIndexPath:indexPath];
        
        authorsModel * authirsInfo =self.phoneArray[indexPath.row];
        [cell setContentDetail:authirsInfo];
        
        return cell;
    }
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageVC *messageVC = [[MessageVC alloc] init];
    // 点击时移除新消息的小红点
    if (self.FuncselectSegm.selectedSegmentIndex ==0) {
        authorsModel * authirsInfo =self.observerModel.newsArray[indexPath.row];
        authirsInfo.newsCount =0;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone ];
        //将消息列表保存在本地
        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString* documentDirectory = paths[0];
        NSString* fullPath =  [documentDirectory stringByAppendingString:@"/newsList"];
        NSFileManager* fileManager = [NSFileManager defaultManager];
        
        [fileManager removeItemAtPath:fullPath error:nil];
        [fileManager createFileAtPath:fullPath contents:nil attributes:nil];
        [self.observerModel saveToFile:fullPath ];
        //更新tarbar BadgeValue
        [self updateTabarBadgeValue];
     
    }

    [self.navigationController pushViewController:messageVC animated:YES];

}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
}


- (IBAction)addNewFriendBtnClick:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"showAdd" sender:nil];
}
- (IBAction)funcSegmal:(id)sender {
//    UISegmentedControl * Segmer =(UISegmentedControl *)sender;
//    NSInteger index=Segmer.selectedSegmentIndex;
    [self.tableView reloadData];
}


//-(void) insertNewsMessage
//{
//    if (self.dataArray.count >0) {
//        NSInteger groupCount = self.dataArray.count ;
//        categoryModel *categorInfo = self.dataArray[arc4random()%groupCount];
//        NSInteger friendCount = categorInfo.authors.count ;
//        authorsModel * authirsInfo =categorInfo.authors[arc4random()%friendCount];
//        [_observerModel.newsArray addObject:authirsInfo];
//        
//    }
//
//}

#pragma mark - KVO方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    //将消息列表保存在本地
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentDirectory = paths[0];
    NSString* fullPath =  [documentDirectory stringByAppendingString:@"/newsList"];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    [fileManager removeItemAtPath:fullPath error:nil];
    [fileManager createFileAtPath:fullPath contents:nil attributes:nil];
    [self.observerModel saveToFile:fullPath ];
    
    
    //只有在消息页面在刷新表数据
    if (self.FuncselectSegm.selectedSegmentIndex ==0) {
          [self.tableView reloadData];
    }
    //更新tarbar BadgeValue
    [self updateTabarBadgeValue];

}

 //计算新消息的数据 更新tarbar BadgeValue
- (void) updateTabarBadgeValue
{
    int totalNews = 0;
    for (authorsModel *newsModel in self.observerModel.newsArray) {
        totalNews += newsModel.newsCount
        ;
    }
    UITabBarItem * item  =[[self.tabBarController.tabBar items] objectAtIndex:0];
    if (totalNews>0) {
        [item setBadgeValue:[NSString stringWithFormat:@"%d",totalNews]];
    }else
    {
        [item setBadgeValue:nil];

    }
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
