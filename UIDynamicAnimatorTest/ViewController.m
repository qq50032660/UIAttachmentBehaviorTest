//
//  ViewController.m
//  UIDynamicAnimatorTest
//
//  Created by fyc on 16/9/2.
//  Copyright © 2016年 FuYaChen. All rights reserved.
//

#import "ViewController.h"
#import "ballCollision.h"
@interface ViewController ()
{
    UIView *aView;
    UIView *view ;
}
@property (nonatomic, retain)UIDynamicAnimator *animator;
@property (nonatomic, retain)UIAttachmentBehavior *attachBe;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    aView = [[UIView alloc] initWithFrame:CGRectMake(100, 50, 100, 100)];
    aView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:aView];
    
    view = [[UIView alloc]initWithFrame:CGRectMake(220, 50, 100, 100)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(taps:)];
    [view addGestureRecognizer:tap];
    
    
    /*
    //模仿重力下落
    UIDynamicAnimator *dynamic = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    UIGravityBehavior *gravityBeahvior = [[UIGravityBehavior alloc]initWithItems:@[aView]];
    [dynamic addBehavior:gravityBeahvior];
    
    self.animator = dynamic;
     */
    /*
    //模仿重力下落到地上 边界可以自己设置
    UIDynamicAnimator *dynamic = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    UIGravityBehavior *dravity = [[UIGravityBehavior alloc]initWithItems:@[aView]];
    [dynamic addBehavior:dravity];
     
     aView.transform = CGAffineTransformRotate(aView.transform, 45);
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc]initWithItems:@[aView]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [dynamic addBehavior:collision];
    collision.collisionDelegate = self;
    
    self.animator = dynamic;
    */
    NSLog(@"sadasdssd");
    UIDynamicAnimator *dynamic = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    UICollisionBehavior *collsionBehavior = [[UICollisionBehavior alloc]initWithItems:@[aView]];
    collsionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [dynamic addBehavior:collsionBehavior];
    
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc]initWithItems:@[aView]];
    [dynamic addBehavior:gravity];
    
    self.animator = dynamic;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pansLet:)];
    [aView addGestureRecognizer:pan];
    
    
    
}
- (void)taps:(UITapGestureRecognizer *)tap{
    ballCollision *vc = [[ballCollision alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)pansLet:(UIPanGestureRecognizer *)pan{
    if (pan.state == UIGestureRecognizerStateBegan) {
        UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc]initWithItem:aView attachedToAnchor:CGPointMake(aView.center.x, aView.center.y - 50)];

        //UIAttachmentBehaviorTypeAnchor类型的依赖行为的锚点，锚点与行为相关的动力动画的坐标系统有关。
//        attachment.anchorPoint = CGPointMake(100, 100);
        //描述吸附行为减弱的阻力大小
//        attachment.damping = 0.2;
        //吸附行为震荡的频率
//        attachment.frequency = 1;
        //吸附行为中的两个吸附点之间的距离，通常用这个属性来调整吸附的长度，可以创建吸附行为之后调用。系统基于你创建吸附行为的方法来自动初始化这个长度   length
        //与吸附行为相连的动态项目，当吸附行为类型是UIAttachmentBehaviorTypeItems时有2个元素，当吸附行为类型是UIAttachmentBehaviorTypeAnchor时只有一个元素。  items
        
        /*
        initWithItem:attachedToAnchor:
            初始化连接动力item的中心和锚点的吸附行为
            - (instancetype)initWithItem:(id<UIDynamicItem>)item attachedToAnchor:(CGPoint)point
            参数：item是你要应用吸附行为的动力项，point是吸附行为的锚点，与跟行为相关的动态动画所在在系统坐标有关。
            返回：初始化的attachment behavior,如果初始化过程出错将会返回nil。
            该初始化方法的吸附行为的类型是UIAttachmentBehaviorTypeAnchor
        initWithItem:attachedToItem:
            初始化连接两个动力项中心的吸附行为
            - (instancetype)initWithItem:(id<UIDynamicItem>)item1 attachedToItem:(id<UIDynamicItem>)item2
            参数：item1第一个被吸附行为连接的动力项，item2第二个被吸附行为连接的动力项
            返回：初始化的attachment behavior,如果初始化过程出错将会返回nil。
            该初始化方法的吸附行为的类型是UIAttachmentBehaviorTypeItems
        initWithItem:offsetFromCenter:attachedToAnchor:
            初始化连接动力项中某一点和锚点的吸附行为
            - (instancetype)initWithItem:(id<UIDynamicItem>)item offsetFromCenter:(UIOffset)p1 attachedToAnchor:(CGPoint)point
            参数：item要应用吸附行为的动力项，p1相对于item中心的偏移，point是吸附行为的锚点，与跟行为相关的动力动画所在在系统坐标有关。
            返回：初始化的attachment behavior,如果初始化过程出错将会返回nil。
            该初始化方法的吸附行为的类型是UIAttachmentBehaviorTypeAnchor
        initWithItem:offsetFromCenter:attachedToItem:offsetFromCenter:
            初始化连接一个动力item中某一点和另一个动力item中某一点的吸附行为
            - (instancetype)initWithItem:(id<UIDynamicItem>)item1 offsetFromCenter:(UIOffset)p1 attachedToItem:(id<UIDynamicItem>)item2 offsetFromCenter:(UIOffset)p2
            参数：item1第一个被吸附行为连接的动力项，p1相对于item1中心的偏移，item2第二个被吸附行为连接的动力项，p2相对于item2中心的偏移
            返回：返回：初始化的attachment behavior,如果初始化过程出错将会返回nil。
            这是为UIAttachmentBehavior类指定的初始化程序。
         
         */
        
        self.attachBe = attachment;
        [self.animator addBehavior:attachment];
    }else if (pan.state == UIGestureRecognizerStateChanged){
        [self.attachBe setAnchorPoint:[pan locationInView:self.view]];
    }else if(pan.state == UIGestureRecognizerStateEnded){
        [self.animator removeBehavior:self.attachBe];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
