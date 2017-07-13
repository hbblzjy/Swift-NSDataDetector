//
//  ViewController.m
//  NSDataDetector
//
//  Created by JasonHao on 2017/7/12.
//  Copyright © 2017年 JasonHao. All rights reserved.
//

#import "ViewController.h"
#import "NSDataDetector-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加右侧按钮
    UIBarButtonItem *registerRightItem = [[UIBarButtonItem alloc] initWithTitle:@"Swift" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
    self.navigationItem.rightBarButtonItem = registerRightItem;
    
    
    //检测是否是有链接地址 或 电话号码，并输出匹配结果
    //（注意：字符串的设置要将不同的内容用 空格 进行分割，否则内容会被看成整体，从而无法识别）
    NSString *testStr = @"123 Hello World！ www.baidu.com Stt. / 18337101863 sdfgrge";
    
    //初始化检测，设置NSTextCheckingType类型
    /*
     NSTextCheckingTypes:一种是系统的，一种是自定义的
     部分系统的：
     typedef NS_OPTIONS(uint64_t, NSTextCheckingType) {    // a single type
     NSTextCheckingTypeOrthography           = 1ULL << 0,            // language identification
     NSTextCheckingTypeSpelling              = 1ULL << 1,            // spell checking
     NSTextCheckingTypeGrammar               = 1ULL << 2,            // grammar checking
     NSTextCheckingTypeDate                  = 1ULL << 3,            // date/time detection
     NSTextCheckingTypeAddress               = 1ULL << 4,            // address detection
     NSTextCheckingTypeLink                  = 1ULL << 5,            // link detection
     NSTextCheckingTypeQuote                 = 1ULL << 6,            // smart quotes
     NSTextCheckingTypeDash                  = 1ULL << 7,            // smart dashes
     NSTextCheckingTypeReplacement           = 1ULL << 8,            // fixed replacements, such as copyright symbol for (c)
     NSTextCheckingTypeCorrection            = 1ULL << 9,            // autocorrection
     NSTextCheckingTypeRegularExpression NS_ENUM_AVAILABLE(10_7, 4_0)  = 1ULL << 10,           // regular expression matches
     NSTextCheckingTypePhoneNumber NS_ENUM_AVAILABLE(10_7, 4_0)        = 1ULL << 11,           // phone number detection
     NSTextCheckingTypeTransitInformation NS_ENUM_AVAILABLE(10_7, 4_0) = 1ULL << 12            // transit (e.g. flight) info detection
     };
     
     */
    NSError *error = nil;
    //(注意：当初始化NSDataDetector的时候，只指定自己需要的类型（Type）就可以了，因为多增加一项就会多一些内存的开销。)
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink | NSTextCheckingTypePhoneNumber error:&error];
    
    //---------------- 有多种方法检测匹配的数据
    //1.检测然后对每个检测到的数据进行操作
    //- (void)enumerateMatchesInString:(NSString *)string options:(NSMatchingOptions)options range:(NSRange)range usingBlock:(void (^)(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop))block;
    //2.检测获得检测得到的数组
    //- (NSArray *)matchesInString:(NSString *)string options:(NSMatchingOptions)options range:(NSRange)range;
    //3.获得检测得到的总数
    //- (NSUInteger)numberOfMatchesInString:(NSString *)string options:(NSMatchingOptions)options range:(NSRange)range;
    //4.第一个检测到的数据
    //- (NSTextCheckingResult *)firstMatchInString:(NSString *)string options:(NSMatchingOptions)options range:(NSRange)range;
    //5.第一检测到的数据的Range
    //- (NSRange)rangeOfFirstMatchInString:(NSString *)string options:(NSMatchingOptions)options range:(NSRange)range;
    
    //方法一:使用block块，输出匹配的结果
    [detector enumerateMatchesInString:testStr options:kNilOptions range:NSMakeRange(0, [testStr length]) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {

        //NSTextCheckingResult有很多属性，和检测的类型相匹配，如URL，phoneNumber，date，addressComponents等等
        //NSTextCheckingResult还有range 和 resultType两个属性，方便进行操作
        if (result.resultType == NSTextCheckingTypeLink) {
            NSLog(@"方法一...检测是否是有 链接地址: %@", result);
            NSLog(@"方法一...链接地址 的范围: %@",NSStringFromRange(result.range));
            NSLog(@"方法一...链接地址: %@",result.URL);
        }
        if (result.resultType == NSTextCheckingTypePhoneNumber) {
            NSLog(@"方法一...检测是否是有 电话号码: %@", result);
            NSLog(@"方法一...电话号码 的范围: %@",NSStringFromRange(result.range));
            NSLog(@"方法一...电话号码: %@",result.phoneNumber);
        }
    }];
    //方法二：获取数组，输出检测结果
    NSArray *matchesArr = [detector matchesInString:testStr options:0 range:NSMakeRange(0, testStr.length)];//检测字符串
    for (NSTextCheckingResult *matchResult in matchesArr) {
        if (matchResult.resultType == NSTextCheckingTypeLink) {
            NSLog(@"方法二...检测是否是有 链接地址: %@", matchResult);
            NSLog(@"方法二...链接地址 的范围: %@",NSStringFromRange(matchResult.range));
            NSLog(@"方法二...链接地址: %@",matchResult.URL);
        }
        if (matchResult.resultType == NSTextCheckingTypePhoneNumber) {
            NSLog(@"方法二...检测是否是有 电话号码: %@", matchResult);
            NSLog(@"方法二...电话号码 的范围: %@",NSStringFromRange(matchResult.range));
            NSLog(@"方法二...电话号码: %@",matchResult.phoneNumber);
        }
    }
}
#pragma mark -----   rightItemClick
-(void)rightItemClick
{
    OneViewController *oneVC = [[OneViewController alloc] init];
    [self.navigationController pushViewController:oneVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
