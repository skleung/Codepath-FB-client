//
//  MainViewController.swift
//  FacebookDemoSwift
//
//  Created by Timothy Lee on 2/11/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  let refreshControl = UIRefreshControl()
  var data = [NSDictionary]()
  @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.delegate = self
        self.tableView.dataSource = self
        reload()
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reload() {
        FBRequestConnection.startWithGraphPath("/me/home", parameters: nil, HTTPMethod: "GET") { (connection: FBRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
            println("\(result)")
            let post = result as! FBGraphObject
          let allPosts = post["data"] as! [[String:AnyObject]]
          self.data = allPosts.filter {
            (var post: [String: AnyObject]) -> Bool in
            if let _ = post["message"] {
              return true
            }
            return false
          }
          self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    // we're not sure if the string will exist in the dictionary
    // We have to use optional in this case
    println("cell?")
    var photo = data[indexPath.row]["picture"] as! String?
    if let validPhoto = photo {
      var cell = tableView.dequeueReusableCellWithIdentifier("photoCell", forIndexPath: indexPath) as! photoCell
      cell.photoView.setImageWithURL(NSURL(string: validPhoto)!)
      cell.photoCaption.text = data[indexPath.row]["message"] as! String
      
      return cell
    }
    else {
      var cell = tableView.dequeueReusableCellWithIdentifier("storyCell", forIndexPath: indexPath) as! storyCell
      cell.messageLabel.text = "status" as! String
      cell.messageLabel.text! += data[indexPath.row]["message"] as! String
      return cell
    }
  }
  
  func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 300
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
