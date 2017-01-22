//
//  WeatherInformantBackendService.swift
//  WeatherInformant
//
//  Created by Ramsay on 22/01/17.
//  Copyright © 2017 Ramsay.dummyIOS. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireSwiftyJSON
import SwiftyJSON

class WeatherInformantBackendService{
    
    
    static var baseUrl = "https://weather-informant.herokuapp.com/"
    
    
    static func getAllWeatherWidgets(completionHandler : (([JSON]?) -> Void)? = nil, errorHandler : ((String?) -> Void)? = nil ){
        
        let url = baseUrl + "weatherWidgets"
        
        Alamofire.request(url).responseSwiftyJSON{
            
            (response) in
            
            print(response)
            
            if response.error != nil{
                
                errorHandler?(response.error?.localizedDescription)
            }
            else {
                
                completionHandler?(response.value?["rows"].array)
            }
        }
    }
    
}

