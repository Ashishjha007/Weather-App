//
//  FontConstants.swift
//  Weather
//
//  Created by Ashish jha on 6/16/17.
//  Copyright © 2017 xyz. All rights reserved.
//

import Foundation
import UIKit

enum LabelTextFont {
    case temperatureLabelTextFont
    case minTempLabelTextFont
    case maxTempLabelTextFont
    case weeklyTempLabelTextFont
    case weekDaysLabelTextFont
    case humidityLabelTextFont
    case windLabelTextFont
    case rainLabelTextFont
    case userLocationLabelTextFont
    case summaryLabelTextFont
}

func getFont(font : LabelTextFont) -> UIFont {
    
    switch font {
    case .temperatureLabelTextFont:
        return UIFont(name: "HelveticaNeue-Light", size: 90)!
    case .minTempLabelTextFont:
        return UIFont(name: "HelveticaNeue-Medium", size: 18)!
    case .maxTempLabelTextFont:
        return UIFont(name: "HelveticaNeue-Medium", size: 18)!
    case .weeklyTempLabelTextFont:
        return UIFont(name: "HelveticaNeue-Bold", size: 10)!
    case .weekDaysLabelTextFont:
        return UIFont(name: "HelveticaNeue-Bold", size: 16)!
    case .humidityLabelTextFont:
        return UIFont(name: "HelveticaNeue", size: 10)!
    case .windLabelTextFont:
        return UIFont(name: "HelveticaNeue", size: 10)!
    case .rainLabelTextFont:
        return UIFont(name: "HelveticaNeue", size: 10)!
    case .userLocationLabelTextFont:
        return UIFont(name: "HelveticaNeue", size: 18)!
    case .summaryLabelTextFont:
        return UIFont(name: "HelveticaNeue-Medium", size: 16)!
    }
}
