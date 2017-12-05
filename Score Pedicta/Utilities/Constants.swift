 //
//  Constants.swift
//  Score Pedicta
//
//  Created by Soumya Ranjan Sethy on 02/11/17.
//  Copyright © 2017 Soumya Ranjan Sethy. All rights reserved.
//

import Foundation
import SwiftMessages
 
 typealias CompletionHandler = (_ Success: Bool) -> ()
 
 //User URL Constants
 let BASE_URL = "http://85.25.196.222:6001/user/"
 let URL_USR_LOGIN = "\(BASE_URL)v1/login"
 let URL_SIGNUP = "\(BASE_URL)v1/signup"
 let URL_GENERATE_TOKEN = "\(BASE_URL)account/v1/token?email="
 let URL_RESET_PASSWORD = "\(BASE_URL)account/v1/resetPassword"

 
 //Score Prediction Service
 let _BASE_URL = "http://85.25.196.222:6005/score/v1/"
 let URL_UNPREDICTED_GAMES = "\(_BASE_URL)list/unpredictedgames"
 let URL_PREDICT_NOW = "\(_BASE_URL)predict"
 let URL_UPCOMING_GAME_LIST = "\(_BASE_URL)list/upcominggames/score"
 let URL_PAST_GAME_LIST = "\(_BASE_URL)pastpredictions/score"
 

 //segues
 let TO_HOME  = "toHomePage"
 let TO_RESET_PASSWORD = "toResetPassword"
 let predictNow = "predictNow"
 let predictNow_to_Unpredicted = "predictNow_to_Unpredicted"
 
 //Table Cell
 let upcomingID = "upcomingID"
 let pastID = "pastID"
 let gamePredictionListCell = "gamePredictionListCell"
 
 //Default Keys
 let LOGGED_IN_KEY = "loggedIn"
 let USER_EMAIL = "userEmail"
 
 var localTimeZoneName: String { return TimeZone.current.identifier }
 //Headers
 let HEADERS = [
    "content-type": "application/json",
    "timezone": localTimeZoneName
 ]
 
 let _success = "success"
 let _warning = "warning"
 let _error = "error"
 
 
 func displayMesssage( type : String, title : String, body : String ){
    // Instantiate a message view from the provided card view layout. SwiftMessages searches for nib
    // files in the main bundle first, so you can easily copy them into your project and make changes.
    let view = MessageView.viewFromNib(layout: .cardView)
    
    // Theme message elements with the warning style.
    if(type == _success)  {
        view.configureTheme(.success)
        // image with an emoji character.
        let iconText = ["✅","😃","😄","🙂","😁"].sm_random()!
        // Set message title, body, and icon. Here, we're overriding the default warning
        view.configureContent(title: title, body: body, iconText: iconText)
        
    } else if(type == _warning) {
        view.configureTheme(.warning)
        // image with an emoji character.
        let iconText = ["🤔", "😳", "🙄", "😶"].sm_random()!
        // Set message title, body, and icon. Here, we're overriding the default warning
        view.configureContent(title: title, body: body, iconText: iconText)
    } else{
        view.configureTheme(.error)
        // image with an emoji character.
        let iconText = ["😱", "😨","😕","🙁","😟", "🚫", "❌"].sm_random()!
        // Set message title, body, and icon. Here, we're overriding the default warning
        if(title.isEmpty && body.isEmpty){
            view.configureContent(title: "Connectivity Issue", body: "There is a problem to connect to Serever ", iconText: iconText)
        }
        else{
        view.configureContent(title: title, body: body, iconText: iconText)
        }
    }
    view.button?.isHidden = true
    // Hide when button tapped
    view.buttonTapHandler = { _ in SwiftMessages.hide() }
  
    //view.button = "OK"
    // Hide when message view tapped
    view.tapHandler = { _ in SwiftMessages.hide() }
    // Customize config using the default as a base.
   // var config = SwiftMessages.defaultConfig
    //config.duration = .forever
    // Add a drop shadow.
    view.configureDropShadow()
    // Show the message.
    SwiftMessages.show(view: view)//config: config,view: view)
 }
 
