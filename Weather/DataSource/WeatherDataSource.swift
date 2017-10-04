//
//  WeatherDataSource.swift
//  Weather
//
//  Created by Ashish jha on 6/15/17.
//  Copyright © 2017 xyz. All rights reserved.
//

import Foundation

func fetchWeatherReport (_ location: String, callback: @escaping (NSDictionary?) -> ()) {

    let apiKey = "19c994d2ac36e22d2a9a6fcf9e3cd788"

    let foresastURL = URL(string: "https://api.forecast.io/forecast/" + apiKey + "/" + location)

    let sharedSession = URLSession.shared

    let downloadTask: URLSessionDownloadTask = sharedSession.downloadTask(with: foresastURL!, completionHandler: { (location, response, error) -> Void in

        var weatherDataDictionary: NSDictionary?
        if (error == nil) {

            let dataObject = try? Data(contentsOf: location!)
            weatherDataDictionary = (try! JSONSerialization.jsonObject(with: dataObject!, options: [])) as? NSDictionary
        }
        callback(weatherDataDictionary)
    })
    downloadTask.resume()
}

