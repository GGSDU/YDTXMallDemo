//
//  MarketDetailCell.m
//  market
//
//  Created by RookieHua on 2016/12/6.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MarketDetailCell.h"
#import <WebKit/WebKit.h>
@interface MarketDetailCell ()<UIWebViewDelegate>



@property(strong,nonatomic)WKWebView *wkWebView;

@end

@implementation MarketDetailCell

-(WKWebView *)wkWebView{

    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, YDTXScreenW, 500)];
        _wkWebView.backgroundColor = [UIColor redColor];
    }

    return _wkWebView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
}


-(void)setMarketDetailModel:(marketDetailModel *)marketDetailModel{
    _marketDetailModel = marketDetailModel;

    
    
    
    
    

//    
//    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, YDTXScreenW, 500)];
//    webView.UIDelegate = self;
//    [self.contentView addSubview:webView];
//    

    
    UIWebView *marketDeatilcellWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, YDTXScreenW, 500)];
    marketDeatilcellWebView.scrollView.scrollEnabled = NO;
    marketDeatilcellWebView.delegate = self;
    
    [self.contentView addSubview:marketDeatilcellWebView];

    

    
    
    marketDetailModel.content = [marketDetailModel.content stringByReplacingOccurrencesOfString:@"src=\"" withString:@"src=\"http://m.yundiaoke.cn"];
    
    
    NSLog(@"-htmlString-:%@",marketDetailModel.content);
    NSString *dealSizeStr = [NSString stringWithFormat:@"<head><style>img{max-width:%f !important;}</style></head>",YDTXScreenW];
    NSString *htmlString = [NSString stringWithFormat:@"%@%@",dealSizeStr,marketDetailModel.content];

    
    
    [marketDeatilcellWebView loadHTMLString:htmlString baseURL:nil];
    
    


}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}





-(void)webViewDidFinishLoad:(UIWebView*)webView{
    CGSize actualSize = [webView sizeThatFits:CGSizeZero];
    CGRect newFrame = webView.frame;
    newFrame.size.height = actualSize.height;
    webView.frame = newFrame;
    

    
    

//    [self updateHeight:newFrame.size.height];
    

    
}

-(void)updateHeight:(CGFloat)height{


    if ([self.delegate respondsToSelector:@selector(updateCellHeightWithHeight:)]) {
        
        
        [self.delegate updateCellHeightWithHeight:height];
        NSLog(@"---->:%f",height);
    }

}



@end
