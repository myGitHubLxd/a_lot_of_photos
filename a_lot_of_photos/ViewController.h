//
//  ViewController.h
//  a_lot_of_photos
//
//  Created by raysharp on 5/27/14.
//  Copyright (c) 2014 raysharp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myPhoto.h"

static        int global;

struct Node
{
    int   num;
    struct Node *next;
};

@interface ViewController : UIViewController<UIScrollViewDelegate>
{
    UIView         *photoView;
    UIScrollView   *scrollview;
    
    NSMutableArray *photos;
    int             rowtop;//显示的view中第一行
    int             rowbottom;//显示的view中最后一行
    int             row;//总行数
    int             col;//总列数
    
    float           imgWidth;
    float           imgHeight;
    NSMutableArray *showImgArr;//显示的view的数组
    float           currOffset;//当前偏移量。
}
@end
