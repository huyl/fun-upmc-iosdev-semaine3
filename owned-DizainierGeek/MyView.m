//
//  MyView.m
//  owned-DizainierGeek
//
//  Created by Huy on 5/22/14.
//  Copyright (c) 2014 huy. All rights reserved.
//

#import "MyView.h"

@interface MyView ()

@property (nonatomic) int number;
@property (nonatomic) BOOL modeGeek;

@property (nonatomic) UILabel *numberDisplay;

@property (nonatomic) UISwitch *geekSwitch;
- (void)geekSwitchWasChanged:(id)sender;

@property (nonatomic) UIStepper *stepper;
- (void)stepperWasTapped:(id)sender;

@property (nonatomic) UISegmentedControl *dizainesSeg;
- (void)dizainesSegWasTapped:(id)sender;

@property (nonatomic) UISegmentedControl *unitesSeg;
- (void)unitesSegWasTapped:(id)sender;
@property (nonatomic) UISlider *slider;
- (void)sliderWasChanged:(id)sender;

@property (nonatomic) UIButton *resetButton;
- (void)resetWasTapped:(id)sender;

@property (nonatomic) UILabel *geekSwitchLabel;
@property (nonatomic) UILabel *dizainesLabel;
@property (nonatomic) UILabel *unitesLabel;

@end



@implementation MyView
@synthesize number, modeGeek;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _stepper = [[[UIStepper alloc] init] autorelease];
        NSLog(@"stepper retaincount %d", [_stepper retainCount]);
        [self.stepper addTarget:self action:@selector(stepperWasTapped:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.stepper];

        _geekSwitch = [[[UISwitch alloc] init] autorelease];
        [self.geekSwitch addTarget:self action:@selector(geekSwitchWasChanged:)
                  forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.geekSwitch];
        
        _geekSwitchLabel = [[[UILabel alloc] init] autorelease];
        [self.geekSwitchLabel setTextAlignment:NSTextAlignmentCenter];
        [self.geekSwitchLabel setText:@"mode Geek"];
        [self addSubview:self.geekSwitchLabel];
        
        _dizainesLabel = [[[UILabel alloc] init] autorelease];
        [self.dizainesLabel setTextAlignment:NSTextAlignmentCenter];
        [self.dizainesLabel setText:@"Dizaines"];
        [self addSubview:self.dizainesLabel];
        
        _dizainesSeg = [[[UISegmentedControl alloc] init] autorelease];
        [self.dizainesSeg addTarget:self action:@selector(dizainesSegWasTapped:)
                   forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.dizainesSeg];
        
        _unitesLabel = [[[UILabel alloc] init] autorelease];
        [self.unitesLabel setTextAlignment:NSTextAlignmentCenter];
        [self.unitesLabel setText:@"Unités"];
        [self addSubview:self.unitesLabel];
        
        _unitesSeg = [[[UISegmentedControl alloc] init] autorelease];
        [self.unitesSeg addTarget:self action:@selector(unitesSegWasTapped:)
                 forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.unitesSeg];
        
        _numberDisplay = [[[UILabel alloc] init] autorelease];
        [self.numberDisplay setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.numberDisplay];
        
        _slider = [[[UISlider alloc] init] autorelease];
        [self.slider addTarget:self action:@selector(sliderWasChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.slider];
        
        _resetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.resetButton setTitle:@"Reset" forState:UIControlStateNormal];
        [self.resetButton addTarget:self action:@selector(resetWasTapped:)
                   forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.resetButton];
        
        [self layoutWithOrientation:[[UIApplication sharedApplication] statusBarOrientation]];

        
        self.modeGeek = NO;
        self.geekSwitch.on = self.modeGeek;
        
        // Init stepper
        self.stepper.minimumValue = 0.0;
        self.stepper.maximumValue = 99.0;
        self.stepper.stepValue = 1.0;
        
        // Init slider
        self.slider.minimumValue = 0.0;
        self.slider.maximumValue = 99.0;
        
        // Init segmented control titles
        for (int i = 0; i < 10; i++) {
            [self.dizainesSeg insertSegmentWithTitle:[NSString stringWithFormat:@"%d", i] atIndex:i animated:NO];
            [self.unitesSeg insertSegmentWithTitle:[NSString stringWithFormat:@"%d", i] atIndex:i animated:NO];
        }
        
        [self reset];
    }
    return self;
}

// FIXME: make reset button visible in landscape mode
- (void)layoutWithOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
//    NSLog(@"bounds %@", NSStringFromCGSize(self.bounds.size));
    float vertShift = UIInterfaceOrientationIsLandscape(toInterfaceOrientation) ? .85 : 1;
    
    [self.stepper setFrame:CGRectMake(20, 32 * vertShift, 94, 29)];
    [self.geekSwitch setFrame:CGRectMake(self.bounds.size.width - 20 - 51, 31 * vertShift, 51, 31)];
    [self.geekSwitchLabel setFrame:CGRectMake(self.bounds.size.width - 77 - 91, 36 * vertShift, 91, 21)];
    [self.dizainesLabel setFrame:CGRectMake((self.bounds.size.width - 69) / 2, 84 * vertShift, 69, 21)];
    [self.dizainesSeg setFrame:CGRectMake(20, 113 * vertShift, self.bounds.size.width - 40, 29)];
    [self.unitesLabel setFrame:CGRectMake((self.bounds.size.width - 69) / 2, 157 * vertShift, 69, 21)];
    [self.unitesSeg setFrame:CGRectMake(20, 186 * vertShift, self.bounds.size.width - 40, 29)];
    [self.numberDisplay setFrame:CGRectMake((self.bounds.size.width - 69) / 2, 231 * vertShift, 69, 21)];
    [self.slider setFrame:CGRectMake(20, 269 * vertShift, self.bounds.size.width - 40, 29)];
    
    int resetButtonY = UIInterfaceOrientationIsLandscape(toInterfaceOrientation) ?
        self.bounds.size.height - 20 - 41 : 419;
    [self.resetButton setFrame:CGRectMake((self.bounds.size.width - 122) / 2, resetButtonY, 122, 41)];
}


- (void)setNumber:(int)num
{
    number = MAX(0, MIN(99, num));
    [self updateNumberDisplay];
    [self updateSegs];
    
    self.stepper.value = number;
    self.slider.value = number;
}

- (void)updateNumberDisplay
{
    NSString* format = self.modeGeek ? @"%x" : @"%d";
    self.numberDisplay.text = [NSString stringWithFormat:format, self.number];
    
    // Special "chinoiserie"
    self.numberDisplay.textColor = (self.number == 42 ? [UIColor redColor] : [UIColor blackColor]);
}

- (void)updateSegs
{
    int dizaines = MIN(self.number / 10, 10);
    int unites = self.number % 10;
    self.dizainesSeg.selectedSegmentIndex = dizaines;
    self.unitesSeg.selectedSegmentIndex = unites;
}

- (void)updateNumberFromSegs
{
    self.number = self.dizainesSeg.selectedSegmentIndex * 10 + self.unitesSeg.selectedSegmentIndex;
}

- (void)reset
{
    [self setNumber:0];
}


- (void)stepperWasTapped:(id)sender {
    self.number = self.stepper.value;
}
- (void)dizainesSegWasTapped:(id)sender {
    [self updateNumberFromSegs];
}
- (void)unitesSegWasTapped:(id)sender {
    [self updateNumberFromSegs];
}
- (void)sliderWasChanged:(id)sender {
    self.number = self.slider.value;
}

- (void)resetWasTapped:(id)sender {
    [self reset];
}
- (void)geekSwitchWasChanged:(id)sender {
    self.modeGeek = self.geekSwitch.on;
    [self updateNumberDisplay];
}

@end
