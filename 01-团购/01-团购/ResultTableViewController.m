//
//  ResultTableViewController.m
//  01-团购
//
//  Created by qingyun on 16/5/20.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ResultTableViewController.h"
#import "QYTGModel.h"
#import "QYResultCell.h"
@interface ResultTableViewController ()
@property (nonatomic, strong) NSArray *resultArray;
@end

@implementation ResultTableViewController
static NSString *resultIdentifier = @"resultCell";

//当searchBar获取第一响应,或者是searchBar的文本发生改变的时候,调用
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    if (searchController.searchBar.text.length == 0) {
        _resultArray = _willFilterArray;
        
    }
    
    //用关键字过滤标题
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.title CONTAINS[CD] %@",searchController.searchBar.text];
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF.price CONTAINS[CD] %@",searchController.searchBar.text];
    _resultArray = [_willFilterArray filteredArrayUsingPredicate:predicate];
    _resultArray = [_willFilterArray filteredArrayUsingPredicate:predicate1];
    [self.tableView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    //对商品类型的cell注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QYResultCell class]) bundle:nil] forCellReuseIdentifier:resultIdentifier];
    
    //设置行高
    self.tableView.rowHeight = 120;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _resultArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //获取当前行对应的模型
    QYTGModel *Model = _resultArray[indexPath.row];
    
           QYResultCell *tgCell = [tableView dequeueReusableCellWithIdentifier:resultIdentifier forIndexPath:indexPath];
        tgCell.tgModel = Model;
        return tgCell;
 

}



@end
