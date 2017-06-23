//
//  TodaysReport.swift
//  Weather
//
//  Created by Ashish jha on 6/15/17.
//  Copyright © 2017 xyz. All rights reserved.
//

import Foundation
import UIKit


struct TodaysReport {
    
    var currentTime: String?
    var temperature: Int
    var humidity: Double
    var precipProbability: Double
    var summary: String
    var icon: UIImage
    var windSpeed: Double

    init (weatherDictionary: NSDictionary) {
        
        let currentWeather = weatherDictionary["currently"] as! NSDictionary
        temperature =  fahrenheitToCelsius(currentWeather["temperature"] as! Int)
        humidity = currentWeather["humidity"]as! Double
        precipProbability = currentWeather["precipProbability"] as! Double
        summary = currentWeather["summary"]as! String
        windSpeed = currentWeather["windSpeed"]as! Double
        let currentTimeIntValue = currentWeather["time"]as! Int
        currentTime = dateStringFromUnixtime(currentTimeIntValue)
        let iconString = currentWeather["icon"]as! String
        icon = weatherIconFromString(iconString)
    }
}

//Use images based on weather type
func weatherIconFromString(_ stringIcon: String) -> UIImage {
    
    var imageName: String
    
    switch stringIcon {
        case "clear-day":
            imageName = "clear-day"
        case "clear-night":
            imageName = "clear-night"
        case "rain":
            imageName = "rain"
        case "snow":
            imageName = "snow"
        case "sleet":
            imageName = "sleet"
        case "wind":
            imageName = "wind"
        case "fog":
            imageName = "fog"
        case "cloudy":
            imageName = "cloudy"
        case "partly-cloudy-day":
            imageName = "partly-cloudy"
        case "partly-cloudy-night":
            imageName = "cloudy-night"
        default:
            imageName = "default"
    }
    
    let iconImage = UIImage(named: imageName)
    return iconImage!
}















