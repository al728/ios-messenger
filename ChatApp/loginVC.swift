//
//  ViewController.swift
//  ChatApp
//
//  Created by Allen Lee on 12/24/14.
//  Copyright (c) 2014 AllenLee. All rights reserved.
//

import UIKit

//Handles logging in to an available account
class ViewController: UIViewController {

    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var welcomeLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        welcomeLbl.center = CGPointMake(theWidth/2, 130)
        usernameTxt.frame = CGRectMake(16, 200, theWidth-32, 30)
        passwordTxt.frame = CGRectMake(16, 240, theWidth-32, 30)
        loginBtn.center = CGPointMake(theWidth/2, 330)
        signupBtn.center = CGPointMake(theWidth/2, theHeight-30)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.hidesBackButton = true
    }

    @IBAction func loginBtn_click(sender: AnyObject) {
        
        PFUser.logInWithUsernameInBackground(usernameTxt.text, password: passwordTxt.text, block: {
            (user:PFUser!, logInError:NSError!) -> Void in
            if (logInError == nil)
            {
                println("log in")
                
                var installation:PFInstallation = PFInstallation.currentInstallation()
                
                
                self.performSegueWithIdentifier("goToUsersVC", sender: self)
            } else{
                println("error log in")
            }
        
        
        })
    }

}

