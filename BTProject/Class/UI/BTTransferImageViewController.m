//
//  TransferImageViewController.m
//  BTProject
//
//  Created by 明桐的Mac on 16/3/22.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTTransferImageViewController.h"
#import "AppDelegate.h"
#import "BTTransferImageCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
@interface BTTransferImageViewController()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout> {
}
@property (nonatomic, strong)UICollectionView *transferCollection;
@property (nonatomic, strong)BTTransferImageCell *myCell;
@end
@implementation BTTransferImageViewController

- (void)dealloc {
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatTitleNav];
    [self creatHomeUI];
}

- (void)initParameters {
    [super initParameters];

//    _dataSouce = [NSMutableArray array];
}
- (void)setDataSouce:(NSMutableArray *)dataSouce {
    _dataSouce = dataSouce;
    if (_dataSouce && [BTPreferences savePhoto] == NO) {
        [self creatExchage];
        [BTPreferences setTransfelPhotoWithIsSave:YES];
    }
    if (_dataSouce == 0 || _dataSouce == nil) {
        [_dataSouce addObject:@""];
    }
}

#pragma mark 创建导航栏

- (void)creatTitleNav {
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HKUIScreenWidth, 64)];
    navView.backgroundColor = BTColor(252, 99, 100);

    UIButton *titileBtn = [BTCommonUtil createButtonFrame:CGRectMake(HKUIScreenWidth/2 - 45, 15, 90, 50) Target:self BgColor:nil Title:@"所有照片" TitleColor:UIColorC3 BgImg:nil action:@selector(clickAction) Tag:0];
    titileBtn.titleLabel.font = UISystemFontT7;
    
    UIButton *backBtn = [BTCommonUtil createButtonFrame:CGRectMake(10, titileBtn.top, 50, 50) Target:self BgColor:nil Title:@"取消" TitleColor:UIColorC3 BgImg:nil action:@selector(backAction) Tag:0];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:13];

    [self.view addSubview:navView];
    [navView addSubview:titileBtn];
    [navView addSubview:backBtn];
}

- (void)creatExchage {
    for (int i = 0; i < _dataSouce.count/2; i++) {
        [self.dataSouce exchangeObjectAtIndex:i withObjectAtIndex:_dataSouce.count-(1+i)];
    }
}

#pragma mark 创建collectionView视图为主视图

- (void)creatHomeUI{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake((HKUIScreenWidth - 2*4) / 3 , (HKUIScreenWidth - 2*4) / 3);
    layout.minimumLineSpacing = 2;
    layout.minimumInteritemSpacing = 2;
    self.transferCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(BTZero, 64, HKUIScreenWidth,HKUIScreenHeight-49) collectionViewLayout:layout];
    self.transferCollection.bounces = NO;
    self.transferCollection.scrollsToTop = YES;
    self.transferCollection.backgroundColor = [UIColor clearColor];
    self.transferCollection.delegate = self;
    self.transferCollection.showsVerticalScrollIndicator = YES;
    self.transferCollection.pagingEnabled = YES;
    [self.view addSubview:_transferCollection];

    [_transferCollection registerClass:[BTTransferImageCell class] forCellWithReuseIdentifier:@"cellID"];
    _transferCollection.delegate = self;
    _transferCollection.dataSource = self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   
    return _dataSouce.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    _myCell = (BTTransferImageCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    return _myCell;
    
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    _myCell.backgroundColor = [UIColor clearColor];
    ALAsset *asset = _dataSouce[indexPath.row];
    NSString *type = [asset valueForProperty:ALAssetPropertyType];
    //会出现没有数据情况
    if (type == nil) {
        type = ALAssetTypePhoto;
    }
    if ([type isEqualToString:ALAssetTypePhoto]) {
        CGImageRef cmimg = [asset thumbnail];
        UIImage *img = [UIImage imageWithCGImage:cmimg];
        if (indexPath.row == 0) {
            _myCell.cellImageVIew.image = [UIImage imageNamed:@"btn_library_camera"];
        }else {
            _myCell.cellImageVIew.image = img;
        }
    }

}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    return UIEdgeInsetsMake(2, 2, 2, 2);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront] && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController * picker=[[UIImagePickerController alloc]init];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.allowsEditing = NO;
            picker.delegate = self;
            [self presentViewController:picker animated:YES completion:nil];
        } else {
//            showFadeOutView(@"相机不可用哦", NO, 1);
        }
    }
}
- (void)clickAction {
    
}
- (void)backAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
