//
//  ViewController.swift
//  Week5-Lecture
//
//  Created by Salyards, Adey on 4/26/16.
//  Copyright © 2016 Salyards, Adey. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var mySpecialBankNames: [String]!
    
    var branches: [[String: AnyObject]]! = []
    
    
    


    
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "https://openapi.etsy.com/v2/listings/active?api_key=chz71r7g66mcsvipoa4pngac")
        let request = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) in
            
//            let dictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
            
            let dictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String: AnyObject]
            let results = dictionary["results"] as! [[String: AnyObject]]
            for listing in results {
                self.branches.append(listing)
            }
            
//            self.branches = dictionary as! [NSDictionary]
            self.tableView.reloadData()
            print(dictionary)
            
        }
        
        mySpecialBankNames = ["The bank on the corner", "Towers Crescent Bank", "That one bank in the airport", "Hotel bank"]
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return branches.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("BankCell") as! BankCell
        
        let branchName = branches[indexPath.row]["name"] as? String
        cell.branchNameLabel.text = branchName
        
        let branchHours = branches[indexPath.row]["hours"] as? [String]
        
        var additionalBankHours = ""
        
        for dailyHours in branchHours! {
            additionalBankHours.appendContentsOf(dailyHours + "\n")
        }
    
        cell.hoursLabel.text = additionalBankHours
        
        return cell
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

