//
//  TableViewController.swift
//  On The Map
//
//  Created by Solomon Dove on 2/16/22.
//

import Foundation
import UIKit

class TabbedViewController: UITableViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in the Tabbed View")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.studentLocations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell")!
        let location = appDelegate.studentLocations[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = location.firstName + " " + location.lastName
        cell.detailTextLabel?.text = location.mediaURL
        
        return cell
    }
}
