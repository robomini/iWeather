//
//  ViewController.m
//  iWeather
//
//  Created by TienVV on 9/24/15.
//  Copyright (c) 2015 TienVV. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lbLocation;
@property (weak, nonatomic) IBOutlet UILabel *lbTempType;
@property (weak, nonatomic) IBOutlet UIButton *btnTemp;
@property (weak, nonatomic) IBOutlet UIImageView *imgWeather;
@property (weak, nonatomic) IBOutlet UILabel *lbWeatherDescription;
@property (weak, nonatomic) IBOutlet UILabel *lbQuote;
@property (weak, nonatomic) IBOutlet UIButton *btnRefresh;

@end

@implementation ViewController
{
    NSArray* locations;
    NSArray* iconWeathers;
    NSArray* weatherDescriptions;
    NSArray* quotes;
    
    bool tempTypeCelsius;
    // Sử dụng 2 biến lưu nhiệt độ C và F để tránh sai số khi convert qua lại giữa nhiệt độ C và F.
    // 2 Nhiệt độ này chỉ được khởi tạo cùng nhau.
    float temperatureC;
    float temperatureF;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Initiate constants data
    locations = @[@"Ha Noi, Viet Nam", @"London, England", @"Paris, France", @"Tokyo, Japan", @"New York, America"];
    iconWeathers = @[@"ic_cloudly", @"ic_heavy_rain", @"ic_rain", @"ic_sunny_cloudly", @"ic_sunny", @"ic_thunder"];
    weatherDescriptions = @[@"Cloudly", @"Heavy Rain", @"Rain", @"Sunny and Cloudly", @"Sunny", @"Thunderstorm"];
    quotes = @[@"Bầu ơi thương lấy bí cùng,\nTuy rằng khác giống nhưng chung một giàn.", @"Dù ai nói ngả nói nghiêng,\nLòng ta vẫn vững như kiềng ba chân.", @"Gió đưa cây cải về trời,\nRau răm ở lại, chịu lời đắng cay.", @"Làm trai cho đáng nên trai,\nKhom lưng chống gối gánh hai hạt vừng.", @"Ở đời muôn sự của chung,\nHơn nhau một tiếng anh hùng mà thôi."];
    
    // Default use Celsius temperature
    tempTypeCelsius = YES;
    self.lbTempType.text = @"C";
    
    // Initiate temperature
    [self generateTemperature];
    
    NSString* temperatureStr = [NSString stringWithFormat:@"%2.1f", temperatureC];
    [self.btnTemp setTitle:temperatureStr forState:UIControlStateNormal];
}

- (IBAction)onClickRefresh:(id)sender {
    // Refresh location
    int indexLocation = arc4random_uniform(locations.count);
    self.lbLocation.text = locations[indexLocation];
    
    // Refresh temperatures
    [self generateTemperature];
    float temp = 0;
    if (tempTypeCelsius == YES) {
        temp = temperatureC;
    } else {
        temp = temperatureF;
    }
    NSString* temperatureStr = [NSString stringWithFormat:@"%2.1f", temp];
    [self.btnTemp setTitle:temperatureStr forState:UIControlStateNormal];
    
    // Temperature type
    if (tempTypeCelsius == YES) {
        self.lbTempType.text = @"C";
    } else {
        self.lbTempType.text = @"F";
    }
    
    // Refresh icon weather and weather description
    int indexWeather = arc4random_uniform(iconWeathers.count);
    self.imgWeather.image = [UIImage imageNamed:iconWeathers[indexWeather]];
    self.lbWeatherDescription.text = weatherDescriptions[indexWeather];
    
    // Refresh quote
    int indexQuote = arc4random_uniform(quotes.count);
    self.lbQuote.text = quotes[indexQuote];
}

- (IBAction)onClickTemperature:(id)sender {
    if (tempTypeCelsius == YES) {
        // Convert C to F (Display temperature F)
        NSString* temperatureStr = [NSString stringWithFormat:@"%2.1f", temperatureF];
        [self.btnTemp setTitle:temperatureStr forState:UIControlStateNormal];
        
        tempTypeCelsius = NO;
    } else {
        // Convert F to C (Display temperature C)
        NSString* temperatureStr = [NSString stringWithFormat:@"%2.1f", temperatureC];
        [self.btnTemp setTitle:temperatureStr forState:UIControlStateNormal];
        
        tempTypeCelsius = YES;
    }
    // Temperature type
    if (tempTypeCelsius == YES) {
        self.lbTempType.text = @"C";
    } else {
        self.lbTempType.text = @"F";
    }
}

/**
 * Generate random temperature in C and F
 */
- (void) generateTemperature {
    temperatureC = (float) 14.0 + arc4random_uniform(18) + (float)arc4random() /(float) INT32_MAX;
    temperatureF = temperatureC * 9 / 2 + 32;
}

@end
