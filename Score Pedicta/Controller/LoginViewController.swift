//
//  LoginViewController.swift
//  Score Pedicta
//
//  Created by Soumya Ranjan Sethy on 26/10/17.
//  Copyright © 2017 Soumya Ranjan Sethy. All rights reserved.
//

import UIKit
import VideoSplashKit
import SkyFloatingLabelTextField
import SwiftMessages




class LoginViewController: VideoSplashViewController, UITextFieldDelegate {
    
    @IBOutlet weak var signup_btn: UIButton!
    @IBOutlet weak var userEmail: SkyFloatingLabelTextField!
    @IBOutlet weak var userPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var errorCode: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        //userEmail.returnKeyType = .done
        //userPassword.returnKeyType = .done
        spinner.isHidden = true
        //Transparent Navigation Bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        //Video
        let url = NSURL.fileURL(withPath: Bundle.main.path(forResource: "ttt", ofType: "mp4")!)
        self.videoFrame = view.frame
        fillMode = .resizeAspectFill
        self.alwaysRepeat = true
        self.sound = true
        self.startTime = 12.0
        self.duration = 4.0
        self.alpha = 0.7
        self.backgroundColor = UIColor.black
        self.contentURL = url
        self.restartForeground = true
        
        
        let borderAlpha : CGFloat = 0.7
        //let cornerRadius : CGFloat = 5.0
        signup_btn.layer.borderWidth = 1.0
        signup_btn.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).cgColor
        signup_btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        // signup_btn.layer.cornerRadius = cornerRadius
        
    }
   
    @IBAction func loginButtonTapped(_ sender: Any) {
        let userEmail = self.userEmail.text
        let userPassword = self.userPassword.text
        if(userEmail?.isEmpty)!{
            displayMesssage(type: _warning, title: "Empty Email", body: "Please enter a valid Email")
            return;
        }
        if(userPassword?.isEmpty)!{
            displayMesssage(type: _warning, title: "Empty Password", body: "Please enter a valid Password")
            return;
        }
        spinner.isHidden = false
        spinner.startAnimating()
        
        AuthService.instance.logInUser(email: userEmail!, password: userPassword!, completion:
            { (success) in
                if success {
                   // print("LogIn Successfull")
                    self.performSegue(withIdentifier: TO_HOME, sender: nil)
                }
                else{
                    displayMesssage(type: _error, title: UserDataService.instance.errorCode, body: UserDataService.instance.errorMessage)
                }
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
                //self.dismiss(animated: true, completion:nil)
                
        })
        
    }
    
   

}

