//
//  ForgetVC.swift
//  Score Pedicta
//
//  Created by Soumya Ranjan Sethy on 10/11/17.
//  Copyright © 2017 Soumya Ranjan Sethy. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ForgetVC: UIViewController {
    @IBOutlet weak var email: SkyFloatingLabelTextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         spinner.isHidden = true
    }

    
    @IBAction func resetTapped(_ sender: Any) {
        if (email.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)!{return}
        spinner.isHidden = false
        spinner.startAnimating()
        AuthService.instance.generateToken(emailAddress: (email.text?.trimmingCharacters(in: .whitespacesAndNewlines))!, completion:
            { (success) in
                if success {
                    self.performSegue(withIdentifier: TO_RESET_PASSWORD, sender: nil)
                }
                else{
                    displayMesssage(type: _error, title: UserDataService.instance.errorCode, body: UserDataService.instance.errorMessage)
                }
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
                //performSegue(withIdentifier: TO_RESET_PASSWORD, sender: email.text)
        })
        
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let forgetResetVC = segue.destination as? ForgetResetVC
        let barBtn = UIBarButtonItem()
        barBtn.title = ""
        navigationItem.backBarButtonItem = barBtn
        
        forgetResetVC?.email = (email.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
    }
    
}
