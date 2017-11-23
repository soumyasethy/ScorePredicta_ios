//
//  ForgetResetVC.swift
//  Score Pedicta
//
//  Created by Soumya Ranjan Sethy on 11/11/17.
//  Copyright © 2017 Soumya Ranjan Sethy. All rights reserved.
//

import UIKit
import VideoSplashKit
import SkyFloatingLabelTextField

class ForgetResetVC: VideoSplashViewController {
    var email : String = "";
    @IBOutlet weak var emailTxt: UILabel!
    @IBOutlet weak var token: SkyFloatingLabelTextField!
    @IBOutlet weak var newPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        spinner.isHidden = true
        emailTxt.text = email
        // Do any additional setup after loading the view.
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
    }
    @IBAction func verifyTapped(_ sender: Any) {
        if (token.text?.isEmpty)! {return}
        if (newPassword.text?.isEmpty)! {return}
        spinner.isHidden = false
        spinner.startAnimating()
        AuthService.instance.resetPssword(token: token.text!, emailAddress: email, newPassword: newPassword.text!, completion:
            { (success) in
                if success {
                    //self.performSegue(withIdentifier: TO_RESET_PASSWORD, sender: nil)
                    displayMesssage(type: _success, title: UserDataService.instance.status, body: "Password reset successful. Please Login Now!")
                }
                else{
                    displayMesssage(type: _error, title: UserDataService.instance.errorCode, body: UserDataService.instance.errorMessage)
                }
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
        })
        
        
        
    }
}
