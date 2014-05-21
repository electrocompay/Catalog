//
//  IWSelectorView.h
//  Catalog
//
//  Created by Abel Miranda on 4/8/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWColor.h"
#import "IWCabinet.h"
#import "IWColorsPanelView.h"

typedef enum IWMultipleSelectorMode : NSInteger IWMultipleSelectorMode;
enum IWMultipleSelectorMode : NSInteger {
    MultipleSelectorModeNineColors,
    MultipleSelectorModeFourColors,
    MultipleSelectorModeModuleColors
};

@class IWMultipleSelectorViewController;

@protocol IWMultipleSelectorViewControllerDelegate <NSObject>

-(void) didSelectColor:(IWMultipleSelectorViewController*)selectorViewController andColor:(IWColor*)color andIndex:(NSInteger) index;

@end

@interface IWMultipleSelectorViewController : UIViewController<IWColorsPanelViewDelegate, UIScrollViewDelegate>

-(id)initWithMode:(IWMultipleSelectorMode)mode;

@property (nonatomic, strong) NSArray* items;
@property (nonatomic, strong) NSArray* filteredItems;
@property (nonatomic, strong) IWColor* selectedColor;
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic, weak) id<IWMultipleSelectorViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString* propertyName;
@property (nonatomic, strong) NSString* headerTitle;
@property (nonatomic, strong) IWCabinet* cabinet;
@property (nonatomic) IWMultipleSelectorMode mode;

@end
