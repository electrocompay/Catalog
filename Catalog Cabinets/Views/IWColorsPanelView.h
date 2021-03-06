//
//  IWColorsPanelView.h
//  Catalog
//
//  Created by Abel Miranda on 5/13/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWCabinet.h"
#import "IWColorSelectorView.h"

@class IWColorsPanelView;

@protocol IWColorsPanelViewDelegate <NSObject>

-(void) didChange:(IWColorsPanelView*)colorsPanelView;
-(void) didChange:(IWColorsPanelView*)colorsPanelView didSelectButton:(NSInteger)tag;

@end


@interface IWColorsPanelView : UIView<IWColorSelectorViewDelegate>

+(IWColorsPanelView*)colorsPanelNineDoors;
+(IWColorsPanelView*)colorsPanelFourDoors;
+(IWColorsPanelView*)colorsPanelModuleDoors;

@property (nonatomic, retain)IWCabinet* cabinet;
@property (nonatomic, weak) id<IWColorsPanelViewDelegate> delegate;
@property (nonatomic) BOOL oneSelectionMode;
@property (nonatomic, readonly) IWColorSelectorView *selectedView;
@property (nonatomic, strong) NSString* stripeText;

-(void)setColorToSelection:(IWColor*)color;

@end
