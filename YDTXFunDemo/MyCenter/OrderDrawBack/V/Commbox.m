//
//  Commbox.m
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/16.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "Commbox.h"

@implementation Commbox



- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.height < 200) {
        frameHeight = 200;
    } else {
        frameHeight = frame.size.height;
    }
    
    tabheight = frameHeight - 30;

    if (self = [super initWithFrame:frame]) {
        
        showList = NO;//默认不显示下拉框
        
        tv = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, frame.size.width+80, 0)];
        tv.delegate = self;
        tv.dataSource = self;
        
        tv.backgroundColor = [UIColor grayColor];
        tv.separatorColor = [UIColor yellowColor];
        tv.hidden = YES;
        
        [self addSubview:tv];
        
        
        textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, frame.size.width+80, 30)];
        textField.font = [UIFont systemFontOfSize:12*HeightScale];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        [textField addTarget:self action:@selector(dropdown) forControlEvents:UIControlEventAllEvents];
        [self addSubview:textField];
        
        
    }
    return self;
}

- (void)dropdown {
    
    [textField resignFirstResponder];
    
    if (showList) {//如果下拉框已显示，什么都不做
        return;
    } else { //如果下拉框尚未显示，则进行显示
        CGRect sf = self.frame;
        sf.size.height = frameHeight;
        
//        把dropdownList放到前面，放置下拉框被别的控制器遮住
        [self.superview bringSubviewToFront:self];
        
        tv.hidden = NO;
        showList = YES;
        
        CGRect frame = tv.frame;
        frame.size.height = 0;
        tv.frame = frame;
        frame.size.height = tabheight;
        
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        self.frame = sf;
        tv.frame = frame;
        [UIView commitAnimations];
        
        
    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    cell.textLabel.text = tableArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:12*HeightScale];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35*HeightScale;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    textField.text = tableArray[indexPath.row];
    showList = NO;
    tv.hidden = YES;
    
    CGRect sf = self.frame;
    sf.size.height = 30;
    self.frame = sf;
    
    CGRect frame = tv.frame;
    frame.size.height = 0;
    tv.frame = frame;
    
    
}  


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end