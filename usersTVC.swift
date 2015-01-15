//
//  usersVC.swift
//  ChatApp
//
//  Created by Allen Lee on 12/27/14.
//  Copyright (c) 2014 AllenLee. All rights reserved.
//
// userVC.swift is the view controller for a view in which users of this app are displayed from
// Parse Cloud

import UIKit

var userName = ""

class usersVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var resultsTable: UITableView!
    
    var resultsUsernameArray = [String]()
    var resultsProfileNameArray = [String]()
    var resultsImageFiles = [PFFile] ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        resultsTable.frame = CGRectMake(0, 0, theHeight, theWidth-64)
        
        userName = PFUser.currentUser().username

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.hidesBackButton = true
    }
    
    //Loads initial users when view appears
    override func viewDidAppear(animated: Bool) {
        
        //Clears arrays to avoid duplicate users
        resultsUsernameArray.removeAll(keepCapacity: true)
        resultsProfileNameArray.removeAll(keepCapacity: true)
        resultsImageFiles.removeAll(keepCapacity: true)
        
        //Queries for all Users
        let predicate = NSPredicate(format: "username != '"+userName+"'")
        var query = PFQuery(className: "_User", predicate: predicate)
        var objects = query.findObjects()
        
        //Iterates through retrieved users and retrieves neccesary data
        for user in objects {
            self.resultsUsernameArray.append(user.username)
            self.resultsProfileNameArray.append(user["profileName"] as String)
            self.resultsImageFiles.append(user["photo"] as PFFile)
            
            self.resultsTable.reloadData()
        }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(indexPath) as resultsCell
        otherName = cell.userNameLbl.text!
        otherProfileName = cell.usernameLbl.text!
        self.performSegueWithIdentifier("goToConversationVC", sender: self)
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsUsernameArray.count
    }
    
    //Not needed
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    
    //configures tableviewcell at each index
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: resultsCell = tableView.dequeueReusableCellWithIdentifier("Cell") as resultsCell
        
        cell.userNameLbl.text = self.resultsUsernameArray[indexPath.row]
        cell.usernameLbl.text = self.resultsProfileNameArray[indexPath.row]

        resultsImageFiles[indexPath.row].getDataInBackgroundWithBlock{
            
            (imageData: NSData!, error:NSError!) -> Void in
            
            if error == nil {
            
                let image = UIImage(data: imageData)
                cell.profileImg.image = image
                
            }
        }
        
        return cell
    }
    
    @IBAction func logoutBtn_click(sender: AnyObject) {
        
        PFUser.logOut()
        self.navigationController?.popToRootViewControllerAnimated(true)
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
