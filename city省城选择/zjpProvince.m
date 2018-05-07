

#import "zjpProvince.h"

@implementation zjpProvince
-(instancetype)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if(self){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)provinceWithDict:(NSDictionary*)dict{
    return [[self alloc]initWithDict:dict];
}
@end
