//
//  EditInfoCell0.m
//  yojiaolian
//
//  Created by carcool on 4/11/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "EditInfoCell0.h"
#import "EditInfoVC.h"
@implementation EditInfoCell0

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=[UIColor clearColor];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
    [self.lineView1 setBackgroundColor:YCC_GrayBG];
    [self.lineView2 setBackgroundColor:YCC_GrayBG];
    [self.lineView3 setBackgroundColor:YCC_GrayBG];
    [self.lineView4 setBackgroundColor:YCC_GrayBG];
    [self.lineView5 setBackgroundColor:YCC_GrayBG];
    [self.avatar setClipsToBounds:YES];
    [self.avatar.layer setCornerRadius:PARENT_WIDTH(self.avatar)/2.0];
    self.textfieldDriveYear.delegate=self;
    self.textfieldMobile.delegate=self;
    self.textfieldName.delegate=self;
    self.textfieldSpaceSite.delegate=self;
    self.textfieldDriveYear.returnKeyType=UIReturnKeyDone;
    self.textfieldMobile.returnKeyType=UIReturnKeyDone;
    self.textfieldName.returnKeyType=UIReturnKeyDone;
    self.textfieldSpaceSite.returnKeyType=UIReturnKeyDone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    float currentFrame=[textField.superview convertRect:textField.frame toView:nil].origin.y;//to window frame
    if (currentFrame>Screen_Height-KEYBOARD_HEIGHT-40)
    {
        float d_y=Screen_Height-KEYBOARD_HEIGHT-currentFrame-40;
        [self.delegate.view setFrame:CGRectMake(PARENT_X(self.delegate.view), PARENT_Y(self.delegate.view)+d_y, PARENT_WIDTH(self.delegate.view), PARENT_HEIGHT(self.delegate.view))];
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self.delegate.view setFrame:CGRectMake(PARENT_X(self.delegate.view), 0, PARENT_WIDTH(self.delegate.view), PARENT_HEIGHT(self.delegate.view))];
    
    [self.delegate saveData];
    return YES;
}
-(void)updateView
{
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString: [self.delegate.coachData objectForKey:@"headimgurl"]]];
    self.textfieldDriveYear.text=[NSString stringWithFormat:@"%d",[[self.delegate.coachData objectForKey:@"jl"] integerValue]];
    self.textfieldMobile.text=[self.delegate.coachData objectForKey:@"telephone"];
    self.textfieldName.text=[self.delegate.coachData objectForKey:@"name"];
    self.textfieldSpaceSite.text=[self.delegate.coachData objectForKey:@"spaceName"];
    if ([[self.delegate.coachData objectForKey:@"teachItem"] integerValue]==0)
    {
        [self.delegate.coachData setObject:@"1" forKey:@"teachItem"];
    }
    if ([[self.delegate.coachData objectForKey:@"teachItem"] integerValue]==1)
    {
        self.labelLicenseType.text=@"全科";
    }
    else if ([[self.delegate.coachData objectForKey:@"teachItem"] integerValue]==2)
    {
        self.labelLicenseType.text=@"科目二";
    }
    else if ([[self.delegate.coachData objectForKey:@"teachItem"] integerValue]==3)
    {
        self.labelLicenseType.text=@"科目三";
    }
    self.labelSchool.text=[self.delegate.coachData objectForKey:@"dsname"];
    self.labelSpaceLocation.text=[self.delegate.coachData objectForKey:@"spaceAddr"];
}
#pragma mark ------- event response ----------
-(IBAction)btnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    if (btn.tag==0)
    {
        [self.delegate showMyPhotoVC];
    }
}
-(IBAction)selectLicenseType:(id)sender
{
    [self.delegate creatPickerView];
}
-(IBAction)selectSchoolBtnPressed:(id)sender
{
    [self.delegate showSelectSchoolVC];
}
-(IBAction)searchSpaceSiteBtnPressed:(id)sender
{
    [self.delegate showSearchSpaceSiteVC];
}
@end
