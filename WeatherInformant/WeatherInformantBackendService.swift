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
    
    static func login(username: String, password: String, completionHandler : ((JSON?) -> Void)? = nil, errorHandler : ((String?) -> Void)? = nil ){
        
        let parameters = ["username" : username, "password" : password]
        

        let url = baseUrl + "RESTlogin"
        
        Alamofire.request(url, method: .post, parameters: parameters).responseSwiftyJSON{
            
            response in
            
            if response.error != nil {
                
                errorHandler?(response.error?.localizedDescription)
            }
            else{
                
                if response.response?.statusCode != 200 {
                    
                    errorHandler?(response.value?["errorMessage"].description)

                }
                else{
                    
                    completionHandler?(response.value)
                }
            }
            
        }
        
    }
}

