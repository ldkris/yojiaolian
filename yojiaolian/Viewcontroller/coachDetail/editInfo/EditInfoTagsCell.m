//
//  EditInfoTagsCell.m
//  yojiaolian
//
//  Created by carcool on 4/14/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "EditInfoTagsCell.h"
#import "EditInfoVC.h"
@implementation EditInfoTagsCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=[UIColor clearColor];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.m_aryBtns=[NSMutableArray array];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self.contentBG removeFromSuperview];
    self.contentBG=nil;
    self.contentBG=[[UIView alloc] initWithFrame:CGRectMake(10, 0, 300, 40*(self.m_aryData.count/4+(self.m_aryData.count%4>0?1:0)))];
    [self.contentBG setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.contentBG];
    
    for (UIButton *btn in self.m_aryBtns)
    {
        [btn removeFromSuperview];
    }
    [self.m_aryBtns removeAllObjects];
    
    float btnWidth=(300-50)/4.0;
    NSInteger i=0;
    for (NSDictionary *dic in self.m_aryData)
    {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(10+(i%4)*(10+btnWidth), 5+(i/4)*40, btnWidth, 30)];
        [btn setClipsToBounds:YES];
        [btn.layer setCornerRadius:3.0];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        [btn setTitle:[dic objectForKey:@"name"] forState:UIControlStateNormal];
        btn.tag=[[dic objectForKey:@"tagid"] integerValue];
        if ([[dic objectForKey:@"status"] integerValue]==1)//选中
        {
            [btn setBackgroundColor:YCC_Green];
            [btn.titleLabel setTextColor:[UIColor whiteColor]];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn.layer setBorderColor:[[UIColor clearColor] CGColor]];
            [btn.layer setBorderWidth:0];
        }
        else if ([[dic objectForKey:@"status"] integerValue]==2)//未选中
        {
            [btn setBackgroundColor:[UIColor whiteColor]];
            [btn.titleLabel setTextColor:[UIColor lightGrayColor]];
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [btn.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
            [btn.layer setBorderWidth:0.5];
        }
        if (i<self.m_aryData.count-1)
        {
            [btn addTarget:self action:@selector(tagBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            [btn addTarget:self action:@selector(showAddTagVC) forControlEvents:UIControlEventTouchUpInside];
        }
        [self.contentBG addSubview:btn];
        [self.m_aryBtns addObject:btn];
        i++;
    }
}
-(IBAction)tagBtnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    NSInteger tagid=btn.tag;
    for (NSMutableDictionary *dic in self.delegate.m_aryTags)
    {
        if ([[dic objectForKey:@"tagid"] integerValue]==tagid)
        {
            if ([[dic objectForKey:@"status"] integerValue]==1)
            {
                [dic setObject:@"2" forKey:@"status"];
            }
            else
            {
                NSInteger tagsNum=0;
                for (NSDictionary *tagdata in self.delegate.m_aryTags)
                {
                    if ([[tagdata objectForKey:@"status"] integerValue]==1)
                    {
                        tagsNum++;
                    }
                }
                if (tagsNum>=6)
                {
                    [self.delegate showMessage:@"最多添加6个标签"];
                }
                else
                {
                    [dic setObject:@"1" forKey:@"status"];
                }
            }
            break;
        }
    }
    [self.delegate.m_tableView reloadData];
}
-(void)showAddTagVC
{
    [self.delegate showAddTagVC];
}
@end
