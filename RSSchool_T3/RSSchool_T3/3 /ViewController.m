#import "ViewController.h"

int const DEFAULT_WIDTH = 150;
int const DEFAULT_HEIGHT = 30;
int const SPACING = 10;
int const V_SPACING = 5;
NSMutableArray *arrayOfViews;
int posYForButton;

@interface ViewController() <UITextFieldDelegate>
@property (nonatomic, strong) UILabel *labelResultColor;
@property (nonatomic, strong) UILabel *labelRed;
@property (nonatomic, strong) UILabel *labelGreen;
@property (nonatomic, strong) UILabel *labelBlue;
@property (nonatomic, strong) UIView *viewResultColor;
@property (nonatomic, strong) UITextField *textFieldRed;
@property (nonatomic, strong) UITextField *textFieldGreen;
@property (nonatomic, strong) UITextField *textFieldBlue;
@property (nonatomic, strong) UIButton *buttonProcess;
@property (nonatomic, strong) UIColor *color;




@end
@implementation ViewController

#pragma mark -


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self createSubViews];
}

-(void)createSubViews{

    self.view.accessibilityIdentifier = @"mainView";
    arrayOfViews = [NSMutableArray new];
    self.buttonProcess = [[UIButton alloc] init];
    self.buttonProcess.accessibilityIdentifier = @"buttonProcess";
    [arrayOfViews addObject:self.buttonProcess];
    self.labelResultColor = [[UILabel alloc] init];
    self.labelResultColor.accessibilityIdentifier = @"labelResultColor";
    [arrayOfViews addObject:self.labelResultColor];
    self.viewResultColor = [[UIView alloc] init];
    self.viewResultColor.accessibilityIdentifier = @"viewResultColor";
    [arrayOfViews addObject:self.viewResultColor];
    self.labelRed = [[UILabel alloc] init];
    self.labelRed.accessibilityIdentifier = @"labelRed";
    [arrayOfViews addObject:self.labelRed];
    self.textFieldRed = [[UITextField alloc] init];
    self.textFieldRed.accessibilityIdentifier = @"textFieldRed";
    [arrayOfViews addObject:self.textFieldRed];
    self.labelGreen = [[UILabel alloc] init];
    self.labelGreen.accessibilityIdentifier = @"labelGreen";
    [arrayOfViews addObject:self.labelGreen];
    self.textFieldGreen = [[UITextField alloc] init];
    self.textFieldGreen.accessibilityIdentifier = @"textFieldGreen";
    [arrayOfViews addObject:self.textFieldGreen];
    self.labelBlue = [[UILabel alloc] init];
    self.labelBlue.accessibilityIdentifier = @"labelBlue";
    [arrayOfViews addObject:self.labelBlue];
    self.textFieldBlue = [[UITextField alloc] init];
    self.textFieldBlue.accessibilityIdentifier = @"textFieldBlue";
    [arrayOfViews addObject:self.textFieldBlue];
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;
    CGPoint origin = CGPointMake(50, 30);
    int offsetForFirst = 30;
    int i = 1;
    while (i < [arrayOfViews count]){
        if ((i%2) != 0) {
            NSString *colorName = [[arrayOfViews[i] accessibilityIdentifier] substringWithRange:
                                   NSMakeRange(5, [[arrayOfViews[i] accessibilityIdentifier] length]-5)];
            [arrayOfViews[i] setFrame:CGRectMake(origin.x, origin.y + DEFAULT_HEIGHT*i + V_SPACING, DEFAULT_WIDTH + offsetForFirst, DEFAULT_HEIGHT)];
            
            [arrayOfViews[i] setText: [colorName uppercaseString]];
            
        }else{
            [arrayOfViews[i] setFrame:CGRectMake(origin.x + SPACING + DEFAULT_WIDTH + offsetForFirst, origin.y + DEFAULT_HEIGHT*(i-1)+ V_SPACING, DEFAULT_WIDTH - offsetForFirst, DEFAULT_HEIGHT)];
            if ([arrayOfViews[i] isKindOfClass:[UITextField class]]){
                [arrayOfViews[i] setPlaceholder:@"0..255"];
                [arrayOfViews[i] setDelegate: self];
                
            }else{
                self.viewResultColor.backgroundColor = UIColor.grayColor;
                self.labelResultColor.text = [self hexFromColor:self.viewResultColor.backgroundColor];
            }
            [[arrayOfViews[i] layer] setCornerRadius:2];
            [[arrayOfViews[i] layer] setBorderWidth:1];
            [[arrayOfViews[i] layer] setBorderColor:UIColor.grayColor.CGColor];
            offsetForFirst = 0;
            
        }
        
        [self.view addSubview:arrayOfViews[i]];
         
        i++;
    }
    posYForButton = origin.y + i*V_SPACING + i*DEFAULT_HEIGHT;
    [self.buttonProcess setFrame:CGRectMake(self.view.bounds.size.width/2 - DEFAULT_WIDTH/2 , origin.y + i*V_SPACING + i*DEFAULT_HEIGHT, DEFAULT_WIDTH, DEFAULT_HEIGHT)];
    [self.buttonProcess setTitle:@"Process" forState:UIControlStateNormal];
    [self.buttonProcess setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [self.buttonProcess setTitleColor:UIColor.grayColor forState:UIControlStateHighlighted];
    [self.view addSubview:self.buttonProcess];
    [self.buttonProcess addTarget:self action:@selector(processButtonDidTaped) forControlEvents:UIControlEventTouchUpInside];
    
    self.labelResultColor.text = @"Color";
    
}
-(void)processButtonDidTaped{
    
    if (self.isValid){
        self.viewResultColor.backgroundColor = [UIColor
                                                colorWithRed:[self.textFieldRed.text floatValue]/255.0
                                                green:[self.textFieldGreen.text floatValue]/255.0
                                                blue:[self.textFieldBlue.text floatValue]/255.0
                                                alpha:1.0];
        self.labelResultColor.text = [self hexFromColor:self.viewResultColor.backgroundColor];
    }else{
        self.labelResultColor.text = @"Error";
        
    }
    for (int i = 4; i <= 8; i += 2) {
        [arrayOfViews[i] setText:@""];
        [arrayOfViews[i] resignFirstResponder];
        
    }
}
-(BOOL)isValid{
    NSCharacterSet *setOfDigits = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    for (int i = 4; i<=8; i += 2) {
        
        
        for (int j=0; j < [[arrayOfViews[i] text] length]; j++) {
        
            if (!([setOfDigits characterIsMember: [[arrayOfViews[i] text] characterAtIndex:j]])){
                return NO;
            }
        }
        
        if (([[arrayOfViews[i] text] intValue] >= 255) || ((int)[[arrayOfViews[i] text] intValue] <= 0)){
            return NO;
        }
    }
    return YES;
}
- (NSString *)hexFromColor:(UIColor *)color {
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    return [NSString stringWithFormat:@"0x%02X%02X%02X",
            (int)(r * 255),
            (int)(g * 255),
            (int)(b * 255)];
}
-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField{
    
   // if ([self.labelResultColor.text isEqualToString: @"Error"]) {
        self.labelResultColor.text = @"Color";
 //   }
    return YES;
}
-(void)viewWillLayoutSubviews{
    [self.buttonProcess setFrame:CGRectMake(self.view.bounds.size.width/2 - DEFAULT_WIDTH/2 , posYForButton, DEFAULT_WIDTH, DEFAULT_HEIGHT)];
}
@end
