//
//  WeeklyReport.swift
//  Weather
//
//  Created by Ashish jha on 6/15/17.
//  Copyright © 2017 xyz. All rights reserved.
//

import Foundation
import UIKit

struct WeeklyReport {
    
    var dayZeroTemperatureMax: Int
    var dayZeroTemperatureMin: Int

    var dayOneTemperatureMax: Int
    var dayOneTemperatureMin: Int
    var dayOneName: String?
    var dayOneIcon: UIImage?
    
    var dayTwoTemperatureMax: Int
    var dayTwoTemperatureMin: Int
    var dayTwoName: String?
    var dayTwoIcon: UIImage?
    
    var dayThreeTemperatureMax: Int
    var dayThreeTemperatureMin: Int
    var dayThreeName: String?
    var dayThreeIcon: UIImage?
    
    var dayFourTemperatureMax: Int
    var dayFourTemperatureMin: Int
    var dayFourName: String?
    var dayFourIcon: UIImage?
    
    var dayFiveTemperatureMax: Int
    var dayFiveTemperatureMin: Int
    var dayFiveName: String?
    var dayFiveIcon: UIImage?

    var daySixTemperatureMax: Int
    var daySixTemperatureMin: Int
    var daySixName: String?
    var daySixIcon: UIImage?
    
    init (weatherDictionary: NSDictionary) {
        
        let weeklyWeather = weatherDictionary["daily"] as! NSDictionary
        let weeklyForcast = weeklyWeather["data"] as? NSArray
        let dayZero = weeklyForcast?[0] as? [String: Any]
        dayZeroTemperatureMax =  fahrenheitToCelsius(dayZero?["temperatureMax"] as! Int)
        dayZeroTemperatureMin = fahrenheitToCelsius(dayZero?["temperatureMin"] as! Int)
        
        //DAY ONE
        let dayOne = weeklyForcast?[1] as? [String: Any]
        dayOneTemperatureMax = fahrenheitToCelsius(dayOne?["temperatureMax"] as! Int)
        dayOneTemperatureMin = fahrenheitToCelsius(dayOne?["temperatureMin"] as! Int)
        let dayOneTimeIntValue = dayOne?["sunriseTime"] as! Int
        dayOneName = weekDateStringFromUnixtime(dayOneTimeIntValue)
        let dayOneIconString = dayOne?["icon"] as! String
        dayOneIcon = weatherIconFromString(dayOneIconString)
            
        //DAY TWO
        let dayTwo = weeklyForcast?[2] as? [String: Any]
                
        dayTwoTemperatureMax = fahrenheitToCelsius(dayTwo?["temperatureMax"] as! Int)
        dayTwoTemperatureMin = fahrenheitToCelsius(dayTwo?["temperatureMin"] as! Int)
        let dayTwoTimeIntValue = dayTwo?["sunriseTime"] as! Int
        dayTwoName = weekDateStringFromUnixtime(dayTwoTimeIntValue)
        let dayTwoIconString = dayTwo?["icon"] as! String
        dayTwoIcon = weatherIconFromString(dayTwoIconString)
        
        //DAY THREE
        let dayThree = weeklyForcast?[3] as? [String: Any]
        dayThreeTemperatureMax = fahrenheitToCelsius(dayThree?["temperatureMax"] as! Int)
        dayThreeTemperatureMin = fahrenheitToCelsius(dayThree?["temperatureMin"] as! Int)
        let dayThreeTimeIntValue = dayThree?["sunriseTime"] as! Int
        dayThreeName = weekDateStringFromUnixtime(dayThreeTimeIntValue)
        let dayThreeIconString = dayThree?["icon"] as! String
        dayThreeIcon = weatherIconFromString(dayThreeIconString)
        
        //DAY FOUR
        let dayFour = weeklyForcast?[4] as? [String: Any]
        dayFourTemperatureMax = fahrenheitToCelsius(dayFour?["temperatureMax"] as! Int)
        dayFourTemperatureMin = fahrenheitToCelsius(dayFour?["temperatureMin"] as! Int)
        let dayFourTimeIntValue = dayFour?["sunriseTime"] as! Int
        dayFourName = weekDateStringFromUnixtime(dayFourTimeIntValue)
        let dayFourIconString = dayFour?["icon"] as! String
        dayFourIcon = weatherIconFromString(dayFourIconString)

        //DAY FIVE
        let dayFive = weeklyForcast?[5] as? [String: Any] //{
        dayFiveTemperatureMax = fahrenheitToCelsius(dayFive?["temperatureMax"] as! Int)
        dayFiveTemperatureMin = fahrenheitToCelsius(dayFive?["temperatureMin"] as! Int)
        let dayFiveTimeIntValue = dayFive?["sunriseTime"] as! Int
        dayFiveName = weekDateStringFromUnixtime(dayFiveTimeIntValue)
        let dayFiveIconString = dayFive?["icon"] as! String
        dayFiveIcon = weatherIconFromString(dayFiveIconString)

        //DAY SIX
        let daySix = weeklyForcast?[6] as? [String: Any] //{
        daySixTemperatureMax = fahrenheitToCelsius(daySix?["temperatureMax"] as! Int)
        daySixTemperatureMin = fahrenheitToCelsius(daySix?["temperatureMin"] as! Int)
        let daySixTimeIntValue = daySix?["sunriseTime"] as! Int
        daySixName = weekDateStringFromUnixtime(daySixTimeIntValue)
        let daySixIconString = daySix?["icon"] as! String
        daySixIcon = weatherIconFromString(daySixIconString)
    }
}



