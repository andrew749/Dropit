//
//  DropitBehavious.h
//  Dropit
//
//  Created by Andrew Codispoti on 2014-12-27.
//  Copyright (c) 2014 Andrew Codispoti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropitBehavious : UIDynamicBehavior <UIDynamicAnimatorDelegate>

-(void )addItem:(id<UIDynamicItem>)item;
-(void)removeItem:(id<UIDynamicItem>)item;
@end
