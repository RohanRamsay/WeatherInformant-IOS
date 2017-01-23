//
//  ViewController.swift
//  WeatherInformant
//
//  Created by Ramsay on 20/01/17.
//  Copyright © 2017 Ramsay.dummyIOS. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        
        if UserDefaults.standard.value(forKey: "userid") != nil && UserDefaults.standard.value(forKey: "password") != nil {
            
            self.performSegue(withIdentifier: "LaunchHomePage", sender: self)
        }
        else{
            //if not logged in
            self.performSegue(withIdentifier: "LaunchLoginPage", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}

