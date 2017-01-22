//
//  HomeViewController.swift
//  WeatherInformant
//
//  Created by Ramsay on 20/01/17.
//  Copyright © 2017 Ramsay.dummyIOS. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON

class HomeViewController: UITableViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var mintemperatureLabel: UILabel!
    @IBOutlet weak var maxtemperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherDescLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    var locationManager = CLLocationManager()
    
       override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            self.locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //setup slide out menu
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation:CLLocation = locations[0]
       
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 10000, 10000)
        mapView.setRegion(coordinateRegion, animated: true)
        
        WeatherService.getWeatherFor(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude, completionHandler: self.displayWeather(jsonData:), errorHandler: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func slideOutBarButtonClicked(_ sender: Any) {
        
        self.revealViewController()?.revealToggle(self)
    }
    
    func displayWeather(jsonData: JSON?){
        
        if let json = jsonData{
            
            self.temperatureLabel.text = json["main"]["temp"].rawString() == "null" ? "not available" : json["main"]["temp"].rawString()
            
            self.mintemperatureLabel.text = json["main"]["temp_min"].rawString() == "null" ? "not available" : json["main"]["temp_min"].rawString()
            
            self.maxtemperatureLabel.text = json["main"]["temp_max"].rawString() == "null" ? "not available" : json["main"]["temp_max"].rawString()
            
            self.humidityLabel.text = json["main"]["humidity"].rawString() == "null" ? "not available" : json["main"]["humidity"].rawString()
            
            self.weatherLabel.text = json["weather"][0]["main"].description
            
            self.weatherDescLabel.text = json["weather"][0]["description"].description
            
            self.windSpeedLabel.text = json["wind"]["speed"].description
        }
    }
    
}

