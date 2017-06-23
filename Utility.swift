//
//  Utility.swift
//  Weather
//
//  Created by Ashish jha on 6/16/17.
//  Copyright © 2017 xyz. All rights reserved.
//

import Foundation
import UIKit

// Date formatter to get week date
func weekDateStringFromUnixtime(_ time: Int) -> String {
    
    let timeInSeconds = TimeInterval(time)
    let weatherDate = Date(timeIntervalSince1970: timeInSeconds)
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEE"
    
    return dateFormatter.string(from: weatherDate)
}

// Date formatter to get days
func dateStringFromUnixtime(_ time: Int) -> String {

    let timeInSeconds = TimeInterval(time)
    let weatherDate = Date(timeIntervalSince1970: timeInSeconds)

    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = .medium

    return dateFormatter.string(from: weatherDate)
}

//Convert fahrenheit To Celsius
func fahrenheitToCelsius(_ f: Int) -> Int {
    
    return Int((Double(f)-32.0) / 1.8)
}

// Spring animation to animate views
func springWithDelay(_ duration: TimeInterval, delay: TimeInterval, animations: (() -> Void)!) {
    
    UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
        
        animations()
    }, completion: { finished in
    })
}
