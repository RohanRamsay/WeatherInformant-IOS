//
//  WidgetTableViewController.swift
//  WeatherInformant
//
//  Created by Ramsay on 21/01/17.
//  Copyright © 2017 Ramsay.dummyIOS. All rights reserved.
//

import UIKit
import SwiftyJSON

class WidgetTableViewController: UITableViewController {

    var rows : [JSON?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.searchDisplayController?.searchResultsTableView.register(WeatherWidgetCell.self, forCellReuseIdentifier: "WidgetCell")
       
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(WidgetTableViewController.refreshTableContents), for: .valueChanged)
       
        WeatherInformantBackendService.getAllWeatherWidgets(completionHandler: self.populateTable(jsonData: ))
    }
    
    func refreshTableContents(){
        
        WeatherInformantBackendService.getAllWeatherWidgets(completionHandler: self.populateTable(jsonData: ), errorHandler: {
        
            _ in
            self.refreshControl?.endRefreshing()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //setup slide out menu
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

    }
    
    @IBAction func slideOutBarButtonClicked(_ sender: Any) {
        
        self.revealViewController()?.revealToggle(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return rows.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WidgetCell", for: indexPath) as! WeatherWidgetCell


        cell.titleLabel.text = self.rows[indexPath.row]?["title"].description
        cell.idLabel.text = self.rows[indexPath.row]?["apiid"].description
        cell.statusLabel.text = self.rows[indexPath.row]?["status"].description
        cell.descriptionLabel.text = self.rows[indexPath.row]?["description"].description
        cell.priceLabel.text = self.rows[indexPath.row]?["price"].description
        
        if cell.statusLabel.text == "free" {
         
            cell.buyButton.isHidden = true
            cell.priceLabel.isHidden = true
            cell.dollarLabel.isHidden = true
            
        }
        else{
            
            cell.buyButton.isHidden = false
            cell.priceLabel.isHidden = false
            cell.dollarLabel.isHidden = false
        }
        
        return cell
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func populateTable(jsonData: [JSON]?){
        
        self.refreshControl?.endRefreshing()

        if let rows = jsonData{
        
            self.rows = rows
            
            self.tableView.reloadData()
        }
    }

}


class WeatherWidgetCell : UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dollarLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!

}
