//
//  WeatherService.swift
//  WeatherInformant
//
//  Created by Ramsay on 22/01/17.
//  Copyright © 2017 Ramsay.dummyIOS. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireSwiftyJSON
import SwiftyJSON

class WeatherService{
    
    
    static var baseUrl = "http://api.openweathermap.org/data/2.5/weather?APPID=6b74e26caf0461b48081154d453ccc2b&units=metric"
    
    
    static func getWeatherFor(latitude : Double, longitude : Double, completionHandler : ((JSON?) -> Void)? = nil, errorHandler : ((String?) -> Void)? = nil ){
        
        let url = baseUrl + "&lat=" + "\(latitude)" + "&lon=" + "\(longitude)"
    
    
        Alamofire.request(url).responseSwiftyJSON{
            
            (response) in
            
            print(response)
            
            if response.error != nil{
                
                errorHandler?(response.error?.localizedDescription)
            }
            else {
                
                completionHandler?(response.value)
            }
        }
    }
    
}

