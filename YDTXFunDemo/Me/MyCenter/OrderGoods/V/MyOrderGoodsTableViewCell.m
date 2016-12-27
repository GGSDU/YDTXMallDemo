//
//  MyOrderGoodsTableViewCell.m
//  YDTX
//
//  Created by 舒通 on 16/9/22.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MyOrderGoodsTableViewCell.h"

@interface MyOrderGoodsTableViewCell ()

@property(strong,nonatomic)dispatch_source_t timer;

@property (nonatomic, assign) long long int tim;

@property (nonatomic, strong) UILabel *stateLabel;//状态label
@property (nonatomic, strong) UILabel *orederLabel;//订单号
@property (nonatomic, strong) UIImageView   *headImageView;//图片
@property (nonatomic, strong) UILabel *titleLabel;//标题
@property (nonatomic, strong) UILabel *timeLabel;//时间
@property (nonatomic, strong) UILabel * locationLabel;//地点
@property (nonatomic, strong) UILabel *numLabel;//数量
@property (nonatomic, strong) UILabel * lastTimeLabel;//倒计时

@end

@implementation MyOrderGoodsTableViewCell

// 我的订单
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.orederLabel = [UILabel new];
        self.orederLabel.text = @"订单号：0000000";
        self.orederLabel.font = [UIFont systemFontOfSize:13*HeightScale];
        [self.contentView addSubview:self.orederLabel];
        [self.orederLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self);
            make.left.mas_equalTo (10*WidthScale);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth*2/3, 40*HeightScale));
        }];
        
        self.stateLabel = [UILabel new];
        self.stateLabel.text = @"交易成功";
        self.stateLabel.font = [UIFont systemFontOfSize:13*HeightScale];
        self.stateLabel.textColor = [UIColor colorWithRed:0.914 green:0.557 blue:0.231 alpha:1.000];
        self.stateLabel.textAlignment = 1;
        [self.contentView addSubview:self.stateLabel];
        [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self);
            make.left.mas_equalTo(self.orederLabel.mas_right).offset(10*WidthScale);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth/3-20*WidthScale, 40*HeightScale));
        }];
        UIView *lineView1 = [UIView new];
        lineView1.backgroundColor = [UIColor colorWithWhite:0.878 alpha:1.000];
        [self.contentView addSubview:lineView1];
        [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.orederLabel.mas_bottom);
            make.left.mas_equalTo(self).offset(10*WidthScale);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth-10*WidthScale, 0.5));
        }];

//        底部视图
        
        UIView *view = [UIView new];
        [self.contentView addSubview:view];

        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.orederLabel.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth, 140*HeightScale));
        }];
        
        
        self.headImageView = [[UIImageView alloc]init];
        self.headImageView.image = [UIImage imageNamed:@"sharemore_pic"];
        [view addSubview:self.headImageView];
        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(view).offset(10*HeightScale);
            make.left.mas_equalTo(view).offset(10*WidthScale);
            make.size.mas_equalTo(CGSizeMake(85*WidthScale, 50*HeightScale));
        }];
        
        self.titleLabel = [UILabel new];
        self.titleLabel.text = @"活动";
        [self.titleLabel sizeToFit];
        self.titleLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        self.titleLabel.numberOfLines = 0;
        [view addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headImageView);
            make.left.mas_equalTo(self.headImageView.mas_right).offset(10*WidthScale);
            make.height.mas_equalTo(50*HeightScale);
        }];
       
        
        self.timeLabel = [UILabel new];
        self.timeLabel.text = @"时间";
        self.timeLabel.textColor = [UIColor colorWithWhite:0.529 alpha:1.000];
        self.timeLabel.font = [UIFont systemFontOfSize:12*HeightScale];
        [view addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headImageView.mas_bottom).offset(12*HeightScale);
            make.left.mas_equalTo(self.headImageView);
            
        }];
        
        self.locationLabel = [UILabel new];
        self.locationLabel.text = @"地点";
        self.locationLabel.textColor = [UIColor colorWithWhite:0.573 alpha:1.000];
        self.locationLabel.font = [UIFont systemFontOfSize:12*HeightScale];
        [view addSubview:self.locationLabel];
        [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(10*HeightScale);
            make.left.mas_equalTo(self.timeLabel);
        }];
        
        self.numLabel = [UILabel new];
        self.numLabel.text = @"数量";
        self.numLabel.textColor = [UIColor colorWithWhite:0.573 alpha:1.000];
        self.numLabel.font = [UIFont systemFontOfSize:12*HeightScale];
        [view addSubview:self.numLabel];
        [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.locationLabel.mas_bottom).offset(10*HeightScale);
            make.left.mas_equalTo(self.locationLabel);
        }];

        UIView *lineView2 = [UIView new];
        lineView2.backgroundColor = [UIColor colorWithWhite:0.200 alpha:1.000];
        [self.contentView addSubview:lineView2];
        [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(view.mas_bottom);
            make.left.mas_equalTo(self).offset(10*WidthScale);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth-10*WidthScale, 0.5));
        }];
        
        
//        self.lastTimeLabel = [UILabel new];
//        self.lastTimeLabel.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1.000];
////        self.lastTimeLabel.text = @"倒计时";
////        self.lastTimeLabel.textColor = [UIColor colorWithRed:0.902 green:0.118 blue:0.173 alpha:1.000];
//        self.lastTimeLabel.font = [UIFont systemFontOfSize:15*HeightScale];
//        self.lastTimeLabel.textAlignment = 1;
//        [self.contentView addSubview:self.lastTimeLabel];
//        [self.lastTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(lineView2.mas_bottom);
//            make.size.mas_equalTo(CGSizeMake(ScreenWidth, 1*HeightScale));
//        }];
//        
//        
//        UIView *bottomView = [UIView new];
//        bottomView.backgroundColor = [UIColor colorWithWhite:0.878 alpha:1.000];
//        [self.contentView addSubview:bottomView];
//        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.lastTimeLabel.mas_bottom).offset(5*HeightScale);
//            make.left.mas_equalTo(self.contentView.mas_left).offset(10*WidthScale);
//            make.size.mas_equalTo(CGSizeMake(ScreenWidth-10*WidthScale, 0.5));
//        }];
        
        
        
        self.hyb_lastViewInCell = lineView2;
        self.hyb_bottomOffsetToCell = 0.0;
        
    }
    
    
    return self;
}
/*
-(void)setPayTimer:(NSInteger) integer{
    
    self.tim = integer;
    
    //0 获取一个全局的并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //1. 定义一个定时器
    
    dispatch_source_t  timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //这里创建的 timer, 是一个局部变量,由于 Block 回调定时器,因此,必须保证 timer 被强引用;
    self.timer = timer;
    dispatch_time_t startTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
    
    
    uint64_t interval = (uint64_t)1 * NSEC_PER_SEC;
    //2设置定时器的相关参数:开始时间,间隔时间,精准度等
    dispatch_source_set_timer( timer, startTime, interval, 0 * NSEC_PER_SEC);
    //3.设置定时器的回调方法
    dispatch_source_set_event_handler(timer, ^{
        
        
        //回主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.lastTimeLabel.text = [NSString stringWithFormat:@"%02lld:%02lld",self.tim/60,self.tim%60];
            
            self.tim--;
            if (self.tim == 0) {
                
//                self.timeLeft = 900;
                dispatch_cancel(self.timer);
                self.timer = nil;
                self.lastTimeLabel.text = @"";
//                self.timeLabel.text = @"超出支付时间，请重新下单";
                
                [self stopTimer];
            }
        });
    });
    //4.开启定时器
    dispatch_resume(timer);
    
}
-(void) stopTimer{
    // 停止
    if(_timer){
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}
*/
- (void)configCellWithModel:(MyOrderGoodsModel *)model {
    if (model.num) {
        self.numLabel.text = [@"数量：" stringByAppendingString:model.num];
        
    }
    
    if (model.act_address) {
        self.locationLabel.text = [@"地址：" stringByAppendingString:model.act_address];
        
    }
    
    if (model.jointime) {
        
        self.timeLabel.text = [@"活动时间：" stringByAppendingString:model.jointime];
    }
    
    
    
    if (model.act_theme) {
        
        self.titleLabel.text = model.act_theme;
    }
   
    
    
    if (model.order_num) {
        
        self.orederLabel.text = [@"订单号：" stringByAppendingString:model.order_num];
    }
    
  
    
    if (model.content) {
        
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[@"http://" stringByAppendingString:model.content]] placeholderImage:[UIImage imageNamed:@"zwt"]];
    }else{
    
        self.headImageView.image = [UIImage imageWithContentsOfFile:imagePath];
    }
    
    // 活动状态
    switch (model.status) {
        case -1:
        {
            self.stateLabel.text = @"订单已取消";
        }
            break;
        case 0:
        {
            self.stateLabel.text = @"待付款";
        }
            break;
        case 1:
        {
            self.stateLabel.text = @"已付款";
        }
            break;
            
        default:
            break;
    }
    
    
    
    
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    for (UIView *subView in self.subviews)
//    {
//        if([subView isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")])
//        {
//            UIView *confirmView=(UIView *)[subView.subviews firstObject];
//            //改背景颜色
////            confirmView.backgroundColor=[UIColor whiteColor];
//
//            for(UIView *sub in confirmView.subviews)
//            {
//                if([sub isKindOfClass:NSClassFromString(@"UIButtonLabel")])
//                {
//                    UILabel *deleteLabel=(UILabel *)sub;
////                    deleteLabel.textColor = [UIColor redColor];
//                    //改删除按钮的字体大小
//                    deleteLabel.font=[UIFont boldSystemFontOfSize:20];
//                }
//            }
//            break;
//        }
//    }
//    
//   
//}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
