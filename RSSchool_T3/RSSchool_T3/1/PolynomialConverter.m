#import "PolynomialConverter.h"


@implementation PolynomialConverter
- (NSString *)elementToString: (NSNumber *)element isFirst:(BOOL) isFirst{
    NSMutableString *tempString;
    BOOL isOne = (abs( [element intValue]) == 1);
    tempString = [NSMutableString new];
    if ([element intValue] < 0) {
        if (isFirst) {
            return !isOne ? [NSString stringWithFormat:@"-%d",([element intValue])] : @"";
        }else{
            return !isOne ? [NSString stringWithFormat:@" - %d",(abs([element intValue]))] : @" - ";
            
        }
        
    }else if ([element intValue] > 1){
        if (isFirst) {
           return !isOne ? [NSString stringWithFormat:@"%d",([element intValue])] : @"";
        }else{
            return !isOne ? [NSString stringWithFormat:@" + %d",([element intValue])] : @" + ";
        }
    }else {
        return @"";
    }
return tempString;
}
- (NSString *)addPow: (int) pow to: (NSString *) element {
    if (pow > 1) {
        return [NSString stringWithFormat:@"%@x^%d",element,pow];
    }else if (pow == 1){
        return [NSString stringWithFormat:@"%@x",element];
    }else{
        return element;
    }
}
- (NSString*)convertToStringFrom:(NSArray <NSNumber*>*)numbers {
    NSMutableString *tempString = [NSMutableString new];
    if ([numbers count] > 0){
    for (int i = 0; i < [numbers count]; i++) {
        BOOL isFirst;
        isFirst = (i == 0);
        if ([numbers[i] intValue] != 0){
            [tempString appendString:[self addPow:([numbers count] - i - 1) to:[self elementToString:numbers[i] isFirst:isFirst]]];
        }
    };
    return tempString;
    }else{
        return nil;
    }
}
@end
