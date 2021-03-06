//
//  UMComCommentMenuViewController.m
//  UMCommunity
//
//  Created by umeng on 15/12/23.
//  Copyright © 2015年 Umeng. All rights reserved.
//

#import "UMComCommentMenuViewController.h"
#import "UMComHorizonCollectionView.h"
#import "UMComCommentTableViewController.h"
#import "UMComPullRequest.h"
#import "UMComSession.h"
#import "UMComUnReadNoticeModel.h"
#import "UIViewController+UMComAddition.h"

@interface UMComCommentMenuViewController ()<UMComHorizonCollectionViewDelegate>

@property (nonatomic, strong) UMComHorizonCollectionView *menuView;

@end

@implementation UMComCommentMenuViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createSubControllers];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    if (!self.menuView) {
        UMComHorizonCollectionView *menuView = [[UMComHorizonCollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40) itemCount:2];
        menuView.cellDelegate = self;
        menuView.itemSpace = 0;
        menuView.indicatorLineHeight = 5;
        menuView.scrollIndicatorView.image = UMComImageWithImageName(@"selected");
        [self.view addSubview:menuView];
        self.menuView = menuView;
        [self.view bringSubviewToFront:self.menuView];
    }
}

#pragma mark - UMComHorizonCollectionViewDelegate
- (void)horizonCollectionView:(UMComHorizonCollectionView *)collectionView reloadCell:(UMComHorizonCollectionCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        cell.label.text = UMComLocalizedString(@"Receive_Comment", @"收到的评论");
    }else{
        cell.label.text = UMComLocalizedString(@"Send_Comment", @"发出的评论");
    }
    cell.label.highlightedTextColor = UMComColorWithColorValueString(FontColorBlue);
    cell.label.backgroundColor = UMComColorWithColorValueString(LightGrayColor);
}

- (void)horizonCollectionView:(UMComHorizonCollectionView *)collectionView didSelectedColumn:(NSInteger)column
{
    [self transitionFromIndex:collectionView.previewsIndex toIndex:column];
}

- (void)createSubControllers
{
    CGRect commonFrame = self.view.frame;
    commonFrame.origin.y = 40;
    commonFrame.size.height = commonFrame.size.height - commonFrame.origin.y;
    CGFloat centerY = commonFrame.size.height/2+commonFrame.origin.y;
    UMComCommentTableViewController *hotPostListController = [[UMComCommentTableViewController alloc] initWithFetchRequest:[[UMComUserCommentsReceivedRequest alloc] initWithCount:BatchSize]];
    [self addChildViewController:hotPostListController];
    [self.view addSubview:hotPostListController.view];
    hotPostListController.view.frame = commonFrame;
    
    UMComCommentTableViewController *recommendPostListController = [[UMComCommentTableViewController alloc] initWithFetchRequest:[[UMComUserCommentsSentRequest alloc]initWithCount:BatchSize]];
    [self addChildViewController:recommendPostListController];
    recommendPostListController.view.frame = commonFrame;
    recommendPostListController.view.center = CGPointMake(commonFrame.size.width * 3 / 2, centerY);
    [self transitionFromIndex:0 toIndex:0];
}

- (void)transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
    UMComRequestTableViewController *requestTableVc = self.childViewControllers[toIndex];
    if (requestTableVc.dataArray.count == 0 && requestTableVc.isLoadFinish) {
        [requestTableVc loadAllData:nil fromServer:^(NSArray *data, BOOL haveNextPage, NSError *error) {
            if (toIndex == 0) {
                [UMComSession sharedInstance].unReadNoticeModel.notiByCommentCount = 0;
            }
        }];
    }
    [self transitionFromViewControllerAtIndex:fromIndex toViewControllerAtIndex:toIndex animations:nil completion:nil];
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
