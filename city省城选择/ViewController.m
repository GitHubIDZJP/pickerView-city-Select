

#import "ViewController.h"
#import "zjpProvince.h"
@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *zjpPicker;

@property (weak, nonatomic) IBOutlet UILabel *shengFen;//省
@property (weak, nonatomic) IBOutlet UILabel *chengShi;//市
@property(nonatomic,strong)NSArray *province;
//用来保存每次刷新后新选择的省
@property(nonatomic,strong)zjpProvince *zjpNewSelPro;

@end

@implementation ViewController
-(NSArray*)province{
    if(!_province){
        //加载字典数组
        NSArray *dictArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"City.plist" ofType:nil ]];
                            
        //再转为模型数组
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:dictArr.count];//临时数组
        for(NSDictionary* dict in dictArr){
            zjpProvince *pro = [zjpProvince provinceWithDict:dict];
            [arrM addObject:pro];
        }
        //赋值
        _province = arrM;
    }
    return _province;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   //默认选中
    [self pickerView:self.zjpPicker didSelectRow:0 inComponent:0];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //如果选择的第0组--省，则刷新城市
    if(component == 0){
        [pickerView reloadComponent:1];//刷新省
        //去选择第1组城市第0行
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    //显示文字内容
       //获取省/市索引
    NSInteger selProIdex =   [pickerView selectedRowInComponent:0];
     NSInteger selCityIdex =   [pickerView selectedRowInComponent:1];
    //从集合中取数据
    zjpProvince *selectPro =  self.province[selProIdex];
   //NSString *selectCity = selectPro.cities[selCityIdex];
    NSString *selectCity = self.zjpNewSelPro.cities[selCityIdex];
    //赋值
    self.shengFen.text = selectPro.name;
    self.chengShi.text = selectCity;
    NSLog(@"省份:%@---城市:%@",selectPro.name,selectCity);
    
}
#pragma mark 代理方法---显示每一行显示的文字
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
   
    
    NSInteger selProIdex = [pickerView selectedRowInComponent:0];
    NSLog(@"%ld",selProIdex);//每次省到了中间就会显示
    //第0组--省，返回省模型的name
    if(component == 0){
    zjpProvince *pro   =    self.province[row];
        return pro.name;
    }else{
         //第1组--市，把省里面所有城市返回
       //NSInteger selProIdex = [pickerView selectedRowInComponent:0];
      //  zjpProvince *selPro = self.province[selProIdex];
        //return selPro.cities[row];
        return self.zjpNewSelPro.cities[row];
        
    }
   
}
#pragma mark 数据源方法-多少组
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
#pragma mark 数据源方法-每组的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
   /****二级联动****/
 //   return   [self.province[component] count];
    //如果是第0组---省，行数就是模型的数组的数量
    if(component == 0){
        return self.province.count;
    }else{
           //如果是第1组---市，行数
        //1 获取第0组省显示的哪个省
        //先获取第0组显示的行号
     NSInteger selProIdex =    [pickerView selectedRowInComponent:0];
        //从集合中获取数据
     zjpProvince *selPro  =   self.province[selProIdex];
      //把新的省保存起来
        self.zjpNewSelPro = selPro;
        return self.zjpNewSelPro.cities.count;
        //根据省的城市数据去确实城市的行数
      //  return selPro.cities.count;
        
    }
 
}





@end
