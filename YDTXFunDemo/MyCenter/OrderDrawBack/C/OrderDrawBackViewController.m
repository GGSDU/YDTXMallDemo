//
//  OrderDrawBackViewController.m
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/16.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "OrderDrawBackViewController.h"
#import "OrderDrawBackView.h"

#import "Order_DrawBackStatusListTableViewController.h"
#import "MyCollectionViewCell.h"
#import "CTAssetsPickerController.h"
#import "UIImage+Scale.h"


@interface OrderDrawBackViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate
,CTAssetsPickerControllerDelegate,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIActionSheetDelegate>
{
    
    BOOL showList;//是否弹出下拉列表
    CGFloat tabheight;//table 下拉列表的高度
    CGFloat frameHeight;//frame 的高度
    
}

#pragma mark 界面布局
@property (strong, nonatomic) UIView *drawBackStatusBackGroundView;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UILabel *photoMessageLabel;//
@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) UIImageView *imageView;


#pragma mark 下拉列表
@property (strong, nonatomic) UILabel *statusMessage;

@property (assign, nonatomic) BOOL isTap;


@property (retain, nonatomic) UITableView *tv;//x下拉列表
@property (retain, nonatomic) NSArray *tableArray;//下拉列表数据



//@property (strong, nonatomic) Order_DrawBackStatusListTableViewController *drawBackStatus;
#pragma mark 图片选择
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) CGFloat kbH;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) NSInteger a;

@property (strong, nonatomic) NSMutableArray *selectedImage;

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) NSMutableArray *imageArr;


@end

@implementation OrderDrawBackViewController

- (UIView *)drawBackStatusBackGroundView {
    if (!_drawBackStatusBackGroundView) {
        _drawBackStatusBackGroundView = [[UIView alloc]init];
        _drawBackStatusBackGroundView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_drawBackStatusBackGroundView];
        
        [_drawBackStatusBackGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view.mas_top).offset(18*HeightScale);
            make.left.mas_equalTo(self.view.mas_left).offset(10*WidthScale);
            make.width.mas_equalTo(ScreenWidth-20*WidthScale);
            make.height.mas_equalTo(40*HeightScale);
        }];
    }
    return _drawBackStatusBackGroundView;
}


- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:15*HeightScale];
        [self.view addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.drawBackStatusBackGroundView.mas_bottom).offset(20*HeightScale);
            make.left.mas_equalTo(self.drawBackStatusBackGroundView.mas_left);
            make.width.mas_equalTo(self.drawBackStatusBackGroundView.mas_width);
            make.height.mas_equalTo(40*HeightScale);
        }];
        
        UILabel *messageLabel = [[UILabel alloc]init];
        messageLabel.text = @"退款原因（最多三张）";
        messageLabel.textColor = RGB(150, 150, 150);
        [messageLabel sizeToFit];
        [_textView addSubview:messageLabel];
        self.messageLabel = messageLabel;
        
        [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_textView.mas_top);
            make.left.mas_equalTo(_textView.mas_left).offset(15*WidthScale);
            make.height.mas_equalTo(40*HeightScale);
        }];
        
    }
    
    
    
    return _textView;
}

- (UILabel *)photoMessageLabel {
    if (!_photoMessageLabel) {
        _photoMessageLabel = [UILabel new] ;
        [_photoMessageLabel sizeToFit];
        _photoMessageLabel.textColor = RGB(150, 150, 150);
        _photoMessageLabel.text = @"上传凭证，最多三张";
        _photoMessageLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        [self.view addSubview:_photoMessageLabel];
        [_photoMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.textView.mas_left);
            
            make.top.mas_equalTo(self.textView.mas_bottom).offset(15*HeightScale);
        }];
        
    }
    return _photoMessageLabel;
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.image = [UIImage imageNamed:@"DrawBackListImg"];
        [self.drawBackStatusBackGroundView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.drawBackStatusBackGroundView.mas_top);
            make.right.mas_equalTo(self.drawBackStatusBackGroundView.mas_right).offset(-5*WidthScale);
            make.size.mas_equalTo(CGSizeMake(30*WidthScale, 40*HeightScale));
            
        }];
        
    }
    
    return _imageView;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = RGB(234, 234, 234);
    
    self.index = 0;
    self.isTap = NO;
    [self loadNewData];
    [self creatView];
    
    [self creatListView];
    
    
}


#pragma mark  创建下拉列表视图
- (void) creatListView {
    showList = NO;//默认不显示下拉框
    
    self.tv = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tv.delegate = self;
    self.tv.dataSource = self;
    
    self.tv.backgroundColor = [UIColor grayColor];
    self.tv.separatorColor = [UIColor grayColor];
    self.tv.hidden = YES;
    
    [self.view addSubview:self.tv];
    
    [self.tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.drawBackStatusBackGroundView.mas_bottom);
        make.left.mas_equalTo(self.drawBackStatusBackGroundView.mas_left);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-20*HeightScale, 40*HeightScale));
    }];

}

- (void)loadNewData {

    
   self.tableArray = @[@"已收货",@"未收货"];
    
    
}

#pragma mark 退款状态提示文字

- (void) creatView {
    
    UILabel *statusReminder = [[UILabel alloc]init];
    statusReminder.text = @"申请状态";
    statusReminder.textColor = RGB(150, 150, 150);
    [statusReminder sizeToFit];
    
    statusReminder.textAlignment = NSTextAlignmentCenter;
    statusReminder.font = [UIFont systemFontOfSize:15*HeightScale];
    [self.drawBackStatusBackGroundView addSubview:statusReminder];
    [statusReminder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.drawBackStatusBackGroundView.mas_left).offset(15*WidthScale);
        make.top.mas_equalTo(self.drawBackStatusBackGroundView.mas_top);

        make.height.mas_equalTo(self.drawBackStatusBackGroundView.mas_height);
    }];
    
    self.statusMessage = [[UILabel alloc]init];

    self.statusMessage.font = [UIFont systemFontOfSize:15*HeightScale];
    self.statusMessage.textColor = RGB(25, 25, 25);
    self.statusMessage.userInteractionEnabled = YES;
    [self.drawBackStatusBackGroundView addSubview:self.statusMessage];
    
    [self.statusMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(statusReminder.mas_right).offset(10);
        make.top.mas_equalTo(statusReminder.mas_top);
        make.right.mas_equalTo(self.imageView.mas_left);
        make.height.mas_equalTo(self.drawBackStatusBackGroundView.mas_height);
    }];
    
//    添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dropdown)];
    [self.statusMessage addGestureRecognizer:tap];
    
    self.collectionView.backgroundColor = RGB(234, 234, 234);

}
#pragma mark   改变输入视图的frame
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    self.messageLabel.hidden = YES;
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(200*HeightScale);
    }];
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    self.messageLabel.hidden = NO;
    
    if (textView.text.length > 0) {
        
    } else {
        [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40*HeightScale);
        }];

    }
    
    
    return YES;
}


#pragma 下拉列表的点击事件
- (void)dropdown {
    
    self.isTap = !self.isTap;
    
    if (showList) {//如果下拉框已显示，什么都不做
        return;
    } else { //如果下拉框尚未显示，则进行显示
        if (self.isTap) {
     //        把dropdownList放到前面，放置下拉框被别的控制器遮住
            [self.view bringSubviewToFront:self.tv];
            
            self.tv.hidden = NO;
            showList = YES;
            [UIView animateWithDuration:0.025 animations:^{
                
                [self.tv mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(self.tableArray.count*40*HeightScale);
                }];
            }];
        }else {
            [UIView animateWithDuration:0.025 animations:^{
                
                [self.tv mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(self.tableArray.count*40*HeightScale);
                }];
            }];
        }
       
       
    }
    
}

#pragma mark  下拉列表的视图
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    cell.textLabel.text = self.tableArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:12*HeightScale];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40*HeightScale;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.statusMessage.text = self.tableArray[indexPath.row];
    showList = NO;
    self.tv.hidden = YES;
    
    [UIView animateWithDuration:0.025 animations:^{
        [self.tv mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }];
    
    
}  
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textView resignFirstResponder];
    
    showList = NO;
    self.tv.hidden = YES;
    [self.tv mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    
}



#pragma mark ---图片选择
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];

        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];

        
        CGFloat rgb = 244 / 255.0;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
        _collectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [self.view addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.photoMessageLabel.mas_bottom).offset(15*HeightScale);
            make.left.mas_equalTo(self.photoMessageLabel.mas_left);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth-20*WidthScale, 200*HeightScale));
            
        }];
        
        
        [_collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
        
    }
    return _collectionView;
}

- (void) selectImage {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
        if (status != PHAuthorizationStatusAuthorized) return;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 弹出图片选择界面
            CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
            // 隐藏空相册
            picker.showsEmptyAlbums = YES;
            // 显示图片索引
            picker.showsSelectionIndex = YES;
            picker.assetCollectionSubtypes = @[
                                               @(PHAssetCollectionSubtypeSmartAlbumUserLibrary),
                                               @(PHAssetCollectionSubtypeAlbumRegular)
                                               ];
            picker.delegate = self;
            
            [self presentViewController:picker animated:YES completion:nil];
        });
    }];
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.index++;
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CGFloat scale = image.size.height/image.size.width;
    //    NSLog(@"原始图片的尺寸：%f,%f",image.size.width,image.size.height);
    if (image.size.width>1000) {
        
        [self creatImageView:[UIImage imageWithImage:image scaledToSize:CGSizeMake(image.size.width/3, image.size.width/3*scale) scaled:scale] sca:scale];
        ;
        
    }else {
        [self creatImageView:[UIImage imageWithImage:image scaledToSize:CGSizeMake(image.size.width, image.size.height) scaled:scale] sca:scale];
    }
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(PHAsset *)asset
{
    NSInteger max = 9;
    
    if (picker.selectedAssets.count+self.index < max) return YES;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意"
                                                                   message:[NSString stringWithFormat:@"最多选择%zd张图片", max]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil]];
    // 这里一定要用picker，不能使用self（因为当前显示在上面的控制器是picker，不是self）
    [picker presentViewController:alert animated:YES completion:nil];
    
    return NO;
}

/**
 *  选择完毕的时候调用
 */
- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    
    // 关闭图片选择界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    // 选择图片时的配置项
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode   = PHImageRequestOptionsResizeModeExact;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    //    self.index += assets.count;
    // 显示图片
    for (NSInteger i = 0; i < assets.count; i++) {
        PHAsset *asset = assets[i];
        CGSize size = CGSizeMake(asset.pixelWidth / [UIScreen mainScreen].scale, asset.pixelHeight / [UIScreen mainScreen].scale);
        
        // 请求图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            // 添加图片控件
            self.index++;
            CGFloat scale = result.size.height/result.size.width;
            //            NSLog(@"比利时：%f",scale);
            if (result.size.width>1000) {
                
                
                [self creatImageView:[UIImage imageWithImage:result scaledToSize:CGSizeMake(result.size.width/3, result.size.width/3*scale) scaled:scale] sca:scale];
                
            }else {
                [self creatImageView:[UIImage imageWithImage:result scaledToSize:CGSizeMake(result.size.width, result.size.height) scaled:scale] sca:scale];
                
            }
        }];
    }
}
#pragma mark 创建图片视图
- (void) creatImageView:(UIImage *)image sca:(CGFloat) sca{
    @autoreleasepool {
        
        
        [self.selectedImage addObject:image];
        NSData *data;
        
        //判断图片是不是png格式的文件
        //        data = UIImageJPEGRepresentation(image, 0.7);
        
        //        for (int i = 7; i < 11; i++) {
        //            data = UIImageJPEGRepresentation(image, i * 0.1);
        //            NSLog(@"post image length : *** %lu",data.length);
        //        }
        data = UIImageJPEGRepresentation(image, 0.9);
        //        NSLog(@"post image length : *** %lu",data.length);
        
        NSString *imageStr = [data base64Encoding];
        imageStr = [imageStr stringByAppendingString:@","];
        
        [self.imageArr addObject:imageStr];
        [self.collectionView reloadData];
    }
    
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MyCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    
    if (indexPath.row == self.index) {
        cell.imgView.image = [UIImage imageNamed:@"maket_checkGoods_addAddressbtn"];
        cell.imgView.contentMode = UIViewContentModeScaleAspectFit;
        cell.deleteBtn.hidden = YES;
    }else {
        //        cell.imgView = self.imageView;
        cell.imgView.image = self.selectedImage[indexPath.row];
        cell.imgView.contentMode = UIViewContentModeScaleToFill;
        cell.deleteBtn.hidden = NO;
    }
    
    cell.deleteBtn.tag = indexPath.row;
    //    NSLog(@"cell.deleteBtn.tag:%ld",cell.deleteBtn.tag);
    
    [cell.deleteBtn addTarget:self action:@selector(deleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
// 设置每个分区返回多少item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.index+1;
    
}
// 设置集合视图有多少个分区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
#pragma mark - UICollectionViewDelegateFlowLayout
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    
//    return CGSizeZero;
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    return CGSizeZero;
//}
//定义每个UICollectionView 的大小
- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath
{
    NSInteger w = [UIScreen mainScreen].bounds.size.width/4;
    
    return CGSizeMake (w,w);
    
}
//定义每个UICollectionView 的边距
-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section

{
    
    
    return UIEdgeInsetsMake (10,10,10,10);
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.index&&indexPath.row<9) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"相机", nil];
        [sheet showInView:self.view];
    }
    
}


#pragma mark - LxGridViewDataSource

/// 以下三个方法为长按排序相关代码
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    //    return indexPath.item < _selectedPhotos.count;
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath canMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    //    return (sourceIndexPath.item < _selectedPhotos.count && destinationIndexPath.item < _selectedPhotos.count);
    return  YES;
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath didMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    //    UIImage *image = _selectedPhotos[sourceIndexPath.item];
    //    [_selectedPhotos removeObjectAtIndex:sourceIndexPath.item];
    //    [_selectedPhotos insertObject:image atIndex:destinationIndexPath.item];
    //
    //    id asset = _selectedAssets[sourceIndexPath.item];
    //    [_selectedAssets removeObjectAtIndex:sourceIndexPath.item];
    //    [_selectedAssets insertObject:asset atIndex:destinationIndexPath.item];
    //
    //    [_collectionView reloadData];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
#pragma clang diagnostic pop
    switch (buttonIndex) {
        case 0:
            //            NSLog(@"相册");
            [self selectImage];
            break;
        case 1:{
            //            NSLog(@"相机");
            [self takePhoto];
        }
            
        default:
            break;
    }
}



#pragma mark - UIImagePickerController

- (void)takePhoto {
    if (self.index<9) {
        
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
            // 无权限 做一个友好的提示
            
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
            [alert show];
#define push @#clang diagnostic pop
        } else {
            // 调用相机
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
                self.imagePickerVc.sourceType = sourceType;
                if(iOS8Later) {
                    _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                    
                }
                if (iOS9Later) {
                    _imagePickerVc.sourceType = UIImagePickerControllerSourceTypeCamera;
                }
                [self presentViewController:_imagePickerVc animated:YES completion:nil];
            } else {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"当前设备不支持拍照" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alertView show];
                
            }
            
        }
    }
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)deleteBtn:(UIButton *)sender {
    //    NSLog(@"^^^^^^cell.deleteBtn.tag:%ld",sender.tag);
    [self.selectedImage removeObjectAtIndex:sender.tag];
    [self.imageArr removeObjectAtIndex:sender.tag];
    
    [self.collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
        self.index--;
        
        [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [self.collectionView reloadData];
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
