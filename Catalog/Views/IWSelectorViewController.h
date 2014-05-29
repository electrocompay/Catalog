//
//  IWSelectorView.h
//  Catalog
//
//  Created by Abel Miranda on 4/8/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWColor.h"

@class IWSelectorViewController;

@protocol IWSelectorViewControllerDelegate <NSObject>

-(void) didSelectColor:(IWSelectorViewController*)selectorViewController andColor:(IWColor*)color;

@end

@interface IWSelectorViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray* items;
@property (nonatomic, strong) NSArray* filteredItems;
@property (nonatomic, strong) IWColor* selectedColor;
@property (readonly) NSInteger selectedIndex;
@property (nonatomic, weak) id<IWSelectorViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString* propertyName;
@property (nonatomic, strong) NSString* headerTitle;

-(void)setSelection:(NSInteger)index;

@end
