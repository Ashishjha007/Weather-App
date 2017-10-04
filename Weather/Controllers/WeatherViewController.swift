//
//  WeatherDataSource.swift
//  Weather
//
//  Created by Ashish jha on 6/15/17.
//  Copyright © 2017 xyz. All rights reserved.
//
// added to github

import UIKit
import AVFoundation
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {

    //Current Weather outlets
    @IBOutlet weak var windBag: UIImageView!
    @IBOutlet weak var umbrella: UIImageView!
    @IBOutlet weak var rainDrop: UIImageView!
    @IBOutlet weak var userLocationLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!

    @IBOutlet weak var degreeButton: UIButton!
    @IBOutlet weak var dayZeroTemperatureLowLabel: UILabel!
    @IBOutlet weak var dayZeroTemperatureHighLabel: UILabel!

    @IBOutlet weak var windUILabel: UILabel!
    @IBOutlet weak var rainUILabel: UILabel!
    @IBOutlet weak var humidityUILabel: UILabel!

    //Weekly Weather outlets
    @IBOutlet weak var dayZeroTemperatureLow: UILabel!
    @IBOutlet weak var dayZeroTemperatureHigh: UILabel!

    @IBOutlet weak var dayOneWeekDayLabel: UILabel!
    @IBOutlet weak var dayOneHighLow: UILabel!
    @IBOutlet weak var dayOneImage: UIImageView!

    @IBOutlet weak var dayTwoWeekDayLabel: UILabel!
    @IBOutlet weak var dayTwoHighLow: UILabel!
    @IBOutlet weak var dayTwoImage: UIImageView!

    @IBOutlet weak var dayThreeWeekDayLabel: UILabel!
    @IBOutlet weak var dayThreeHighLow: UILabel!
    @IBOutlet weak var dayThreeImage: UIImageView!

    @IBOutlet weak var dayFourWeekDayLabel: UILabel!
    @IBOutlet weak var dayFourHighLow: UILabel!
    @IBOutlet weak var dayFourImage: UIImageView!

    @IBOutlet weak var dayFiveWeekDayLabel: UILabel!
    @IBOutlet weak var dayFiveHighLow: UILabel!
    @IBOutlet weak var dayFiveImage: UIImageView!

    @IBOutlet weak var daySixWeekDayLabel: UILabel!
    @IBOutlet weak var daySixHighLow: UILabel!
    @IBOutlet weak var daySixImage: UIImageView!

    var locationStatus: NSString = "Not Started"
    var locationManager: CLLocationManager!
    var userLocation: String!
    var userLatitude: Double!
    var userLongitude: Double!

    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureViews()
    }

    //Intialize location manager
    func initializeLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: { (placemarks, error) -> Void in

            if let pm = placemarks {
                self.displayLocationInfo(pm[0])
            }
        })
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        let coord = locationObj.coordinate
        self.userLatitude = coord.latitude
        self.userLongitude = coord.longitude

        getCurrentWeatherData()
    }

    func displayLocationInfo(_ placemark: CLPlacemark?) {
        if let containsPlacemark = placemark {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
            let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
            self.userLocationLabel.text = "\(locality!), \(administrativeArea!)"
            self.userLocationLabel.font = getFont(font: .userLocationLabelTextFont)
            self.userLocationLabel.textColor = getColor(font: .userLocationLabelTextColor)
        }
    }

    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        var shouldUpdate = false
        switch status {
        case CLAuthorizationStatus.restricted:
            locationStatus = "Restricted Access to location"
        case CLAuthorizationStatus.denied:
            locationStatus = "User denied access to location"
        case CLAuthorizationStatus.notDetermined:
            locationStatus = "Status not determined"
        default:
            locationStatus = "Allowed to location Access"
            shouldUpdate = true
        }
        if (shouldUpdate == true) {
            // Start location manager services
            locationManager.startUpdatingLocation()
        } else {
            NSLog("Denied access: \(locationStatus)")
        }
    }

    func getCurrentWeatherData() -> Void {

        userLocation = "\(self.userLatitude!),\(self.userLongitude!)"

        fetchWeatherReport(userLocation) { (response) in
            if let weatherDictionary = response {

                let currentWeather = TodaysReport(weatherDictionary: weatherDictionary)
                let weeklyWeather = WeeklyReport(weatherDictionary: weatherDictionary)

                DispatchQueue.main.async(execute: { () -> Void in
                    // Todays weather data
                    self.temperatureLabel.text = "\(currentWeather.temperature)"
                    self.temperatureLabel.font = getFont(font: .temperatureLabelTextFont)
                    self.temperatureLabel.textColor = getColor(font: .temperatureLabelTextColor)
                    self.iconView.image = currentWeather.icon

                    self.humidityLabel.text = "\(currentWeather.humidity)"
                    self.humidityLabel.font = getFont(font: .humidityLabelTextFont)
                    self.humidityLabel.textColor = getColor(font: .humidityLabelTextColor)

                    self.precipitationLabel.text = "\(currentWeather.precipProbability)"
                    self.precipitationLabel.font = getFont(font: .rainLabelTextFont)
                    self.precipitationLabel.textColor = getColor(font: .rainLabelTextColor)

                    self.summaryLabel.text = "\(currentWeather.summary)"
                    self.summaryLabel.font = getFont(font: .summaryLabelTextFont)
                    self.summaryLabel.textColor = getColor(font: .summaryLabelTextColor)

                    self.windSpeedLabel.text = "\(currentWeather.windSpeed)"
                    self.windSpeedLabel.font = getFont(font: .windLabelTextFont)
                    self.windSpeedLabel.textColor = getColor(font: .windLabelTextColor)

                    self.dayZeroTemperatureHigh.text = "\(weeklyWeather.dayZeroTemperatureMax)"
                    self.dayZeroTemperatureHigh.font = getFont(font: .maxTempLabelTextFont)
                    self.dayZeroTemperatureHigh.textColor = getColor(font: .maxTempLabelTextColor)

                    self.dayZeroTemperatureLow.text = "\(weeklyWeather.dayZeroTemperatureMin)"
                    self.dayZeroTemperatureLow.font = getFont(font: .minTempLabelTextFont)
                    self.dayZeroTemperatureLow.textColor = getColor(font: .minTempLabelTextColor)

                    // Weekly weather data
                    self.dayOneHighLow.text = "\(weeklyWeather.dayOneTemperatureMin)°/ \(weeklyWeather.dayOneTemperatureMax)°"
                    self.dayOneHighLow.font = getFont(font: .weeklyTempLabelTextFont)
                    self.dayOneHighLow.textColor = getColor(font: .weeklyTempLabelTextColor)

                    self.dayTwoHighLow.text = "\(weeklyWeather.dayTwoTemperatureMin)°/ \(weeklyWeather.dayTwoTemperatureMax)°"
                    self.dayTwoHighLow.font = getFont(font: .weeklyTempLabelTextFont)
                    self.dayTwoHighLow.textColor = getColor(font: .weeklyTempLabelTextColor)

                    self.dayThreeHighLow.text = "\(weeklyWeather.dayThreeTemperatureMin)°/ \(weeklyWeather.dayThreeTemperatureMax)°"
                    self.dayThreeHighLow.font = getFont(font: .weeklyTempLabelTextFont)
                    self.dayThreeHighLow.textColor = getColor(font: .weeklyTempLabelTextColor)

                    self.dayFourHighLow.text = "\(weeklyWeather.dayFourTemperatureMin)°/ \(weeklyWeather.dayFourTemperatureMax)°"
                    self.dayFourHighLow.font = getFont(font: .weeklyTempLabelTextFont)
                    self.dayFourHighLow.textColor = getColor(font: .weeklyTempLabelTextColor)

                    self.dayFiveHighLow.text = "\(weeklyWeather.dayFiveTemperatureMin)°/ \(weeklyWeather.dayFiveTemperatureMax)°"
                    self.dayFiveHighLow.font = getFont(font: .weeklyTempLabelTextFont)
                    self.dayFiveHighLow.textColor = getColor(font: .weeklyTempLabelTextColor)

                    self.daySixHighLow.text = "\(weeklyWeather.daySixTemperatureMin)°/ \(weeklyWeather.daySixTemperatureMax)°"
                    self.daySixHighLow.font = getFont(font: .weeklyTempLabelTextFont)
                    self.daySixHighLow.textColor = getColor(font: .weeklyTempLabelTextColor)

                    // week day data
                    self.dayOneWeekDayLabel.text = "\(weeklyWeather.dayOneName!)"
                    self.dayOneWeekDayLabel.font = getFont(font: .weekDaysLabelTextFont)
                    self.dayOneWeekDayLabel.textColor = getColor(font: .weekDaysLabelTextColor)
                    self.dayOneImage.image = weeklyWeather.dayOneIcon

                    self.dayTwoWeekDayLabel.text = "\(weeklyWeather.dayTwoName!)"
                    self.dayOneWeekDayLabel.font = getFont(font: .weekDaysLabelTextFont)
                    self.dayOneWeekDayLabel.textColor = getColor(font: .weekDaysLabelTextColor)
                    self.dayTwoImage.image = weeklyWeather.dayTwoIcon

                    self.dayThreeWeekDayLabel.text = "\(weeklyWeather.dayThreeName!)"
                    self.dayThreeWeekDayLabel.font = getFont(font: .weekDaysLabelTextFont)
                    self.dayThreeWeekDayLabel.textColor = getColor(font: .weekDaysLabelTextColor)
                    self.dayThreeImage.image = weeklyWeather.dayThreeIcon

                    self.dayFourWeekDayLabel.text = "\(weeklyWeather.dayFourName!)"
                    self.dayFourWeekDayLabel.font = getFont(font: .weekDaysLabelTextFont)
                    self.dayFourWeekDayLabel.textColor = getColor(font: .weekDaysLabelTextColor)
                    self.dayFourImage.image = weeklyWeather.dayFourIcon

                    self.dayFiveWeekDayLabel.text = "\(weeklyWeather.dayFiveName!)"
                    self.dayFiveWeekDayLabel.font = getFont(font: .weekDaysLabelTextFont)
                    self.dayFiveWeekDayLabel.textColor = getColor(font: .weekDaysLabelTextColor)
                    self.dayFiveImage.image = weeklyWeather.dayFiveIcon

                    self.daySixWeekDayLabel.text = "\(weeklyWeather.daySixName!)"
                    self.daySixWeekDayLabel.font = getFont(font: .weekDaysLabelTextFont)
                    self.daySixWeekDayLabel.textColor = getColor(font: .weekDaysLabelTextColor)
                    self.daySixImage.image = weeklyWeather.dayFiveIcon

                })

            } else {

                let networkIssueController = UIAlertController(title: "ALERT", message: "Please check your internet connectivity.", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                networkIssueController.addAction(okButton)
                self.present(networkIssueController, animated: true, completion: nil)
            }
        }
    }

    func configureViews() {

        initializeLocationManager()

        self.temperatureLabel.alpha = 0
        self.dayOneImage.alpha = 0
        self.dayTwoImage.alpha = 0
        self.dayThreeImage.alpha = 0
        self.dayFourImage.alpha = 0
        self.dayFiveImage.alpha = 0
        self.daySixImage.alpha = 0
        self.dayZeroTemperatureLow.alpha = 0
        self.dayZeroTemperatureHigh.alpha = 0
        self.windSpeedLabel.alpha = 0
        self.humidityLabel.alpha = 0
        self.precipitationLabel.alpha = 0
        self.rainUILabel.alpha = 0
        self.dayOneWeekDayLabel.alpha = 0
        self.dayOneHighLow.alpha = 0
        self.dayTwoWeekDayLabel.alpha = 0
        self.dayTwoHighLow.alpha = 0
        self.dayThreeWeekDayLabel.alpha = 0
        self.dayThreeHighLow.alpha = 0
        self.dayFourWeekDayLabel.alpha = 0
        self.dayFourHighLow.alpha = 0
        self.dayFiveWeekDayLabel.alpha = 0
        self.dayFiveHighLow.alpha = 0
        self.daySixWeekDayLabel.alpha = 0
        self.daySixHighLow.alpha = 0

        self.weeklyForcastAnimation()

        UIView.animate(withDuration: 1.5, animations: {
            self.temperatureLabel.alpha = 1.0
            self.dayOneImage.alpha = 1.0
            self.dayTwoImage.alpha = 1.0
            self.dayThreeImage.alpha = 1.0
            self.dayFourImage.alpha = 1.0
            self.dayFiveImage.alpha = 1.0
            self.daySixImage.alpha = 1.0
            self.dayZeroTemperatureLow.alpha = 1.0
            self.dayZeroTemperatureHigh.alpha = 1.0
            self.windSpeedLabel.alpha = 1.0
            self.humidityLabel.alpha = 1.0
            self.precipitationLabel.alpha = 1.0
            self.rainUILabel.alpha = 1.0
            self.dayOneWeekDayLabel.alpha = 1.0
            self.dayOneHighLow.alpha = 1.0
            self.dayTwoWeekDayLabel.alpha = 1.0
            self.dayTwoHighLow.alpha = 1.0
            self.dayThreeWeekDayLabel.alpha = 1.0
            self.dayThreeHighLow.alpha = 1.0
            self.dayFourWeekDayLabel.alpha = 1.0
            self.dayFourHighLow.alpha = 1.0
            self.dayFiveWeekDayLabel.alpha = 1.0
            self.dayFiveHighLow.alpha = 1.0
            self.daySixWeekDayLabel.alpha = 1.0
            self.daySixHighLow.alpha = 1.0
            //self.wAlerts.alpha = 1.0

        })
    }

    func weeklyForcastAnimation() {

        //TODAY
        self.dayZeroTemperatureLowLabel.transform = CGAffineTransform(translationX: -300, y: 0)
        self.dayZeroTemperatureHighLabel.transform = CGAffineTransform(translationX: 300, y: 0)
        self.windBag.transform = CGAffineTransform(translationX: 0, y: -600)
        self.umbrella.transform = CGAffineTransform(translationX: 0, y: -600)
        self.rainDrop.transform = CGAffineTransform(translationX: 0, y: -600)
        self.iconView.transform = CGAffineTransform(translationX: -200, y: 0)
        self.temperatureLabel.transform = CGAffineTransform(translationX: 300, y: 0)
        self.summaryLabel.transform = CGAffineTransform(translationX: 0, y: -200)
        self.userLocationLabel.transform = CGAffineTransform(translationX: 350, y: 0)
        self.windUILabel.transform = CGAffineTransform(translationX: -350, y: 0)
        self.humidityUILabel.transform = CGAffineTransform(translationX: 350, y: 0)

        //WEEKLY
        self.dayOneImage.transform = CGAffineTransform(translationX: 0, y: 100)
        self.dayTwoImage.transform = CGAffineTransform(translationX: 0, y: 100)
        self.dayThreeImage.transform = CGAffineTransform(translationX: 0, y: 100)
        self.dayFourImage.transform = CGAffineTransform(translationX: 0, y: 100)
        self.dayFiveImage.transform = CGAffineTransform(translationX: 0, y: 100)
        self.daySixImage.transform = CGAffineTransform(translationX: 0, y: 100)

        //DAILY SPRING ACTION

        springWithDelay(0.9, delay: 0.45, animations: {
            self.userLocationLabel.transform = CGAffineTransform(translationX: 0, y: 0)
        })

        springWithDelay(0.9, delay: 0.25, animations: {
            self.windBag.transform = CGAffineTransform(translationX: 0, y: 0)
        })
        springWithDelay(0.9, delay: 0.35, animations: {
            self.umbrella.transform = CGAffineTransform(translationX: 0, y: 0)
        })
        springWithDelay(0.9, delay: 0.45, animations: {
            self.rainDrop.transform = CGAffineTransform(translationX: 0, y: 0)
        })

        springWithDelay(0.9, delay: 0.45, animations: {
            self.iconView.transform = CGAffineTransform(translationX: 0, y: 0)
        })

        springWithDelay(0.9, delay: 0.45, animations: {
            self.temperatureLabel.transform = CGAffineTransform(translationX: 0, y: 0)
        })

        springWithDelay(0.9, delay: 0.60, animations: {
            self.summaryLabel.transform = CGAffineTransform(translationX: 0, y: 0)
        })

        springWithDelay(0.9, delay: 0.45, animations: {
            self.dayZeroTemperatureLowLabel.transform = CGAffineTransform(translationX: 0, y: 0)
        })

        springWithDelay(0.9, delay: 0.45, animations: {
            self.dayZeroTemperatureHighLabel.transform = CGAffineTransform(translationX: 0, y: 0)
        })

        springWithDelay(0.9, delay: 0.45, animations: {
            self.userLocationLabel.transform = CGAffineTransform(translationX: 0, y: 0)
        })

        springWithDelay(0.9, delay: 0.45, animations: {
            self.windUILabel.transform = CGAffineTransform(translationX: 0, y: 0)
        })


        springWithDelay(0.9, delay: 0.45, animations: {
            self.humidityUILabel.transform = CGAffineTransform(translationX: 0, y: 0)
        })


        //WEEKLY FORCAST SPRING ACTION
        springWithDelay(0.9, delay: 0.25, animations: {
            self.dayOneImage.transform = CGAffineTransform(translationX: 0, y: 0)
        })

        springWithDelay(0.9, delay: 0.35, animations: {
            self.dayTwoImage.transform = CGAffineTransform(translationX: 0, y: 0)
        })

        springWithDelay(0.9, delay: 0.45, animations: {
            self.dayThreeImage.transform = CGAffineTransform(translationX: 0, y: 0)
        })

        springWithDelay(0.9, delay: 0.55, animations: {
            self.dayFourImage.transform = CGAffineTransform(translationX: 0, y: 0)
        })

        springWithDelay(0.9, delay: 0.65, animations: {
            self.dayFiveImage.transform = CGAffineTransform(translationX: 0, y: 0)
        })

        springWithDelay(0.9, delay: 0.75, animations: {
            self.daySixImage.transform = CGAffineTransform(translationX: 0, y: 0)

        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
}

