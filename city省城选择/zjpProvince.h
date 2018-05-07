

#import <Foundation/Foundation.h>

@interface zjpProvince : NSObject
@property(nonatomic,copy)NSString *name;//省份
@property(nonatomic,strong)NSArray *cities;//城市

//
-(instancetype)initWithDict:(NSDictionary*)dict;
+(instancetype)provinceWithDict:(NSDictionary*)dict;
@end
