//
//  MarketDetailCell.m
//  market
//
//  Created by RookieHua on 2016/12/6.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MarketDetailCell.h"

@interface MarketDetailCell ()

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation MarketDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
}


-(void)setMarketDetailModel:(marketDetailModel *)marketDetailModel{
    _marketDetailModel = marketDetailModel;
    
    marketDetailModel.content = [marketDetailModel.content stringByReplacingOccurrencesOfString:@"src=\"" withString:@"src=\"http://m.yundiaoke.cn"];
    
    
    NSLog(@"-htmlString-:%@",marketDetailModel.content);
//
    
    NSLog(@"%@",self.webView);
    NSString *htmlString = marketDetailModel.content;
//    [self.webView loadHTMLString:htmlString baseURL:nil];
    NSLog(@"%@",self.webView);
    


}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)webViewDidFinishLoad:(UIWebView *)webView { //webview 自适应高度
//    
//    //定义JS字符串
//    //适配屏幕大小
//    
//    //定义JS字符串
//    NSString *script = [NSString stringWithFormat: @"var script = document.createElement('script');"
//                        "script.type = 'text/javascript';"
//                        "script.text = \"function ResizeImages() { "
//                        "var myimg;"
//                        "var maxwidth=%f;" //屏幕宽度
//                        "for(i=0;i <document.images.length;i++){"
//                        "myimg = document.images[i];"
//                        "myimg.height = maxwidth / (myimg.width/myimg.height);"
//                        "myimg.width = maxwidth-15;"
//                        "}"
//                        "}\";"
//                        "document.getElementsByTagName('p')[0].appendChild(script);",YDTXScreenW];
//    
//    //添加JS
//    [webView stringByEvaluatingJavaScriptFromString:script];
//    
//    //添加调用JS执行的语句
//    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
//    
//    
//    
//    //调整页面
//    
//    
//  CGFloat webViewHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] floatValue]+69;
//    
//    NSLog(@"!!!!%lf",webViewHeight);
//    
//    
//    
//    self.webView.frame = CGRectMake(0, 0, YDTXScreenW, webViewHeight);
//    
//    [self layoutIfNeeded];
//  
//    
//}


@end
