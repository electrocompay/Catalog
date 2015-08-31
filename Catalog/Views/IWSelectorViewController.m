//
//  IWSelectorView.m
//  Catalog
//
//  Created by Abel Miranda on 4/8/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWSelectorViewController.h"
#import "IWColor.h"
#import "IWOptionView.h"

#define BUTTON_1_TAG 1111
#define BUTTON_2_TAG 2222

@interface IWSelectorViewController ()

@end

@implementation IWSelectorViewController
{
    IBOutlet UIScrollView *scrollView1;
    IBOutlet IWOptionView *selectedView;
    IBOutlet UILabel *headerLabel;
    IBOutlet UILabel *propertyNameView;
    NSMutableArray *filteredList;
    NSMutableArray *subviews;
    IBOutlet UIButton *marker;
    IBOutlet UIButton *marker_back;
    
    IBOutlet UIView *alternativeView;
    IBOutlet UIScrollView *scrollView2;
    IBOutlet UIButton *alternativeMarker;
    IBOutlet UIButton *alternativeMarker_back;
    IBOutlet UIButton *option1Button;
    IBOutlet UIButton *option2Button;
    IBOutlet UILabel *option1Label;
    IBOutlet UILabel *option2Label;
    IBOutlet UILabel *selectedElementLabel;
    IBOutlet IWOptionView *selectedAltView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [selectedView setSelected:YES];
    [selectedAltView setSelected:YES];
    
    [propertyNameView setText:[NSString stringWithFormat:@"Active %@", _propertyName]];
    scrollView1.delegate = self;
    scrollView2.delegate = self;
    
    alternativeView.hidden = NO;

    [self updateMarkers];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setItems:(NSArray *)items
{
    _items = items;

    if (self.chairModelForAlternativeView != nil)
    {
        if (![self.chairModelForAlternativeView isEqualToString:self.previousChairModelForAlternativeView]) {
            [self prepareAdditionalOptionsView:items];
        }
    }
    else {
        alternativeView.hidden = YES;
    }
    
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

//    if (subviews) {
        [scrollView1.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [scrollView2.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
  //  }
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
    for (IWColor *color in filteredList) {
            optionView = [[IWOptionView alloc] init];

            // Dynamically adapt font size
            optionView.label.numberOfLines = 1;
            optionView.label.adjustsFontSizeToFitWidth = YES;

            [optionView.label setText:color.name];

            [scrollView1 addSubview:optionView];
            if (alternativeView.hidden == NO) {
                [scrollView2 addSubview:optionView];
            }
        
            [subviews addObject:optionView];
            optionView.frame = CGRectMake((optionView.frame.size.width + 10 )* page , 0, pageSize.width - 20, pageSize.height);
            [optionView setTag:page];
            page++;
        
            UITapGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(optionSelected:)];
            [optionView setUserInteractionEnabled:YES];
            [optionView setGestureRecognizers:[NSArray arrayWithObject:recognizer]];
            [optionView setImage:color.file];
        if (!uniqueCategory && priorCategory != color.category) {
            UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectMake(optionView.frame.origin.x, -29, headerLabel.frame.size.width, headerLabel.frame.size.height)];
            [newLabel setFont:headerLabel.font];
            [newLabel setText:color.category];

            [scrollView1 addSubview:newLabel];
            if (alternativeView.hidden == NO) {
                [scrollView2 addSubview:newLabel];
            }

            priorCategory = color.category;
        }
    }
    if (subviews.count > 0) {
        
        NSInteger selectionIndex = 0;
        if (alternativeView.hidden == NO) {
            selectionIndex = self.chairColorIndex;
            if (self.isOptionSelected) {
                selectionIndex = self.leatherColorIndex;
            }
        }
        
        optionView = [subviews objectAtIndex:selectionIndex];
        [optionView setSelected:YES];
        [self setSelection:optionView.tag];
        scrollView1.contentSize = CGSizeMake((pageSize.width + 10) * page, pageSize.height);
        if (alternativeView.hidden == NO) {
            scrollView2.contentSize = CGSizeMake((pageSize.width + 10) * page, pageSize.height);
        }
    }
    [self updateMarkers];
    if (alternativeView.hidden == NO) {
        [self updateAlternativeMarkers];
    }
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
    
    if (alternativeView.hidden == NO) {
        if (self.isOptionSelected) {
            self.leatherColorIndex = index;
        }
        else {
            self.chairColorIndex = index;
        }
    }
    
    _selectedColor = [filteredList objectAtIndex:_selectedIndex];
    IWOptionView *optionView = (IWOptionView*) [subviews objectAtIndex:_selectedIndex];
    [subviews makeObjectsPerformSelector:@selector(clearSelection)];
    [optionView setSelected:YES];

    [selectedView.label setText:optionView.label.text];
    [selectedView setImage:optionView.image];

    [selectedAltView.label setText:optionView.label.text];
    [selectedAltView setImage:optionView.image];

    
    
    if (_delegate) {
        [_delegate didSelectColor:self andColor:_selectedColor];
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

#pragma mark UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self updateMarkers];
    if (alternativeView.hidden == NO) {
        [self updateAlternativeMarkers];
    }
}

-(void)updateMarkers
{
    marker_back.hidden = scrollView1.contentOffset.x == 0;
    marker.hidden = (scrollView1.contentOffset.x >= scrollView1.contentSize.width - scrollView1.bounds.size.width);
}

-(IBAction)scrollForward:(id)sender {
    
    int newXOffset = scrollView1.contentOffset.x + scrollView1.bounds.size.width;
    
    if ( (newXOffset + scrollView1.bounds.size.width) > scrollView1.contentSize.width) {
        newXOffset = scrollView1.contentSize.width - scrollView1.bounds.size.width;
        marker.hidden = YES;
    }
    
    [scrollView1 setContentOffset:CGPointMake(newXOffset, scrollView1.contentOffset.y) animated:YES];
}

-(IBAction)scrollBackward:(id)sender {
    int newXOffset = scrollView1.contentOffset.x - scrollView1.bounds.size.width;
    
    if ( (newXOffset - scrollView1.bounds.size.width) < 0) {
        newXOffset = 0;
        marker_back.hidden = YES;
    }
    
    [scrollView1 setContentOffset:CGPointMake(newXOffset, scrollView1.contentOffset.y) animated:YES];
}

// This method duplication should be optimized
-(IBAction)alternativeScrollForward:(id)sender {
    
    int newXOffset = scrollView2.contentOffset.x + scrollView2.bounds.size.width;
    
    if ( (newXOffset + scrollView2.bounds.size.width) > scrollView2.contentSize.width) {
        newXOffset = scrollView2.contentSize.width - scrollView2.bounds.size.width;
        alternativeMarker.hidden = YES;
    }
    
    [scrollView2 setContentOffset:CGPointMake(newXOffset, scrollView2.contentOffset.y) animated:YES];
}

-(IBAction)alternativeScrollBackward:(id)sender {
    int newXOffset = scrollView2.contentOffset.x - scrollView2.bounds.size.width;
    
    if ( (newXOffset - scrollView2.bounds.size.width) < 0) {
        newXOffset = 0;
        alternativeMarker_back.hidden = YES;
    }
    
    [scrollView2 setContentOffset:CGPointMake(newXOffset, scrollView2.contentOffset.y) animated:YES];
}

-(void)updateAlternativeMarkers {
    alternativeMarker_back.hidden = scrollView2.contentOffset.x == 0;
    alternativeMarker.hidden = (scrollView2.contentOffset.x >= scrollView2.contentSize.width - scrollView2.bounds.size.width);
}

-(void)prepareAdditionalOptionsView:(NSArray *)items {

    self.baseItems = items;
    self.previousChairModelForAlternativeView = self.chairModelForAlternativeView;
    
    self.chairColorIndex = 0;
    self.leatherColorIndex = 0;

    if ([self.chairModelForAlternativeView isEqualToString:@"Picasso-P"]) {
        option1Label.text = @"Coating";
        option2Label.text = @"Piping";
        selectedElementLabel.text = @"Active pads color";
    }
    else if ([self.chairModelForAlternativeView rangeOfString:@"Margueritte"].location != NSNotFound) {
        option1Label.text = @"Base";
        option2Label.text = @"Bucket seat";
        selectedElementLabel.text = @"Active bucket\n seat color";
    }
    
    option1Button.selected = YES;
    option2Button.selected = NO;
    
    self.isOptionSelected = NO;
    
    alternativeView.hidden = NO;
}

- (IBAction)changeOptionSelection:(id)sender {
    
    if ([sender tag] == BUTTON_1_TAG) {
        
        option1Button.selected = YES;
        self.isOptionSelected = option2Button.selected = NO;

        [self setItems:self.baseItems];
    }
    else if ([sender tag] == BUTTON_2_TAG) {

        option1Button.selected = NO;
        self.isOptionSelected = option2Button.selected = YES;

        [self setItems:self.optionsItems];
    }
}




@end
