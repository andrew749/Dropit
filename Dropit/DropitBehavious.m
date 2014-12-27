//
//  DropitBehavious.m
//  Dropit
//
//  Created by Andrew Codispoti on 2014-12-27.
//  Copyright (c) 2014 Andrew Codispoti. All rights reserved.
//

#import "DropitBehavious.h"
@interface DropitBehavious() <UIDynamicAnimatorDelegate>
@property (strong,nonatomic)UIGravityBehavior *gravity;
@property (strong,nonatomic)UICollisionBehavior *collider;
@end
@implementation DropitBehavious
-(instancetype)init{
    self=[super init];
    [self addChildBehavior:self.gravity];
    [self addChildBehavior:self.collider];
    return self;
}
-(UICollisionBehavior *)collider{
    
    if(!_collider){
        _collider=[[UICollisionBehavior alloc] init];
        _collider.translatesReferenceBoundsIntoBoundary=YES;
    }
    return _collider;
}

-(UIGravityBehavior *)gravity{
    if(!_gravity){
        _gravity=[[UIGravityBehavior alloc] init];
        _gravity.magnitude=0.9;
    }
    return _gravity;
}
-(void)addItem:(id<UIDynamicItem>)item  {
    [self.collider addItem:item];
    [self.gravity addItem:item];
}
-(void)removeItem:(id<UIDynamicItem>)item{
    [self.collider removeItem:item];
    [self.gravity removeItem:item];
}
@end
