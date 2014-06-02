//
//  IWColorSelectorView.h
//  Catalog
//
//  Created by Abel Miranda on 5/12/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWColor.h"

@class IWColorSelectorView;

@protocol IWColorSelectorViewDelegate <NSObject>

-(void)colorSelectorView:(IWColorSelectorView*)colorSelectorView didSelection:(UIView*)view;

@end

@interface IWColorSelectorView : UIView

@property (nonatomic) BOOL selected;
@property (nonatomic, strong) IWColor *color;
@property (nonatomic) BOOL enabled;
@property (nonatomic, weak)id<IWColorSelectorViewDelegate> delegate;
@property (nonatomic, strong) NSString* text;

-(void)unSelect;

@end
