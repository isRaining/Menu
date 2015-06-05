//
//  ViewController.m
//  foldMenu
//
//  Created by Code on 15/6/4.
//  Copyright (c) 2015年 Code. All rights reserved.
//

#import "ViewController.h"
#import "topMenu.h"
#import "TGCover.h"
#import "firstLevel.h"

#define contentHeight 150
#define buttonWidht [UIScreen mainScreen].bounds.size.width/3
#define buttonHeight 40

static int buttonTag = 0;
// 5.默认的动画时间
#define kDefaultAnimDuration .4

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    TGCover *_cover; // 遮盖
    UIView *_contentView;
    
    firstLevel * button1 ;
    firstLevel * button2;
    firstLevel * button3 ;
    
    NSArray * array1;
    NSArray * array1_1;
    NSArray * tampArr;
    NSArray * array2;
    NSArray * array3;
    
    UITableView * tabView;
    UITableView * tabView1_1;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    //初始化数据
    array1 = [NSArray arrayWithObjects:@"出行工具",@"美食",@"休闲",@"团购",@"周边旅游",@"住宿",@"彩票", nil];
    array1_1=[NSArray arrayWithObjects:@[@"汽车",@"电动车",@"山地车"], @[@"烧烤",@"羊蝎子",@"牛肉汤"],@[@"桌球",@"游戏机",@"音乐"],@[@"包包",@"手表",@"外套"],@[@"故宫",@"八达岭长城",@"颐和园"],@[@"爱尚主题酒店",@"短租",@"合租"],@[@"双色球",@"时时彩",@"刮刮乐"],nil];
    tampArr = [NSArray arrayWithArray:array1_1[0]];
    array2 = [NSArray arrayWithObjects:@"朝阳区",@"海淀区",@"大兴区",@"昌平区",@"丰台区",@"房山",@"通州区",@"东城区", nil];
    array3 = [NSArray arrayWithObjects:@"默认排序",@"价格最低",@"价格最高",@"人气高",@"最新发布",@"销售量",nil];
    
    //添加一个背景遮罩
    _cover = [TGCover coverWithTarget:self action:@selector(hide)];
    _cover.frame = self.view.bounds;
    _cover.alpha=0.0;
    [self.view addSubview:_cover];
    
    // 2.内容view
    _contentView = [[UIView alloc] init];
    _contentView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, contentHeight);
    _contentView.alpha=0;
    _contentView.backgroundColor=[UIColor redColor];
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_contentView];
    
    
    //添加一级菜单
    topMenu  * top = [[topMenu alloc ] initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, 40)];
    top.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:top];
    
    button1 = [[firstLevel alloc]initWithFrame:CGRectMake(0, 0, buttonWidht, buttonHeight)];
    button1.tag=101;
    [button1 setTitle:@"全部分类" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(buttonActionsss:) forControlEvents:UIControlEventTouchUpInside];
    [top addSubview:button1];
    
    button2 = [[firstLevel alloc]initWithFrame:CGRectMake(buttonWidht, 0, buttonWidht, buttonHeight)];
    button2.tag=102;
    [button2 setTitle:@"全部商区" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(buttonActionsss:) forControlEvents:UIControlEventTouchUpInside];
    [top addSubview:button2];
    
    button3 = [[firstLevel alloc]initWithFrame:CGRectMake(buttonWidht*2, 0, buttonWidht, buttonHeight)];
    button3.tag=103;
    [button3 setTitle:@"排序方式" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(buttonActionsss:) forControlEvents:UIControlEventTouchUpInside];
    [top addSubview:button3];
    
    //添加tableView
    tabView = [[UITableView alloc]initWithFrame:_contentView.frame style:UITableViewStylePlain];
    tabView.delegate=self;
    tabView.dataSource=self;
    tabView.separatorStyle=UITableViewCellSelectionStyleGray;
    [_contentView addSubview:tabView];
    
    tabView1_1 = [[UITableView alloc]initWithFrame:CGRectMake(100, 0, [UIScreen mainScreen].bounds.size.width-100, contentHeight) style:UITableViewStylePlain];
    tabView1_1.delegate=self;
    tabView1_1.dataSource=self;
    tabView1_1.hidden=YES;
    tabView1_1.tableFooterView=[[UIView alloc]init];
    tabView1_1.separatorStyle=UITableViewCellSelectionStyleGray;
    [_contentView addSubview:tabView1_1];
}

-(void)buttonActionsss:(UIButton * )sender
{
    NSLog(@"%li",(long)sender.tag);
    if (sender.tag==101) {
        button1.selected=!button1.selected;
        button2.selected=NO;
        button3.selected=NO;
        tabView1_1.hidden=NO;
        buttonTag = 101;
    }else if (sender.tag==102){
        button1.selected=NO;
        button2.selected=!button2.selected;
        button3.selected=NO;
        tabView1_1.hidden=YES;
        buttonTag = 102;
    }else{
        button1.selected=NO;
        button2.selected=NO;
        button3.selected=!button3.selected;
        tabView1_1.hidden=YES;
        buttonTag = 103;
    }
    if (sender.selected) {
        [self show];
    }else{
        [self hide];
    }
    [tabView reloadData];
}

#pragma mark 显示
- (void)show
{
    //显示时从顶部慢慢滑下来
    _contentView.transform = CGAffineTransformMakeTranslation(0, 100);
    _contentView.alpha = 0;
    _cover.alpha = 0;
    [UIView animateWithDuration:kDefaultAnimDuration animations:^{
        // 1.scrollView从上面 -> 下面
        
        //CGAffineTransformIdentity记录上一次坐标变化前的位置
//        _contentView.transform = CGAffineTransformIdentity;
        _contentView.alpha = 1;
        
        // 2.遮盖（0 -> 0.4）
        [_cover reset];
        
        //        // 2.遮盖（0 -> 0.4）
        //        _cover.alpha = kCoverAlpha;
    }];
}

- (void)hide
{
    UIButton * button = (UIButton * )[self.view viewWithTag:buttonTag];
    [button setSelected:NO];
    
    [UIView animateWithDuration:kDefaultAnimDuration animations:^{
        // 1.scrollView从下面 -> 上面
        _contentView.transform = CGAffineTransformMakeTranslation(0, -_contentView.frame.size.height);
        
        _contentView.alpha = 0;
        
        // 2.遮盖（0.4 -> 0）
        _cover.alpha = 0;
    } completion:^(BOOL finished) {
        // 从父控件中移除
//        [self.view removeFromSuperview];
        
        // 恢复属性
//        _contentView.transform = CGAffineTransformIdentity;
        _contentView.alpha  = 0;
        //_cover.alpha = kCoverAlpha;
        
        // 2.遮盖（0 -> 0.4）
        //[_cover reset];
    }];
}

#pragma mark tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == tabView) {
        if (buttonTag == 101) {
            return array1.count;
        }else if (buttonTag == 102){
            return array2.count;
        }else{
            return array3.count;
        }
    }else if (tableView==tabView1_1){
        return [tampArr count];
    }else{
        return 0;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (tableView == tabView) {
        if (buttonTag == 101) {
            cell.textLabel.text=array1[indexPath.row];
            NSLog(@"%@",cell.textLabel.text);
        }else if (buttonTag == 102){
            cell.textLabel.text=array2[indexPath.row];
        }else if(buttonTag == 103){
            cell.textLabel.text=array3[indexPath.row];
        }
    }else if (tableView == tabView1_1){
        cell.textLabel.text=tampArr[indexPath.row];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tabView) {
        if (buttonTag == 101) {
            tampArr = array1_1[indexPath.row];
            [tabView1_1 reloadData];
        }else if (buttonTag == 102){
            [button2 setTitle:array2[indexPath.row] forState:UIControlStateNormal] ;
            [self hide];
        }else if(buttonTag == 103){
            [button3 setTitle:array3[indexPath.row] forState:UIControlStateNormal] ;
            [self hide];
        }
    }else if (tableView == tabView1_1){
        [button1 setTitle:tampArr[indexPath.row] forState:UIControlStateNormal] ;
        [self hide];
    }
    
    
    
}
@end
