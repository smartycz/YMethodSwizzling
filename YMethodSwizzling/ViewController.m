//
//  ViewController.m
//  YMethodSwizzling
//
//  Created by Stone.Yu on 16/6/15.
//  Copyright © 2016年 Stone.Yu. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+ActionLog.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *button1;
//@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 150, 300, 300) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}

- (void)initView
{
    [self.view addSubview:self.tableView];
    
    self.button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 50, 50)];
    self.button1.titleLabel.text = @"button1";
    [self.button1.titleLabel setTintColor:[UIColor whiteColor]];
    [self.button1 setBackgroundColor:[UIColor grayColor]];
    [self.button1 addTarget:self action:@selector(buttonClicked1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 50, 50, 50)];
    button2.titleLabel.text = @"button2";
    [button2 setBackgroundColor:[UIColor grayColor]];
    [button2 addTarget:self action:@selector(buttonClicked2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    self.button3 = [[UIButton alloc] initWithFrame:CGRectMake(200, 50, 50, 50)];
    self.button3.titleLabel.text = @"button3";
    [self.button3 setBackgroundColor:[UIColor grayColor]];
    [self.button3 addTarget:self action:@selector(buttonClicked3:) forControlEvents:UIControlEventTouchUpInside eventID:@"123456"];
    [self.view addSubview:self.button3];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = @(indexPath.row).stringValue;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", @(indexPath.row).stringValue);
}

- (void)buttonClicked1:(UIButton *)button
{
    NSLog(@"buttonClicked1");
    self.logDic = @{@"name":@"shizi"};
}

- (void)buttonClicked2:(UIButton *)button
{
    NSLog(@"buttonClicked2");
    self.logDic = @{@"name":@"yoyo"};
}

- (void)buttonClicked3:(UIButton *)button
{
    NSLog(@"buttonClicked3");
    self.logDic = @{@"name":@"momo"};
}

@end
