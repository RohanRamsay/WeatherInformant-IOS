//
//  ContactUsViewController.swift
//  WeatherInformant
//
//  Created by Ramsay on 21/01/17.
//  Copyright © 2017 Ramsay.dummyIOS. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {

    var number = "+640211147224"
    var mail = "ramsayroha@vuw.ac.nz"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

    @IBAction func callButtonPressed(_ sender: Any) {
        guard let number = URL(string: "telprompt://" + number) else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
    

    @IBAction func textButtonPressed(_ sender: Any) {
        
        guard let number = URL(string: "sms://" + number) else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
    
    @IBAction func emailButtonPressed(_ sender: Any) {
        guard let email = URL(string: "mailto://" + mail) else { return }
        UIApplication.shared.open(email, options: ["subject":"Regarding Weather Informant"], completionHandler: nil)
    }

}
