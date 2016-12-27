//
//  SpotAddDescribView.m
//  YDTX
//
//  Created by 舒通 on 2016/12/20.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "SpotAddDescribView.h"
#import "SelectImageCollectionView.h"


@interface SpotAddDescribView ()<SelectImageCollectionViewDelegate,UITextViewDelegate>

@property (strong, nonatomic) NSArray *colorArr;

@property (strong, nonatomic) UILabel *statusLabel;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UILabel *addImageLabel;
@property (strong, nonatomic) UILabel *palceHoldLabel;
@property (strong, nonatomic) SelectImageCollectionView *selectImgV;

@property (strong, nonatomic) NSArray *ImgArray;



@end

@implementation SpotAddDescribView

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [UILabel new];
        [_statusLabel sizeToFit];
        _statusLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        _statusLabel.textColor = RGB(82, 82, 82);
        _statusLabel.text = @"塘口描述";
        [self addSubview:_statusLabel];
        [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(10*WidthScale);
            make.top.mas_equalTo(self.mas_top).offset(10*HeightScale);

        }];
        
    }
    return _statusLabel;
}
- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.textColor = [UIColor blackColor];
        
        _textView.layer.borderColor = RGB(202, 203, 207).CGColor;
        _textView.layer.borderWidth = 1;
        _textView.layer.cornerRadius = 5;
        _textView.delegate = self;
        [self addSubview:_textView];
        
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.statusLabel.mas_bottom).offset(20*HeightScale);
            make.left.mas_equalTo(self.statusLabel.mas_left);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth-20*WidthScale, 102*HeightScale));
        }];
        
        
    }
    return _textView;
}

- (UILabel *)palceHoldLabel {
    if (!_palceHoldLabel) {
        _palceHoldLabel = [UILabel new];
        [_palceHoldLabel sizeToFit];
        _palceHoldLabel.numberOfLines = 0;
        
        _palceHoldLabel.textColor = RGB(198, 198, 198);
        _palceHoldLabel.font = [UIFont systemFontOfSize:14*HeightScale];
        [self.textView addSubview:_palceHoldLabel];
        [_palceHoldLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.textView.mas_top).offset(10*HeightScale);
            make.left.mas_equalTo(self.textView.mas_left).offset(10*WidthScale);

            make.width.mas_equalTo(ScreenWidth-40*WidthScale);
        }];
    }
    return _palceHoldLabel;
}

- (UILabel *)addImageLabel {
    
    if (!_addImageLabel) {
        _addImageLabel = [UILabel new];
        [_addImageLabel sizeToFit];
        _addImageLabel.textColor = RGB(82, 82, 82);
        _addImageLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        _addImageLabel.text = @"添加图片";
        [self addSubview:_addImageLabel];
        
        [_addImageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.textView.mas_bottom).offset(15*HeightScale);
            make.left.mas_equalTo(self.textView.mas_left);
        }];
    }
    return _addImageLabel;
    
}

- (SelectImageCollectionView *)selectImgV {
    if (!_selectImgV) {
        _selectImgV = [[SelectImageCollectionView alloc]initWithFrame:CGRectZero colorArr:self.colorArr];
        _selectImgV.delegate = self;
        [self addSubview:_selectImgV];
        
        [_selectImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.addImageLabel.mas_bottom).offset(15*HeightScale);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth, 200));
            make.left.mas_equalTo(self.mas_left);
        }];
        
    }
    return _selectImgV;
}


- (instancetype)initWithFrame:(CGRect)frame collectionViewBackGroundColorArr:(NSArray *)colorArr palceHoldString:(NSString *)string {
    NSLog(@"colorarr is :%@",colorArr);
    if (self = [super initWithFrame:frame]) {
        
        self.palceHoldLabel.text = string;
        
        
        if (colorArr) {
            self.colorArr = colorArr;
            
            self.selectImgV.backgroundColor = RGB([colorArr[0] floatValue], [colorArr[1] floatValue], [colorArr[2] floatValue]);
            
        } else {
            
            self.textView.font = [UIFont systemFontOfSize:15*HeightScale];
        }

    }
    
    return self;
}

- (void)didSelectedImageArray:(NSArray *)imageArr {
    self.ImgArray = imageArr;
    NSLog(@"self.imageArray .count is :%ld",self.ImgArray.count);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectImage" object:self.ImgArray];
    
}
- (void)textViewDidChange:(UITextView *)textView {
    if (_delegate && [_delegate respondsToSelector:@selector(didEditEndString:)]) {
        [_delegate didEditEndString:textView.text];
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.palceHoldLabel.hidden = YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length > 0) {
        self.palceHoldLabel.hidden = YES;
    } else self.palceHoldLabel.hidden = NO;
}
/*
 如时间、地点、适合人群、活动行程、活动亮点、建议价格、装备要求等
 */

//- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
//    
//    
//    return YES;
//}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textView resignFirstResponder];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
