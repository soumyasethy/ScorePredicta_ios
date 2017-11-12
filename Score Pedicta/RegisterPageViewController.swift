//
//  RegisterPageViewController.swift
//  Score Pedicta
//
//  Created by Soumya Ranjan Sethy on 25/10/17.
//  Copyright © 2017 Soumya Ranjan Sethy. All rights reserved.
//

import UIKit
import Foundation

class RegisterPageViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        let userEmail = userEmailTextField.text;
        let userPassword = userPasswordTextField.text;
        let repeatPassword = repeatPasswordTextField.text;
        if((userEmail?.isEmpty)!||(userPassword?.isEmpty)!||(repeatPassword?.isEmpty)!){
            displayMyAlert(userMessage: "All fields are needed!");
            return;
        }
        if (userPassword != repeatPassword) {
            displayMyAlert(userMessage: "Password is matching!");
            return;
        }
        
     
        
        let headers = [
            "content-type": "application/json",
            "timezone": "Asia/Calcutta",
            "cache-control": "no-cache",
            "postman-token": "a0a9f39d-a143-b07c-2994-49900ff32137"
        ]
        let parameters = [
            "emailAddress": "rsehijpal@gmail.com",
            "password": "Password@2"
            ] as [String : Any]
        
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://85.25.196.222:6001/user/v1/login")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as! Data

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else { return }
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
               // print(httpResponse)
               //print("response = \(String(describing: response))")
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                    let posts = json["status"] as? [[String: Any]] ?? []
                    print(posts)
                   // self.displayMyAlert(userMessage: posts as! String)
                } catch let error as NSError {
                    print(error)
                }
                
                
                
               
            }
        })
        
        dataTask.resume()
        
        
    }
    func displayMyAlert(userMessage : String)
    {
        let myAlert = UIAlertController(title:"Oops",message:userMessage,preferredStyle:UIAlertControllerStyle.alert);
        let okAction = UIAlertAction(title:"Ok",style:UIAlertActionStyle.default,handler:nil);
        myAlert.addAction(okAction);
        self.present(myAlert,animated:true,completion:nil);
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
