//
//  PrivacyPolicyViewController.swift
//  WeatherInformant
//
//  Created by Ramsay on 21/01/17.
//  Copyright © 2017 Ramsay.dummyIOS. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.textView?.text = " We firmly believe that privacy [is] both inconsequential and unimportant to you. If it were not, you probably would not have a Facebook, Twitter, or LinkedIn account: and you certainly wouldn't ever use a search engine like Google. If you're one of those tin-foil-hat wearing crazies that actually cares about privacy: stop using our services and get a life. \n\n We agree with Mark Zuckerberg when he pithily opined \"The age of Privacy is Over.\"" +
        
        "\n\n Occasionally, we make our subscriber mailing list available to third parties for marketing purposes and to carefully screened companies offering products and services that we believe would interest our readers. If you do not want to receive these offers, please email your name and address to: info@funnytimes.com and request that we not share your name and address with third parties." + "\n\n" +
        
        "The information that you give us and information about your order may be combined with other personally identifiable information (such as demographic information and past purchase history) available from our records and other sources. This information will be used to make our future marketing efforts more efficient. \n\n"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.textView.scrollRangeToVisible(NSRange(location: 0, length: 1))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

}
