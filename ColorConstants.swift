//
//  ColorConstants.swift
//  Weather
//
//  Created by Ashish jha on 6/16/17.
//  Copyright © 2017 xyz. All rights reserved.
//

import Foundation
import UIKit

enum LabelTextColor {
    case temperatureLabelTextColor
    case minTempLabelTextColor
    case maxTempLabelTextColor
    case weeklyTempLabelTextColor
    case weekDaysLabelTextColor
    case humidityLabelTextColor
    case windLabelTextColor
    case rainLabelTextColor
    case userLocationLabelTextColor
    case summaryLabelTextColor
}

func getColor(font : LabelTextColor) -> UIColor {
    
    switch font {
    case .temperatureLabelTextColor:
        return UIColor.white
    case .minTempLabelTextColor:
        return UIColor.green
    case .maxTempLabelTextColor:
        return UIColor.red
    case .weeklyTempLabelTextColor:
        return UIColor.white
    case .weekDaysLabelTextColor:
        return UIColor.white
    case .humidityLabelTextColor:
        return UIColor.white
    case .windLabelTextColor:
        return UIColor.white
    case .rainLabelTextColor:
        return UIColor.white
    case .userLocationLabelTextColor:
        return UIColor.white
    case .summaryLabelTextColor:
        return UIColor.white
    }
}
