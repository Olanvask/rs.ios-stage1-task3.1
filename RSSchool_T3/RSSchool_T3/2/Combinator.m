#import "Combinator.h"

@implementation Combinator
- (long)factorial: (long)number{
    if (number == 1){
        return 1;
    }else{
        return [self factorial:number-1] * number;
        
    }
    
}
- (NSNumber*)chechChooseFromArray:(NSArray <NSNumber*>*)array {
    if ([array count] == 2) {
        
        long n = [array[1] intValue];
        long m = [array[0] intValue];
        long k = 1;
        while (k < n) {
            if ([self factorial:n]/([self factorial:(n-k)]*[self factorial:k]) >= m){
               // [setArray addObject:[NSNumber numberWithLong:k]];
                return [NSNumber numberWithLong:k];
            }
            k++;
        }
        return nil;
        
    }else{
    return nil;
    }
    
}
@end
