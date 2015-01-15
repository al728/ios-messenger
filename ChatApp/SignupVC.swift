//
//  SignupVCViewController.swift
//  ChatApp
//
//  Created by Allen Lee on 12/25/14.
//  Copyright (c) 2014 AllenLee. All rights reserved.
//

import UIKit

//Allows a new user to create an account
class SignupVCViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {

    
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var profileNameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var addImgBtn: UIButton!
    @IBOutlet weak var profileImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        profileImg.center = CGPointMake(theWidth/2, 140)
        profileImg.layer.cornerRadius = profileImg.frame.size.width/2
        profileImg.clipsToBounds = true

        addImgBtn.center = CGPointMake(self.profileImg.frame.maxX+50, 140)
        usernameTxt.frame = CGRectMake(16, 230, theWidth-32, 30)
        passwordTxt.frame = CGRectMake(16, 270, theWidth-32, 30)
        signupBtn.center = CGPointMake(theWidth/2, 380)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    @IBAction func addImgBtn_click(sender: AnyObject) {
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = true
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    
    
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        profileImg.image = image;
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        usernameTxt.resignFirstResponder()
        passwordTxt.resignFirstResponder()
        profileNameTxt.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        if(UIScreen.mainScreen().bounds.height == 568) {
            if (textField == self.profileNameTxt) {
                
                UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations: {
                    self.view.center = CGPointMake(theWidth/2, (theHeight/2)-40)
                    }, completion: {(finished:Bool) in
                })
            }
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        if(UIScreen.mainScreen().bounds.height == 568) {
            if (textField == self.profileNameTxt) {
                
                UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations: {
                    self.view.center = CGPointMake(theWidth/2, (theHeight/2))
                    }, completion: {(finished:Bool) in
                })
            }
        }

    }
    
    // Called when user clicks SignUp Button and creates a new user on Parse
    @IBAction func signupBtn_click(sender: AnyObject) {
        var user = PFUser()
        user.username = usernameTxt.text
        user.password = passwordTxt.text
        user.email = usernameTxt.text
        user["profileName"] = profileNameTxt.text
        
        let imageData = UIImagePNGRepresentation(self.profileImg.image)
        let imageFile = PFFile(name: "profilePhoto.png", data: imageData)
        user["photo"] = imageFile
        
        user.signUpInBackgroundWithBlock{
            (succeeded:Bool!, signUpError:NSError!) -> Void in
            
            if signUpError == nil {
                println("signup")
                self.performSegueWithIdentifier("goToUsersVC2", sender: self)
            } else {
                println("can't signup")
            }
        }
    }
}

