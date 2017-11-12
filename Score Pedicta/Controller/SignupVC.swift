//
//  SignupVC.swift
//  Score Pedicta
//
//  Created by Soumya Ranjan Sethy on 09/11/17.
//  Copyright © 2017 Soumya Ranjan Sethy. All rights reserved.
//

import UIKit
import VideoSplashKit
import DatePickerDialog
import SkyFloatingLabelTextField

class SignupVC: VideoSplashViewController {
    var preferedCommunication: String = ""
    var dobActual: String = ""
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var firstName: SkyFloatingLabelTextField!
    @IBOutlet weak var lastName: SkyFloatingLabelTextField!
    @IBOutlet weak var email: SkyFloatingLabelTextField!
    @IBOutlet weak var password: SkyFloatingLabelTextField!
    @IBOutlet weak var phone: SkyFloatingLabelTextField!
    @IBOutlet weak var address: SkyFloatingLabelTextField!
    @IBOutlet weak var pin: SkyFloatingLabelTextField!
    @IBOutlet weak var dobOutlet: UIButton!
    @IBAction func dobAction(_ sender: Any) {datePickerTapped()}
    @IBOutlet weak var preferedCommunication_outlet: UISegmentedControl!
    @IBAction func preferedCommunication_Action(_ sender: Any) {
        if preferedCommunication_outlet.selectedSegmentIndex == 0{
            preferedCommunication = "SMS"
        }
        else if preferedCommunication_outlet.selectedSegmentIndex == 1{
            preferedCommunication = "EMAIL"
        }
        else{
            preferedCommunication = "BOTH"
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
        preferedCommunication_outlet.tintColor = UIColor.white
        preferedCommunication = "SMS"
        
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
        
        //Adding Boder to button
        let borderAlpha : CGFloat = 0.7
        let cornerRadius : CGFloat = 5.0
        signupBtn.layer.borderWidth = 1.0
        signupBtn.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).cgColor
        signupBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        dobOutlet.layer.borderWidth = 1.0
        dobOutlet.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).cgColor
        dobOutlet.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        dobOutlet.layer.cornerRadius = cornerRadius
    }
    func datePickerTapped() {
        DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MMM/yyyy"
                self.dobOutlet.setTitle(formatter.string(from: dt),for: .normal)
                
                let formatterActual = DateFormatter()
                formatterActual.dateFormat = "yyyy-MM-dd"
                self.dobActual = formatterActual.string(from: dt)
            }
        }
    }

    @IBAction func signupTapped(_ sender: Any) {
        let firstName = self.firstName.text
        let lastName = self.lastName.text
        let email = self.email.text
        let password = self.password.text
        let phone = self.phone.text
        let address = self.address.text
        let pin = self.pin.text
        if(firstName?.isEmpty)!{
            displayMesssage(type: _warning, title: "Empty First Name", body: "Please enter a valid First Name")
            return;
        }
        if(lastName?.isEmpty)!{
            displayMesssage(type: _warning, title: "Empty Last Name", body: "Please enter a valid Last Name")
            return;
        }
        if(email?.isEmpty)!{
            displayMesssage(type: _warning, title: "Empty Email", body: "Please enter a valid Email")
            return;
        }
        
        if(password?.isEmpty)!{
            displayMesssage(type: _warning, title: "Empty Password", body: "Please enter a valid Password")
            return;
        }
        if(phone?.isEmpty)!{
            displayMesssage(type: _warning, title: "Empty Phone Number", body: "Please enter a valid Phone Number")
            return;
        }
        if(address?.isEmpty)!{
            displayMesssage(type: _warning, title: "Empty Address", body: "Please enter a valid Address")
            return;
        }
        if(pin?.isEmpty)!{
            displayMesssage(type: _warning, title: "Empty Postal Code", body: "Please enter a valid Postal Code")
            return;
        }
        if(dobOutlet.titleLabel?.text == "?"){
            displayMesssage(type: _warning, title: "Empty DOB", body: "Please enter a valid Date of Birth")
            return;
        }
        spinner.isHidden = false
        spinner.startAnimating()
        
        AuthService.instance.signUP(firstName: firstName!, lastName: lastName!, dob: dobActual, password: password!, emailAddress: email!, prefCommMode: preferedCommunication, phoneNo: phone!, address: address!, postalCode: pin!,  completion:
            { (success) in
                if success {
                    // print("LogIn Successfull")
                    displayMesssage(type: _success, title: UserDataService.instance.status, body: "SIGNUP COMPLETED!")
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
