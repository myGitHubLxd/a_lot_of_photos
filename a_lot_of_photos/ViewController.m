//
//  ViewController.m
//  a_lot_of_photos
//
//  Created by raysharp on 5/27/14.
//  Copyright (c) 2014 raysharp. All rights reserved.
//

#import "ViewController.h"
#import "MyButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    photoView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height - 120)];
    [self.view addSubview:photoView];
    
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(photoView.frame.origin.x, photoView.frame.origin.y, photoView.frame.size.width, photoView.frame.size.height)];
    scrollview.backgroundColor = [UIColor blackColor];
    scrollview.delegate = self;
    scrollview.showsVerticalScrollIndicator = NO;
    scrollview.showsHorizontalScrollIndicator = NO;
    [photoView addSubview:scrollview];
    
    [self createPhotos];
    
    UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(60, 60, 60, 40)];
    [bt setBackgroundColor:[UIColor greenColor]];
    [bt addTarget:self action:@selector(bt_Click:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 60, 30)];
    la.text = @"ashj";
    la.textColor = [UIColor blackColor];
    [bt addSubview:la];
    [self.view addSubview:bt];
    
    global = 0;
    
    UIButton *bt2 = [UIButton buttonWithType:UIButtonTypeCustom];
    bt2.frame = CGRectMake(200, 60, 60, 40);
    [bt2 addTarget:self action:@selector(bt_Click2:) forControlEvents:UIControlEventTouchUpInside];
    bt2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:bt2];
    
    float cc = 89.7857567;
    NSLog(@"*****%0.2f****",cc);
    NSLog(@"*****numbers:%d********",[self numbersOfnum:20120101 :2]);
    
    struct Node *node1 = malloc(sizeof(struct Node));
    node1->num = 12;
    struct Node *node11 = malloc(sizeof(struct Node));
    node11->num = 121;node1->next = node11;
    struct Node *node111 = malloc(sizeof(struct Node));
    node111->num = 1211;node11->next = node111;
    //node111->next = NULL;
    struct Node *node3 = malloc(sizeof(struct Node));
    node3->num = 67895;node111->next = node3;
    node3->next = NULL;
    
    struct Node *node2 = malloc(sizeof(struct Node));
    node2->num = 22;
    struct Node *node21 = malloc(sizeof(struct Node));
    node21->num = 221;node2->next = node21;
    struct Node *node221 = malloc(sizeof(struct Node));
    node221->num = 2211;node21->next = node221;
    //node221->next = NULL;
    node221->next = node3;
    
    NSLog(@"******%d***********",isIntersert(node1, node2));
    NSArray *arr = [NSBundle allBundles];
    NSDictionary *dic = [[NSBundle mainBundle] infoDictionary];
    NSString *str = [[NSBundle mainBundle] bundlePath];
    NSString *path = [[NSBundle mainBundle] resourcePath];
    NSURL *url = [[NSBundle mainBundle] bundleURL];
    [NSUserDefaults standardUserDefaults];
    
    NSString *imgpath = [[NSBundle mainBundle] pathForResource:@"xx" ofType:@".xcassets"];
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"a_lot_of_photos-Info" ofType:@".plist"];
    
    //NSString *imgpath2 = [[NSBundle mainBundle] pathForResource:@"resourceName" oftype:@"resourceType"];
    UIImage *image = [UIImage imageWithContentsOfFile:imgpath];
    NSString *sss = [[NSBundle mainBundle] pathForResource:@"Base" ofType:@".lproj"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)bt_Click2:(UIButton*)sender
{
    for(UIView *bt in scrollview.subviews)
    {
        [bt removeFromSuperview];
    }
    [scrollview setContentSize:CGSizeMake(scrollview.frame.size.width, scrollview.frame.size.height)];
    NSLog(@"*****subs count:%d********",scrollview.subviews.count);
}
-(void)bt_Click:(UIButton*)sender
{
    //[self ShowFiles];
    
    imgWidth = 63;
    imgHeight = 52;
    col = photoView.frame.size.width / imgWidth;
    row = (int)(photos.count / col);
    if(photos.count%col > 0)
    {
        row++;
    }
    [scrollview setContentSize:CGSizeMake(scrollview.frame.size.width, (imgHeight + 10)*(row + 1))];
    NSLog(@"******x:%f,y:%f************",scrollview.contentSize.width,scrollview.contentSize.height);
    currOffset = 0.0;
    
    if(!showImgArr)
    {
        showImgArr = [[NSMutableArray alloc] init];
    }
    [showImgArr removeAllObjects];
    
    if((imgHeight + 10)*row <= scrollview.frame.size.height)//所有图片在一页就能显示完
    {
        rowtop = 1;
        rowbottom = row;
        for(int i=0;i<row;i++)
        {
            [self loadOneRow:(i+1)];
        }
    }
    else
    {
        rowtop = 1;
        float temprow = scrollview.frame.size.height/(imgHeight + 10);
//        if(temprow*(imgHeight + 10) < scrollview.frame.size.height)//不能正好显示完整一行
//        {
//            rowbottom = temprow + 1;
//        }
//        if(temprow*(imgHeight + 10) == scrollview.frame.size.height)//正好显示完整一行
//        {
//            rowbottom = temprow;
//        }
        rowbottom = [self getRow:temprow];
        for(int j=0;j<rowbottom;j++)
        {
            [self loadOneRow:(j+1)];
        }
    }
}
-(void)createPhotos
{
    if(!photos)
    {
        photos = [[NSMutableArray alloc] init];
    }
    [photos removeAllObjects];
    
    for(int i=0;i<167;i++)
    {
        myPhoto *obj = [[myPhoto alloc] init];
        obj.name = [NSString stringWithFormat:@"%@%d",@"HSL_",(i+1)];
        obj.imagename = @"xx";
        [photos addObject:obj];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    global++;
    if(scrollView != scrollview)
        return;
    if(scrollview.contentOffset.y <= 0)
        return;

    int addcounts,removecounts;
    if(scrollview.contentOffset.y > currOffset)//向上滑
    {
        currOffset = scrollview.contentOffset.y;
        float rowbottomtemp = (scrollview.contentOffset.y + scrollview.frame.size.height) / (imgHeight + 10);
        int rowbottonwill = [self getRow:rowbottomtemp];
        addcounts = rowbottonwill - rowbottom;//addcounts表示将要新添加的行数
        
        for(int i=0;i<addcounts;i++)
        {
            if((rowbottom + 1) > row)
            {
                break;
            }
            
            MyButton *topbutton = [showImgArr firstObject];
            [self loadOneRow:(rowbottom + 1)];
            //NSLog(@"******after add count:%d*********",scrollview.subviews.count);
            rowbottom++;
            if(scrollview.contentOffset.y > (topbutton.frame.origin.y + topbutton.frame.size.height))//如果最前面一行的底部的位置小于偏移量，则说明要移出去
            {
                [self removeOneRow:rowtop];
                //NSLog(@"******after remove count:%d*********",scrollview.subviews.count);
                rowtop++;
            }
        }
        
        float rowtoptemp = scrollview.contentOffset.y / (imgHeight  + 10);
        int rowtopwill = [self getRow:rowtoptemp];
        removecounts = rowtopwill - rowtop;
        if(removecounts > 0)//removecounts=0或者1或者-1
        {
            [self removeOneRow:rowtop];
            rowtop++;
        }
        NSLog(@"*****rowbottom:%d,rowtop:%d,count:%d,removecounts:%d***************",rowbottom,rowtop,scrollview.subviews.count,removecounts);
    }
    else if(scrollview.contentOffset.y < currOffset)//向下滑
    {
        currOffset = scrollview.contentOffset.y;
        float rowtoptemp = scrollview.contentOffset.y / (imgHeight + 10);
        int rowtopwill = [self getRow:rowtoptemp];
        addcounts = rowtop - rowtopwill;//将要新添加的行数
        MyButton *templastbt;// = [showImgArr lastObject];
        
        for(int j=0;j<addcounts;j++)
        {
            templastbt = (MyButton*)[scrollView viewWithTag:(1000 + col*(rowbottom - 1) + 1)];//最后一行第一个
            [self loadOneRow:(rowtop - 1)];
            rowtop--;
            if((scrollView.contentOffset.y + scrollView.frame.size.height) < (templastbt.frame.origin.y ))//+ templastbt.frame.size.height
            {
                [self removeOneRow:rowbottom];
                rowbottom--;
            }
        }
        
        float rowbottomtemp = (scrollview.contentOffset.y + scrollview.frame.size.height) / (imgHeight + 10);
        int rowbottomwill = [self getRow:rowbottomtemp];
        removecounts = rowbottom - rowbottomwill;
        if(removecounts > 0)
        {
            [self removeOneRow:rowbottom];
            rowbottom--;
        }
        NSLog(@"*****down rowbottom:%d,rowtop:%d,count:%d,removecounts:%d***************",rowbottom,rowtop,scrollview.subviews.count,removecounts);
    }
    else
    {
        
    }
}
-(int)getRow:(float)willrow
{
    int resultRow = (int)willrow;
    if(willrow > resultRow)
    {
        return resultRow += 1;
    }
    else
        return resultRow;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}
-(void)loadOneRow:(int)irow//irow表示第几行，从1开始
{
    float offset = (irow-1)*(imgHeight + 10);
    int index;
    for(int j=0;j<col;j++)
    {
        if(((irow-1)*col+(j+1)) > photos.count)//if(((irow-1)*col+(j+1)) == (photos.count + 1))
            break;
        index = (irow - 1)*col + (j + 1);
        [self loadOneImage:offset :j :index];
    }
}
-(void)removeOneRow:(int)irow
{
    for(int j=0;j<col;j++)
    {
        int index = (irow - 1)*col + (j + 1);
        //NSArray *array = [scrollview subviews];
        
        UIView *tempview = [scrollview viewWithTag:(1000 + index)];
        [tempview removeFromSuperview];
        [showImgArr removeObject:tempview];
//        for(int i=0;i<array.count;i++)
//        {
//            UIView *view = [array objectAtIndex:i];
//            if(view.tag == (1000 + index))
//            {
//                [view removeFromSuperview];
//                NSLog(@"********%s,count:%d************",__func__,scrollview.subviews.count);
//                if([imgViewArr containsObject:view])
//                    [imgViewArr removeObject:view];
//                break;
//            }
//        }
    }
    
}
-(void)loadOneImage:(float)offset :(int)indexOfCol :(int)indexOfPhotos//offset表示偏移量；indexOfCol第几列，从0开始；indexOfPhotos表示第几张图片，从1开始
{
    NSLog(@"**************************indexOfPhotos:%d****************************",indexOfPhotos);
    CGRect rect = CGRectMake(indexOfCol*imgWidth, offset, imgWidth, imgHeight);
    MyButton *bt = [[MyButton alloc] initWithFrame:rect];
    bt.tag = 1000 + indexOfPhotos;
    [bt.layer setMasksToBounds:YES];
    //[bt.layer setBorderWidth:5.0];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    [bt.layer setBorderColor:CGColorCreate(colorSpace,(CGFloat[]){1.0f, 1.0f, 1.0f, 1.0f})];
    [bt setBackgroundColor:[UIColor lightGrayColor]];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bt.frame.size.width, bt.frame.size.height - 10)];
    image.image = [UIImage imageNamed:((myPhoto*)[photos objectAtIndex:(indexOfPhotos - 1)]).imagename];
    [bt addSubview:image];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, image.frame.size.height, imgWidth, 10)];//CGRectMake(indexOfCol*imgWidth, rect.origin.y+rect.size.height, imgWidth, 10)
    label.tag = 1000 + indexOfPhotos;
    label.font = [UIFont fontWithName:@"Helvetica" size:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = ((myPhoto*)[photos objectAtIndex:(indexOfPhotos - 1)]).name;
    [showImgArr addObject:bt];
    [scrollview addSubview:bt];
    [bt addSubview:label];
}
-(void)ShowFiles
{
    int width = 80;
    int height = 80;
    int col = photoView.frame.size.width / (width + 10);
    float instance = ((photoView.frame.size.width - (width+10)*col + 10))/2;
    int krow = 0;
    int kcol = 0;
    NSArray *views = [scrollview subviews];
    for(UIView  *view in views)
    {
        [view removeFromSuperview];
    }
    for(myPhoto *obj in photos)//files
    {
        CGRect rect = CGRectMake(instance+(width+10)*kcol, 20+(height+20+20)*krow, width, height);
        MyButton *bt = [[MyButton alloc] initWithFrame:rect];
        [bt.layer setMasksToBounds:YES];
        [bt.layer setBorderWidth:5.0];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        [bt.layer setBorderColor:CGColorCreate(colorSpace,(CGFloat[]){1.0f, 1.0f, 1.0f, 1.0f})];//white color
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(instance+(width+10)*kcol, 20+(height+20+20)*krow + height, width, 10)];
        label.text = obj.name;
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        image.image = [UIImage imageNamed:obj.imagename];
        [bt addSubview:image];
        label.font = [UIFont fontWithName:@"Helvetica" size:12];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        //[bt addTarget:self action:@selector(ImageClick:) forControlEvents:UIControlEventTouchUpInside];
        bt.name = obj.name;
        [scrollview addSubview:bt];//videoView
        [scrollview addSubview:label];
        kcol++;
        if(kcol >= col)
        {
            krow++;
            kcol = 0;
        }
    }
    scrollview.contentSize = CGSizeMake(self.view.frame.size.width, 120.0*(krow+1));
}

-(int)numbersOfnum:(long)number :(int)n//number为10进制下的数字，n为转为多少进制
{
    int result = 0;
    int remainder;
    do
    {
        remainder = number % n;
        number = number / n;
        result++;
    }while(number);
    return result;
}
bool isIntersert(struct Node *list1,struct Node *list2)//判断两个链表是否相交 如果它们相交，则最后一个结点一定是共有的，则只需要判断最后一个结点是否相同即可。时间复杂度为O(len1+len2)。
{
    struct Node *node1;
    struct Node *node2;
    if(list1)
    {
        node1 = list1->next;
    }
    while(node1 && (NULL != (node1->next)))
    {
        node1 = node1->next;
    }
    
    if(list2)
    {
        node2 = list2->next;
    }
    while(node2 && (NULL != (node2->next)))
    {
        node2 = node2->next;
    }
    if((node1 == node2) && (NULL != node1))
        return true;
    else
        return false;
}
@end
