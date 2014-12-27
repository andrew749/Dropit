//
//  ViewController.m
//  Dropit
//
//  Created by Andrew Codispoti on 2014-12-27.
//  Copyright (c) 2014 Andrew Codispoti. All rights reserved.
//

#import "ViewController.h"
#import "DropitBehavious.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (strong,nonatomic)UIDynamicAnimator *animator;
@property (strong, nonatomic)DropitBehavious *dropitBehaviour;
@end

@implementation ViewController
- (IBAction)tap:(UITapGestureRecognizer *)sender {
    [self drop];
}

-(UIDynamicAnimator *)animator{
    if(!_animator){
        
        _animator=[[UIDynamicAnimator alloc] initWithReferenceView:self.gameView];
    }
    return _animator;
}
-(DropitBehavious *)dropitBehaviour{
    if (!_dropitBehaviour) {
        _dropitBehaviour=[[DropitBehavious alloc] init];
        [self.animator addBehavior:_dropitBehaviour];

    }
    return _dropitBehaviour;
}
-(void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator{
    [self removeCompletedRows];
}
-(BOOL)removeCompletedRows{
    NSMutableArray *dropsToRemove=[[NSMutableArray alloc] init];
    for(CGFloat y=self.gameView.bounds.size.height-DROP_SIZE.height/2;y>0;y-=DROP_SIZE.height){
        
        BOOL rowIsComplete=YES;
        NSMutableArray *dropsFound=[[NSMutableArray alloc]init];
        for(CGFloat x=DROP_SIZE.width/2;x<=self.gameView.bounds.size.width-DROP_SIZE.width/2;x+=DROP_SIZE.width){
            UIView *hitView=[self.gameView hitTest:CGPointMake(x, y) withEvent:NULL];
        if([hitView superview] ==self.gameView){
            [dropsFound addObject:hitView];
        }else{
            rowIsComplete=NO;
            break;
        }
        }
        if(![dropsFound count])break;
        if(rowIsComplete)[dropsToRemove addObjectsFromArray:dropsFound];
        
        
        
    }
    if([dropsToRemove count])
    {
        for(UIView *drop in dropsToRemove){
            [self.dropitBehaviour removeItem:drop];
        }
        [self animateRemovingDrops:dropsToRemove];
    }
    return NO;
    
}
-(void)animateRemovingDrops:(NSArray *)dropstoRemove{
    [UIView animateWithDuration:1.0 animations:^{
        for(UIView *drop in dropstoRemove){
            int x=(arc4random()%(int)(self.gameView.bounds.size.width*5))-(int)self.gameView.bounds.size.width*2;
            int y=self.gameView.bounds.size.height;
            drop.center=CGPointMake(x, -y);
            
        }} completion:^(BOOL finished){
            [dropstoRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
        }];
}
static const CGSize DROP_SIZE={40,40};
-(void)drop{
    CGRect frame;
    frame.origin=CGPointZero;
    frame.size=DROP_SIZE;
    int x=(arc4random()%(int)self.gameView.bounds.size.width)/DROP_SIZE.width;
    frame.origin.x=x*DROP_SIZE.width;
    UIView *dropView=[[UIView alloc]initWithFrame:frame];
    dropView.backgroundColor=[UIColor blackColor];
    [self.gameView addSubview:dropView];
    [self.dropitBehaviour addItem:dropView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
