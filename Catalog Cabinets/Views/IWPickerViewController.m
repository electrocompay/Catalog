//
//  IWPickerViewViewController.m
//  Catalog
//
//  Created by Abel Miranda on 5/11/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWPickerViewController.h"
#import "IWColor.h"

@interface IWPickerViewController ()

@end

@implementation IWPickerViewController
{
    IBOutlet UIPickerView *pickerView;
    IBOutlet UILabel *label;
}

-(id)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

-(void)initialize
{
    UIView* view = [[[NSBundle mainBundle] loadNibNamed:@"IWPickerViewController" owner:self options:nil] objectAtIndex:0];
    [self addSubview:view];
    self.frame = view.frame;
    [pickerView setDelegate:self];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _items.count;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    IWColor *color = [_items objectAtIndex:row];
    return [color name];
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view;
    
    if (pickerLabel == nil) {
        CGRect frame = CGRectMake(0.0, 0.0, 199, 32);
        pickerLabel = [[UILabel alloc] initWithFrame:frame] ;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
    }
    
    IWColor *color = [_items objectAtIndex:row];
    [pickerLabel setText:color.name];
    
    return pickerLabel;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _selection = [_items objectAtIndex:row];
    if (_delegate) {
        [_delegate pickerViewController:self didSelectRow:_selection];
    }
    
}

-(void)setItems:(NSArray *)items
{
    _items = items;
    [self reloadAllComponents];
}

-(void)reloadAllComponents{
    [pickerView reloadAllComponents];
    [pickerView selectRow:0 inComponent:0 animated:NO];
    _selection = [_items objectAtIndex:0];
    
    /*   if (_delegate) {
        [_delegate pickerViewController:self didSelectRow:color];
    }*/
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    [label setText:_title];
}

@end
