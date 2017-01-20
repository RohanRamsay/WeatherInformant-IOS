//
//  HomeViewController.swift
//  WeatherInformant
//
//  Created by Ramsay on 20/01/17.
//  Copyright © 2017 Ramsay.dummyIOS. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //setup slide out menu
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func slideOutBarButtonClicked(_ sender: Any) {
        
        self.revealViewController()?.revealToggle(self)
    }
    
}

