//
//  MyPhotosVC.m
//  yojiaolian
//
//  Created by carcool on 12/8/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyPhotosVC.h"
#import "MyPhotoCell0.h"
#import "MyPhotoCell1.h"
#import <QiniuSDK.h>
#import "EditInfoVC.h"
@interface MyPhotosVC ()

@end

@implementation MyPhotosVC
@synthesize picker,lineViewWhite0,lineViewWhite1;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.title=@"我的图片";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.photoShowing=NO;
    self.cameraOrAlbum=0;
    self.updateType=0;
    self.editProgress=0;
    self.m_aryPhotos=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    
    [self.deleteView setBackgroundColor:[UIColor clearColor]];
    
    [self getUserInfo];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"修改照片"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"修改照片"];
}
-(void)getUserInfo
{
    //    [self showLoadingWithBG];
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"my/getMyInfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[NSString stringWithFormat:@"%f",appdelegate.m_currentLocation.latitude],[NSString stringWithFormat:@"%f",appdelegate.m_currentLocation.longitude]] forKeys:@[@"mobile",@"lat",@"lng"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.userInfo=req.m_data;
            [self.m_aryPhotos removeAllObjects];
            [self.m_aryPhotos addObjectsFromArray:[self.userInfo objectForKey:@"imgurls"]];
            [self.m_tableView reloadData];
            if (self.photoShowing==YES)
            {
                [self.deleteView removeFromSuperview];
                [self.imagePlayerView removeFromSuperview];
                self.imagePlayerView=nil;
                [self.screenBlackBG removeFromSuperview];
                self.screenBlackBG=nil;
                self.photoShowing=NO;
                if(self.m_aryPhotos.count>0)
                {
                    [self creatPageScrollview];
                }
            }
            //from edit info vc
            if (self.editInfoVCDelegate)
            {
                [self.editInfoVCDelegate.coachData setObject:[req.m_data objectForKey:@"headimgurl"] forKey:@"headimgurl"];
            }
        }
        else
        {
            if ([req.m_data valueForKey:@"msg"])
            {
                [self showAlertViewWithTitle:nil message:[req.m_data valueForKey:@"msg"] cancelButton:@"确定" others:nil];
            }
            else
            {
                [self showNetworkError];
            }
            
        }
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        self.m_cell0=[tableView dequeueReusableCellWithIdentifier:@"MyPhotoCell0"];
        if (self.m_cell0==nil)
        {
            self.m_cell0=[[[NSBundle mainBundle] loadNibNamed:@"MyPhotoCell0" owner:nil options:nil] objectAtIndex:0];
            self.m_cell0.delegate=self;
        }
        [self.m_cell0 updateView];
        return self.m_cell0;
    }
    else
    {
        self.m_cell1=[tableView dequeueReusableCellWithIdentifier:@"MyPhotoCell1"];
        if (self.m_cell1==nil)
        {
            self.m_cell1=[[[NSBundle mainBundle] loadNibNamed:@"MyPhotoCell1" owner:nil options:nil] objectAtIndex:0];
            self.m_cell1.delegate=self;
        }
        [self.m_cell1 updateView];
        return self.m_cell1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        return 210;
    }
    else
    {
        NSArray *aryPhoto=[self.userInfo objectForKey:@"imgurls"];
        return 50+((aryPhoto.count+1)/2)*(80+20)+100*((aryPhoto.count+1)%2);
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        if ([self.m_cell0.m_aryAvatar count]>0)
        {
            WebImageViewNormal *avatar=[self.m_cell0.m_aryAvatar objectAtIndex:0];
            [self showScreenViewForAvatar:avatar.image];
        }
    }
    else if (indexPath.row==1)
    {
        if (self.m_aryPhotos.count>0)
        {
            [self creatPageScrollview];
        }
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark --------- event response ------------
-(void)showScreenViewForAvatar:(UIImage *)img
{
    if (self.screenBlackBG)
    {
        [self.screenBlackBG removeFromSuperview];
        self.screenBlackBG=nil;
        [self.bigView removeFromSuperview];
        self.bigView=nil;
    }
    
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    //bg
    self.screenBlackBG=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    [self.screenBlackBG setBackgroundColor:[UIColor blackColor]];
    [self.screenBlackBG setAlpha:1.0];
    [appdelegate.window addSubview:self.screenBlackBG];
    
    self.bigView=[[VIPhotoView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) andImage:img];
    self.bigView.autoresizingMask = (1 << 6) -1;
    [appdelegate.window addSubview:self.bigView];
    
    
    UIButton *btnRemoveSexView=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnRemoveSexView setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    [btnRemoveSexView addTarget:self action:@selector(removeSexBG) forControlEvents:UIControlEventTouchUpInside];
    [self.bigView addSubview:btnRemoveSexView];
}
-(void)removeSexBG
{
    [self.screenBlackBG removeFromSuperview];
    self.screenBlackBG=nil;
    [self.bigView removeFromSuperview];
    self.bigView=nil;
}
-(void)creatPageScrollview
{
    self.photoShowing=YES;
    self.imagePlayerView=[[ImagePlayerView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    if (self.screenBlackBG)
    {
        [self.screenBlackBG removeFromSuperview];
        self.screenBlackBG=nil;
    }
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    //bg
    self.screenBlackBG=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    [self.screenBlackBG setBackgroundColor:[UIColor blackColor]];
    [self.screenBlackBG setAlpha:1.0];
    [appdelegate.window addSubview:self.screenBlackBG];
    [self.screenBlackBG addSubview:self.imagePlayerView];
    [self.deleteView setFrame:CGRectMake(Screen_Width-PARENT_WIDTH(self.deleteView), 20, PARENT_WIDTH(self.deleteView), PARENT_HEIGHT(self.deleteView))];
    [self.screenBlackBG addSubview:self.deleteView];
    
    self.imagePlayerView.tag=0;
    [self.imagePlayerView initWithCount:self.m_aryPhotos.count delegate:self];
    self.imagePlayerView.scrollInterval = 999.0f;
    self.imagePlayerView.autoScroll=NO;
    // adjust pageControl position
    self.imagePlayerView.pageControlPosition = ICPageControlPosition_BottomCenter;
    
    // hide pageControl or not
    self.imagePlayerView.hidePageControl = NO;
}
#pragma mark ------------- image player delegate
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(WebImageViewNormal *)imageView index:(NSInteger)index
{
    //    [imageView setWebImageViewWithURL:[NSURL URLWithString:[self.m_aryPhotos objectAtIndex:index]]];
    WebImageViewNormal *webimg=[[WebImageViewNormal alloc] initWithFrame:CGRectMake(0, (Screen_Height-210)/2.0, 320, 210)];
    [webimg setWebImageViewWithURL:[NSURL URLWithString:[self.m_aryPhotos objectAtIndex:index]]];
    [imageView addSubview:webimg];
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    NSLog(@"did tap index = %d", (int)index);
    [self.deleteView removeFromSuperview];
    [self.imagePlayerView removeFromSuperview];
    self.imagePlayerView=nil;
    [self.screenBlackBG removeFromSuperview];
    self.screenBlackBG=nil;
    self.photoShowing=NO;
}
-(IBAction)deletePhotoBtnPressed:(id)sender
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"my/delMyImg.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[self.m_aryPhotos objectAtIndex:self.imagePlayerView.pageControl.currentPage]] forKeys:@[@"mobile",@"imgurl"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            //                                  self.haveUploadAvatar=YES;
            [self showMessage:@"删除成功！"];
            [self getUserInfo];
        }
        else
        {
            if ([req.m_data valueForKey:@"msg"])
            {
                [self showAlertViewWithTitle:nil message:[req.m_data valueForKey:@"msg"] cancelButton:@"确定" others:nil];
            }
            else
            {
                [self showNetworkError];
            }
            
        }
        
    }];

}

#pragma mark ------------ avatar and photo update --------------
-(void)updateAvart
{
    self.updateType=0;
    [self creatActionSheet];
}
-(void)updatePhoto
{
    self.updateType=1;
    [self creatActionSheet];
}
-(void)creatActionSheet
{
    self.m_actionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册", nil];
    [self.m_actionSheet showInView:self.view];
}
#pragma mark ------ actionsheet delegate --------------
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        self.cameraOrAlbum=0;
        [self showPickVC:0];
    }
    else if (buttonIndex==1)
    {
        self.cameraOrAlbum=1;
        [self showPickVC:1];
    }
}
-(void)showPickVC:(NSInteger)source//0:camera 1:album
{
    self.picker=nil;
    self.picker = [[UIImagePickerController alloc]init];
    picker.view.backgroundColor = [UIColor orangeColor];
    UIImagePickerControllerSourceType sourcheType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    if (source==0)
    {
        sourcheType = UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        sourcheType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    picker.sourceType = sourcheType;
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    
    [self presentViewController:picker animated:YES completion:^{
        [self stopLoadingWithBG];
        self.editProgress=1;
    }];
    
}
#pragma mark ------ uiimagepickercontroller delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSData *dataimg=nil;
    if (self.updateType==1)//photo
    {
        UIImage* img = [info objectForKey:UIImagePickerControllerEditedImage];
        UIImageView *imgView=[[UIImageView alloc] initWithImage:img];
        float widthSP=PARENT_WIDTH(imgView)/320.0;
        UIImage *img2=[MyFounctions getSubImage:CGRectMake(0, 54*widthSP, Screen_Width*widthSP, (320-108)*widthSP) souce:imgView.image];
        dataimg = UIImageJPEGRepresentation(img2, 0.4);
    }
    else if (self.updateType==0)//avatar
    {
        UIImage* img = [info objectForKey:UIImagePickerControllerEditedImage];
        UIImageView *imgView=[[UIImageView alloc] initWithImage:[self image:img byScalingToSize:CGSizeMake(150, 150)]];
        [imgView setFrame:CGRectMake(0, 0, 150, 150)];
        dataimg = UIImageJPEGRepresentation(imgView.image, 1);
    }
    
    
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"token/getQnUptoken.yo";
    [req setParams:@[self.updateType==0?@"U1000":@"U1001",[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"type",@"account"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            //upload image
            NSString *token = [req.m_data objectForKey:@"uptoken"];
            NSString *fname=[NSString stringWithFormat:@"%@.jpg",[req.m_data objectForKey:@"fname"]];
            QNUploadManager *upManager = [[QNUploadManager alloc] init];
            [upManager putData:dataimg key:fname token:token
                      complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                          NSLog(@"info :%@", info);
                          NSLog(@"resp :%@", resp);
                          [self showLoadingWithBG];
                          Http *req=[[Http alloc] init];
                          req.socialMethord=@"my/putMyPhoto.yo";
                          [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],fname] forKeys:@[@"mobile",self.updateType==0?@"headimgurl":@"imgurl"]];
                          [req startWithBlock:^{
                              [self stopLoadingWithBG];
                              if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
                              {
//                                  self.haveUploadAvatar=YES;
                                  [self showMessage:@"上传成功！"];
                                  [self getUserInfo];
                              }
                              else
                              {
                                  if ([req.m_data valueForKey:@"msg"])
                                  {
                                      [self showAlertViewWithTitle:nil message:[req.m_data valueForKey:@"msg"] cancelButton:@"确定" others:nil];
                                  }
                                  else
                                  {
                                      [self showNetworkError];
                                  }
                                  
                              }
                              
                          }];
                          
                      } option:nil];
        }
        else
        {
            if ([req.m_data valueForKey:@"msg"])
            {
                [self showAlertViewWithTitle:nil message:[req.m_data valueForKey:@"msg"] cancelButton:@"确定" others:nil];
            }
            else
            {
                [self showNetworkError];
            }
            
        }
        
    }];
    
    
    self.editProgress=0;
    if ([self.editView superview])
    {
        [self.lineViewWhite0 removeFromSuperview];
        [self.lineViewWhite1 removeFromSuperview];
        [self.editView removeFromSuperview];
        [self.editView2 removeFromSuperview];
    }
    [self.picker dismissViewControllerAnimated:YES completion:^{
    }];
}
//图片尺寸
- (UIImage *)image:(UIImage*)image byScalingToSize:(CGSize)targetSize {
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width  = targetSize.width;
    thumbnailRect.size.height = targetSize.height;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage ;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    self.editProgress=0;
    if ([self.editView superview])
    {
        [self.lineViewWhite0 removeFromSuperview];
        [self.lineViewWhite1 removeFromSuperview];
        [self.editView removeFromSuperview];
        [self.editView2 removeFromSuperview];
    }
    [self.picker dismissViewControllerAnimated:YES completion:^{
    }];
}
#pragma mark -------- navigation delegate ---------
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.updateType==1&&self.cameraOrAlbum==1)//photo album
    {
        if ([self.editView superview])
        {
            [self.lineViewWhite0 removeFromSuperview];
            [self.lineViewWhite1 removeFromSuperview];
            [self.editView removeFromSuperview];
            [self.editView2 removeFromSuperview];
            return;
        }
        if (self.editProgress>0)
        {
            self.editProgress++;
        }
        if (self.editProgress>1)
        {
            [self.editView setFrame:CGRectMake(0, 0, Screen_Width, (Screen_Height-320)/2.0+54)];
            self.lineViewWhite0=[[UIView alloc] initWithFrame:CGRectMake(0, PARENT_HEIGHT(self.editView)-1, Screen_Width, 1)];
            [lineViewWhite0 setBackgroundColor:[UIColor whiteColor]];
            [self.editView addSubview:lineViewWhite0];
            
            [self.editView2 setFrame:CGRectMake(0, (Screen_Height-320)/2.0+320-54, Screen_Width, (Screen_Height-320)/2.0+54-60)];
            self.lineViewWhite1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 1)];
            [lineViewWhite1 setBackgroundColor:[UIColor whiteColor]];
            [self.editView2 addSubview:lineViewWhite1];
            [viewController.view addSubview:self.editView];
            [viewController.view addSubview:self.editView2];
        }

    }
    else if (self.updateType==1&&self.cameraOrAlbum==0)//photo camera
    {
        if ([self.editView superview])
        {
            [self.lineViewWhite0 removeFromSuperview];
            [self.lineViewWhite1 removeFromSuperview];
            [self.editView removeFromSuperview];
            [self.editView2 removeFromSuperview];
            return;
        }
        float shieldHeight=Screen_Height/2.0-70-107;
        [self.editView setFrame:CGRectMake(0, 68, Screen_Width, shieldHeight-40)];
        self.lineViewWhite0=[[UIView alloc] initWithFrame:CGRectMake(0, PARENT_HEIGHT(self.editView)-1, Screen_Width, 1)];
        [lineViewWhite0 setBackgroundColor:[UIColor whiteColor]];
        [self.editView addSubview:lineViewWhite0];
        
        [self.editView2 setFrame:CGRectMake(0, (Screen_Height)/2.0+107-40, Screen_Width, shieldHeight+40)];
        self.lineViewWhite1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 1)];
        [lineViewWhite1 setBackgroundColor:[UIColor whiteColor]];
        [self.editView2 addSubview:lineViewWhite1];
        
        AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
        [appdelegate.window addSubview:self.editView];
        [appdelegate.window addSubview:self.editView2];
//        [viewController.view addSubview:self.editView];
//        [viewController.view addSubview:self.editView2];
    }
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
