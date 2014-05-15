//
//  IWColorSelectorView.h
//  Catalog
//
//  Created by Abel Miranda on 5/12/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWColor.h"

@interface IWColorSelectorView : UIView

@property (nonatomic) BOOL selected;
@property (nonatomic, strong) IWColor *color;
@property (nonatomic) BOOL enabled;

-(void)unSelect;

@end
