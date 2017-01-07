//
//  RefuseOrderCell.m
//  yojiaolian
//
//  Created by carcool on 10/22/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "RefuseOrderCell.h"

@implementation RefuseOrderCell

- (void)awakeFromNib {
    // Initialization code
    [self setBackgroundColor:[UIColor clearColor]];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.textViewContent.delegate=self;
    self.textViewContent.returnKeyType=UIReturnKeyDone;
    self.m_aryShowed=[NSMutableArray array];
    self.m_aryImgs=[NSMutableArray array];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)updateView
{
    NSInteger i=0;
    for (NSDictionary *dic in self.m_aryData)
    {
        UIImageView *selectImg=[[UIImageView alloc] initWithFrame:CGRectMake(15, 165+i*26, 16, 16)];
        [selectImg setImage:[UIImage imageNamed:@"select_off"]];
        [self.m_aryImgs addObject:selectImg];
        [self.m_aryShowed addObject:@"0"];
        UILabel *labelReason=[[UILabel alloc] initWithFrame:CGRectMake(40, 165+i*26, 280, 16)];
        [labelReason setTextColor:[UIColor darkGrayColor]];
        [labelReason setFont:[UIFont systemFontOfSize:14.0]];
        labelReason.text=[dic objectForKey:@"content"];
        UIButton *btnSelect=[UIButton buttonWithType:UIButtonTypeCustom];
        [btnSelect setFrame:CGRectMake(0, 165+i*26, Screen_Width, 16)];
        btnSelect.tag=i;
        [btnSelect addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:selectImg];
        [self addSubview:labelReason];
        [self addSubview:btnSelect];
        i++;
    }
}
-(void)selectItem:(id)sender
{
    UIButton *btnRefuse=(UIButton*)sender;
    if ([[self.m_aryShowed objectAtIndex:btnRefuse.tag] integerValue]==0)
    {
        UIImageView *img=[self.m_aryImgs objectAtIndex:btnRefuse.tag];
        [img setImage:[UIImage imageNamed:@"select_on"]];
        [self.m_aryShowed replaceObjectAtIndex:btnRefuse.tag withObject:@"1"];
    }
    else
    {
        UIImageView *img=[self.m_aryImgs objectAtIndex:btnRefuse.tag];
        [img setImage:[UIImage imageNamed:@"select_off"]];
        [self.m_aryShowed replaceObjectAtIndex:btnRefuse.tag withObject:@"0"];
    }
}
#pragma mark ---------------  textview delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    { //判断输入的字是否是回车，即按下return
        
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        if ([self.textViewContent.text isEqualToString:@""])
        {
            self.labelContentDefault.hidden=NO;
            self.textViewContent.text=@"";
        }
        else
        {
            self.labelContentDefault.hidden=YES;
        }
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}

-(IBAction)contentBtnPressed:(id)sender
{
    if (![self.textViewContent isFirstResponder])
    {
        [self.textViewContent becomeFirstResponder];
        self.labelContentDefault.hidden=YES;
    }
    else
    {
        [self.textViewContent resignFirstResponder];
        if ([self.textViewContent.text isEqualToString:@""])
        {
            self.labelContentDefault.hidden=NO;
        }
        else
        {
            self.labelContentDefault.hidden=YES;
        }
    }
}


@end
