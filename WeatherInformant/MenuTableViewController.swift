//
//  MenuTableViewController.swift
//  WeatherInformant
//
//  Created by Ramsay on 20/01/17.
//  Copyright © 2017 Ramsay.dummyIOS. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController, SWRevealViewControllerDelegate {

    var identifierForDestinationController = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

   

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section{
            
        case 0:
            
            if indexPath.row == 0 { identifierForDestinationController = "AccountNavController"}
            
            if indexPath.row == 1 { identifierForDestinationController = "UsageNavController"}

        
        case 1:
        
        if indexPath.row == 0 { identifierForDestinationController = "AboutUsNavController"}
        
        if indexPath.row == 1 { identifierForDestinationController = "PrivacyPolicyNavController"}
            
        if indexPath.row == 2 { identifierForDestinationController = "ContactUsNavController"}

        default: break
    }
    
        self.revealViewController().delegate = self
        self.revealViewController().revealToggle(_:nil)
    }
    
    
    func revealController(_ revealController: SWRevealViewController!, didMoveTo position: FrontViewPosition) {
        //menu hidden brig out the resp manu's view controller
        if self.identifierForDestinationController != "" {

        if position == FrontViewPosition.left{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: self.identifierForDestinationController)
        
        self.revealViewController().frontViewController.present(controller, animated: true, completion: nil)
            }
            self.revealViewController().delegate = nil

        }
    }

}
