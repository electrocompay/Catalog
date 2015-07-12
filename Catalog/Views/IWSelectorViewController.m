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

@interface IWSelectorViewController ()

@end

@implementation IWSelectorViewController
{
    IBOutlet UIScrollView* scrollView1;
    IBOutlet IWOptionView* selectedView;
    IBOutlet UILabel* headerLabel;
    IBOutlet UILabel *propertyNameView;
    NSMutableArray* filteredList;
    NSMutableArray* subviews;
    IBOutlet UIView *marker;
    IBOutlet UIView *marker_back;
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
    [propertyNameView setText:[NSString stringWithFormat:@"Active %@", _propertyName]];
    scrollView1.delegate = self;
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
            priorCategory = color.category;
        }
    }
    if (subviews.count > 0) {
        optionView = [subviews objectAtIndex:0];
        [optionView setSelected:YES];
        [self setSelection:optionView.tag];
        scrollView1.contentSize = CGSizeMake((pageSize.width + 10) * page, pageSize.height);
    }
    [self updateMarkers];
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

    [selectedView.label setText:optionView.label.text];
    [selectedView setImage:optionView.image];
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
}

-(void)updateMarkers
{
    marker_back.hidden = scrollView1.contentOffset.x == 0;
    marker.hidden = scrollView1.contentOffset.x == scrollView1.contentSize.width - scrollView1.bounds.size.width;
}

@end
