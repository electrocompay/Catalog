//
//  IWSelectorView.m
//  Catalog
//
//  Created by Abel Miranda on 4/8/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWMultipleSelectorViewController.h"
#import "IWColor.h"
#import "IWOptionView.h"
#import "IWColorsPanelView.h"
#import "IWColors.h"
#import "NSArray+color.h"
#import "Constants.h"


@interface IWMultipleSelectorViewController ()

@end

@implementation IWMultipleSelectorViewController
{
    IBOutlet UIScrollView* scrollView;
    IBOutlet UILabel* headerLabel;
    IBOutlet UILabel *propertyNameView;
    IBOutlet UIView *multipleContainer;
    NSMutableArray* filteredList;
    NSMutableArray* subviews;
    IWColorsPanelView *panelColors;
    IBOutlet UISwitch *switch1;
    IBOutlet UISwitch *switch2;
    IBOutlet UILabel *labelAllColors;
    IBOutlet UILabel *labelAllColor1;
    IBOutlet UILabel *labelColorDoor;

    IBOutlet UIView *startSeparator;
    IBOutlet UIView *scrollViewContainer;
    
    IBOutlet UIButton *marker;
    IBOutlet UIButton *marker_back;
}

-(id)initWithMode:(IWMultipleSelectorMode)mode
{
    self = [super initWithNibName:@"IWMultipleSelectorViewController" bundle:nil];
    if (self) {
        _mode = mode;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    switch (_mode) {
        case MultipleSelectorModeNineColors:
            panelColors = [IWColorsPanelView colorsPanelNineDoors];
            break;
        case MultipleSelectorModeFourColors:
            panelColors = [IWColorsPanelView colorsPanelFourDoors];
            break;
        case MultipleSelectorModeModuleColors:
            panelColors = [IWColorsPanelView colorsPanelModuleDoors];
            [self setPanelColorsForCosyJoli];
            break;
            
        default:
            break;
    }
    panelColors.delegate = self;
    [multipleContainer addSubview: panelColors];
    [self setItems:[IWColors cabinetColors]];
    [panelColors setCabinet:_cabinet];
    [switch1 addTarget:self action:@selector(switchMode:) forControlEvents:UIControlEventValueChanged];
    [switch2 addTarget:self action:@selector(switchMode:) forControlEvents:UIControlEventValueChanged];
    scrollView.delegate = self;
    
    [self updateMarkers];
}

-(void)setPanelColorsForCosyJoli
{
    CGRect elementFrame, elementBounds;
    
    elementFrame = multipleContainer.frame;
    multipleContainer.frame = CGRectMake(elementFrame.origin.x, elementFrame.origin.y, panelColors.frame.size.width, elementFrame.size.height);
    
    elementFrame = headerLabel.frame;
    headerLabel.frame = CGRectMake(elementFrame.origin.x - 3*OC, elementFrame.origin.y, elementFrame.size.width, elementFrame.size.height);
    
    elementFrame = startSeparator.frame;
    startSeparator.frame = CGRectMake(elementFrame.origin.x - 3*OC, elementFrame.origin.y, elementFrame.size.width, elementFrame.size.height);
    
    elementFrame = marker_back.frame;
    elementBounds = marker_back.bounds;
    marker_back.frame = CGRectMake(elementFrame.origin.x - 3*OC, elementFrame.origin.y, elementFrame.size.width, elementFrame.size.height);
    marker_back.bounds = CGRectMake(elementBounds.origin.x - 3*OC, elementBounds.origin.y, elementBounds.size.width, elementBounds.size.height);

    elementFrame = scrollViewContainer.frame;
    elementBounds = scrollViewContainer.bounds;
    scrollViewContainer.frame = CGRectMake(elementFrame.origin.x - 3*OC, elementFrame.origin.y, elementFrame.size.width + 3*OC, elementFrame.size.height);
    scrollViewContainer.bounds = CGRectMake(elementBounds.origin.x - 3*OC, elementBounds.origin.y, elementBounds.size.width + 3*OC, elementBounds.size.height);

    elementFrame = scrollView.frame;
    elementBounds = scrollView.bounds;
    scrollView.frame = CGRectMake(elementFrame.origin.x - 3*OC, elementFrame.origin.y, elementFrame.size.width + 3*OC, elementFrame.size.height);
    scrollView.bounds = CGRectMake(elementBounds.origin.x - 3*OC, elementBounds.origin.y, elementBounds.size.width + 3*OC, elementBounds.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setItems:(NSArray *)items
{
    _items = items;
    
    NSString* uniqueCategory = ((IWColor*) [_items objectAtIndex:0]).category;
    filteredList = [[NSMutableArray alloc] init];
    for (IWColor *color in _items) {
        if (!_filteredItems || [self colorFiltered:color.code]) {
            if (uniqueCategory) {
                if (uniqueCategory != color.category){
                    uniqueCategory = nil;
                }
            }
            [filteredList addObject:color];
        }
    }
    
    [scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    subviews = [[NSMutableArray alloc] init];
    IWOptionView* optionView = [[IWOptionView alloc] init];
    CGSize pageSize = optionView.bounds.size;
    NSInteger page = 0;
    
    if (uniqueCategory) {
        [headerLabel setText:[NSString stringWithFormat:@"Choose %@", uniqueCategory]];
    } else {
        [headerLabel setHidden:YES];
    }

    NSString* priorCategory = nil;
    BOOL didPrintFirstCategoryLabel = NO;

    for (IWColor *color in filteredList) {
        optionView = [[IWOptionView alloc] init];

        // Dynamically adapt font size
        [self setDinamicallyAdaptedTextForLabel:optionView.label];

        [optionView.label setText:color.name];
 
        [scrollView addSubview:optionView];
        [subviews addObject:optionView];
        optionView.frame = CGRectMake((optionView.frame.size.width + 10 )* page , 0, pageSize.width - 20, pageSize.height);
        [optionView setTag:page];
        page++;

        UITapGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(optionSelected:)];
        [optionView setUserInteractionEnabled:YES];
        [optionView setGestureRecognizers:[NSArray arrayWithObject:recognizer]];
        [optionView setImage:color.file];
        
        
        if (uniqueCategory && (headerLabel.hidden == YES) &&  didPrintFirstCategoryLabel == NO) {
            [self setCategoryLabel:optionView andText:color.category];
            didPrintFirstCategoryLabel = YES;
        }
        else if (!uniqueCategory && priorCategory != color.category) {
            [self setCategoryLabel:optionView andText:color.category];
            priorCategory = color.category;
        }
    }
    if (subviews.count > 0) {
        optionView = [subviews objectAtIndex:0];
        [optionView setSelected:YES];
 //       [self setSelection:optionView.tag];
        scrollView.contentSize = CGSizeMake((pageSize.width + 10) * page, pageSize.height);
    }

    [self updateMarkers];
}

-(void)setCategoryLabel:(UIView*)optionView andText:(NSString*)text
{
    UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectMake(optionView.frame.origin.x, -29, headerLabel.frame.size.width, headerLabel.frame.size.height)];
    [newLabel setFont:headerLabel.font];
    [newLabel setText:text];
    
    [scrollView addSubview:newLabel];
}

-(BOOL)colorFiltered:(NSString*)code
{
    for (NSString* filteredCode in _filteredItems) {
        if ([filteredCode isEqualToString:code]) {
            return YES;
        }
    }
    return NO;
}

-(void)optionSelected:(UITapGestureRecognizer*)sender
{
    [self setSelection:sender.view.tag];
}

-(void)setSelection:(NSInteger)index
{
    _selectedIndex = index;
    _selectedColor = [filteredList objectAtIndex:_selectedIndex];
    IWOptionView *optionView = (IWOptionView*) [subviews objectAtIndex:_selectedIndex];
    [subviews makeObjectsPerformSelector:@selector(clearSelection)];
    [optionView setSelected:YES];
    [panelColors setColorToSelection:_selectedColor];
}

-(void)setSelectedIndex:(NSInteger)selectedIndex
{
    [self setSelectedIndex:selectedIndex];
    if (_delegate) {
        [_delegate didSelectColor:self andColor:_selectedColor andIndex:0];
    }
}

-(void)setFilteredItems:(NSArray *)filteredItems
{
    if (_filteredItems != filteredItems) {
        _filteredItems = filteredItems;
        [self setItems:_items];
    }
}

-(void)setPropertyName:(NSString *)propertyName
{
    _propertyName = propertyName;
}

-(void)setCabinet:(IWCabinet *)cabinet
{
    _cabinet = cabinet;
    [panelColors setCabinet:_cabinet];
}

-(void)didChange:(IWColorsPanelView *)colorsPanelView
{
    if (_delegate) {
        [_delegate didSelectColor:self andColor:nil andIndex:0];
    }
}

-(void)switchMode:(id)sender
{
    if (sender == switch1) {
        switch2.on = !switch1.on;
    } else {
        switch1.on = !switch2.on;
    }
    [panelColors setOneSelectionMode:switch1.on];
}

#pragma mark UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self updateMarkers];
}

-(void)updateMarkers
{
    marker_back.hidden = scrollView.contentOffset.x == 0;
    marker.hidden = scrollView.contentOffset.x == scrollView.contentSize.width - scrollView.bounds.size.width;
}

-(void)didChange:(IWColorsPanelView *)colorsPanelView didSelectButton:(NSInteger)tag
{
    if (_mode == MultipleSelectorModeModuleColors) {
        if (tag < 2) {
            NSArray *items = [IWColors cabinetColors];
            if (items != _items) {
                [self setItems:[IWColors cabinetColors]];
            }
        } else if (tag < 5){
            NSArray *items = [IWColors cabinetDrawerColors];
            if (items != _items) {
                [self setItems:[IWColors cabinetDrawerColors]];
            }
        } else {
            NSArray *items = [IWColors cabinetStripeColors];
            if (items != _items) {
                [self setItems:[IWColors cabinetStripeColors]];
            }
        }
    }
    
    if (_mode == MultipleSelectorModeFourColors) {
        if (tag < 4) {
            // Door Colors
            NSArray *items = [IWColors cabinetColors];
            if (items != _items) {
                [self setItems:[IWColors cabinetColors]];
            }
        } else {
            // Interior Colors
            NSArray *items = [IWColors cabinetInteriorColors];
            if (items != _items) {
                [self setItems:[IWColors cabinetInteriorColors]];
            }
        }
    }
    
    IWColor * color = [_items colorByCode:colorsPanelView.selectedView.color.code];
    NSInteger index = [_items indexOfObject:color];
    if (index < _items.count) {
        [self setSelection: index];
    }
}

-(IBAction)scrollForward:(id)sender {
    
    int newXOffset = scrollView.contentOffset.x + scrollView.bounds.size.width;
    
    if ( (newXOffset + scrollView.bounds.size.width) > scrollView.contentSize.width) {
        newXOffset = scrollView.contentSize.width - scrollView.bounds.size.width;
        marker.hidden = YES;
    }
    
    [scrollView setContentOffset:CGPointMake(newXOffset, scrollView.contentOffset.y) animated:YES];
}

-(IBAction)scrollBackward:(id)sender {
    int newXOffset = scrollView.contentOffset.x - scrollView.bounds.size.width;
    
    if ( (newXOffset - scrollView.bounds.size.width) < 0) {
        newXOffset = 0;
        marker_back.hidden = YES;
    }
    
    [scrollView setContentOffset:CGPointMake(newXOffset, scrollView.contentOffset.y) animated:YES];
}

-(void)setDinamicallyAdaptedTextForLabel:(UILabel *)label {
    // Dynamically adapt font size
    label.numberOfLines = 1;
    label.adjustsFontSizeToFitWidth = YES;
}

@end
