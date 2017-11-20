//
//  AuthService.swift
//  Score Pedicta
//
//  Created by Soumya Ranjan Sethy on 02/11/17.
//  Copyright © 2017 Soumya Ranjan Sethy. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService
{
    
    
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn : Bool{
        get {
            return defaults.bool(forKey : LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    var userEmail : String{
        get{
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set{
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    func logInUser(email : String, password : String , completion: @escaping CompletionHandler ) {
        let lowerCaseEmail = email.lowercased()
        
        let body: [String : Any] = [
            "emailAddress": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_USR_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADERS).responseString
            {(response) in
                if response.result.error == nil{
                    guard let data = response.data else {return}
                    let json = JSON(data: data)
                    let status = json["status"].stringValue
                    UserDataService.instance.setStatus(status: status)
                    if(status == "SUCCESS"){
                        self.userEmail = json["userDetails"]["emailAddress"].stringValue
                        UserDataService.instance.setUserDetails(firstName: json["userDetails"]["firstName"].stringValue,
                                                                lastName: json["userDetails"]["lastName"].stringValue,
                                                                dob: json["userDetails"]["dob"].stringValue,
                                                                emailAddress: json["userDetails"]["emailAddress"].stringValue,
                                                                lastLoginDate: json["userDetails"]["lastLoginDate"].stringValue,
                                                                address: json["userDetails"]["addressDetails"]["address"].stringValue,
                                                                postalCode:json["userDetails"]["addressDetails"]["postalCode"].stringValue,
                                                                phoneNo:json["userDetails"]["contactDetails"]["phoneNo"].stringValue,
                                                                createDate: json["userDetails"]["createDate"].stringValue,
                                                                modifiedDate: json["userDetails"]["modifiedDate"].stringValue)
                        self.isLoggedIn = true
                        completion(true)
                    }
                    else{
                        //Handling Explicitly the Error Message
                        self.errorHandling(json: json)
                        completion(false)
                        
                    }
                }
                else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
        }
        
    }
    func signUP(firstName : String , lastName : String,dob : String , password : String,emailAddress : String , prefCommMode : String,phoneNo : String,
                address : String,postalCode : String,completion: @escaping CompletionHandler ) {
        
        let headers = [
            "content-type": "application/json",
            "timezone": localTimeZoneName
        ]
        let body = ["userDetails": [
            "firstName": firstName,
            "lastName": lastName,
            "dob": dob,
            "password": password,
            "emailAddress": emailAddress,
            "prefCommMode": prefCommMode,
            "contactDetails": ["phoneNo": phoneNo],
            "addressDetails": [
                "address": address,
                "postalCode": postalCode
            ]
            ]]
        Alamofire.request(URL_SIGNUP, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseString
            {(response) in
                if response.result.error == nil{
                    guard let data = response.data else {return}
                    let json = JSON(data: data)
                    let status = json["status"].stringValue
                    UserDataService.instance.setStatus(status: status)
                    if(status == "SUCCESS"){
                        // print("Status : ",status)
                        completion(true)
                    }
                    else{
                        //Handling Explicitly the Error Message
                        self.errorHandling(json: json)
                        completion(false)
                        
                    }
                }
                else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
        }
        
    }
    func generateToken(emailAddress : String, completion: @escaping CompletionHandler ) {
        
        let headers = [
            "content-type": "application/json",
            "timezone": localTimeZoneName
        ]
        
        Alamofire.request(URL_GENERATE_TOKEN+emailAddress, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseString
            {(response) in
                if response.result.error == nil{
                    guard let data = response.data else {return}
                    let json = JSON(data: data)
                    let status = json["status"].stringValue
                    UserDataService.instance.setStatus(status: status)
                    if(status == "SUCCESS"){
                        // print("Status : ",status)
                        completion(true)
                    }
                    else{
                        //Handling Explicitly the Error Message
                        self.errorHandling(json: json)
                        completion(false)
                        
                    }
                }
                else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
        }
        
    }
    func resetPssword(token : String , emailAddress : String, newPassword : String,completion: @escaping CompletionHandler ) {
        
        let headers = [
            "content-type": "application/json",
            "timezone": localTimeZoneName
        ]
        let body = [
            "token": token,
            "emailAddress": emailAddress,
            "newPassword": newPassword
        ]
        Alamofire.request(URL_RESET_PASSWORD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseString
            {(response) in
                if response.result.error == nil{
                    guard let data = response.data else {return}
                    let json = JSON(data: data)
                    let status = json["status"].stringValue
                    UserDataService.instance.setStatus(status: status)
                    if(status == "SUCCESS"){
                        // print("Status : ",status)
                        completion(true)
                    }
                    else{
                        //Handling Explicitly the Error Message
                        self.errorHandling(json: json)
                        completion(false)
                        
                    }
                }
                else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
        }
        
    }
    func unpredictedScore(pageNo : String , pageSize : String, completion: @escaping CompletionHandler ) {
        
        let body: [String : Any] = [
            "sportMasterId" : 1,
            "pageNo": pageNo,
            "pageSize": pageSize
        ]
        let headers = [
            "content-type": "application/json",
            "timezone": localTimeZoneName,
            "username": AuthService.instance.userEmail
            ]
        Alamofire.request(URL_UNPREDICTED_GAMES, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseString
            {(response) in
                if response.result.error == nil{
                    guard let data = response.data else {return}
                    let json = JSON(data: data)
                    let status = json["status"].stringValue
                    UserDataService.instance.setStatus(status: status)
                    if(status == "SUCCESS"){
                        UserDataService.instance.setUnpredictedGames(unpredictedGames: self.parseJSON(json: json))
                        completion(true)
                    }
                    else{
                        //Handling Explicitly the Error Message
                        self.errorHandling(json: json)
                        completion(false)
                        
                    }
                }
                else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
        }
        
    }
    
    
    func predictNow(Team1_gameTeamMappingId : String , Team1_predictedScore : String,Team2_gameTeamMappingId : String , Team2_predictedScore : String, completion: @escaping CompletionHandler ) {
        
        let headers = [
            "content-type": "application/json",
            "timezone": localTimeZoneName,
            "username": AuthService.instance.userEmail
            ]
        let body = ["scores": [
            [
                "gameTeamMappingId": Team1_gameTeamMappingId,
                "predictedScore": Team1_predictedScore
            ],
            [
                "gameTeamMappingId": Team2_gameTeamMappingId,
                "predictedScore": Team2_predictedScore
            ]
            ]]
        
        Alamofire.request(URL_PREDICT_NOW, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseString
            {(response) in
                if response.result.error == nil{
                    guard let data = response.data else {return}
                    let json = JSON(data: data)
                    let status = json["status"].stringValue
                    UserDataService.instance.setStatus(status: status)
                    if(status == "SUCCESS"){
                        // print("Status : ",status)
                        completion(true)
                    }
                    else{
                        //Handling Explicitly the Error Message
                        self.errorHandling(json: json)
                        completion(false)
                        
                    }
                }
                else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
        }
        
    }
    func upcomingGames(pageNo : String , pageSize : String, completion: @escaping CompletionHandler ) {
        
        let body: [String : Any] = [
            "pageNo": pageNo,
            "pageSize": pageSize
        ]
        let headers = [
            "content-type": "application/json",
            "timezone": localTimeZoneName,
           "username": AuthService.instance.userEmail
            ]
        
        Alamofire.request(URL_PAST_GAME_LIST, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseString
            {(response) in
                if response.result.error == nil{
                    guard let data = response.data else {return}
                    let json = JSON(data: data)
                    let status = json["status"].stringValue
                    UserDataService.instance.setStatus(status: status)
                    if(status == "SUCCESS"){
                     UserDataService.instance.setUpcomingGames(upcomingGames: self.parseJSON(json: json))
                     completion(true)
                    }
                    else{
                        //Handling Explicitly the Error Message
                        self.errorHandling(json: json)
                        completion(false)
                        
                    }
                }
                else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
        }
        
    }
    func pastGames(pageNo : String , pageSize : String, completion: @escaping CompletionHandler ) {
        
        let body: [String : Any] = [
            "pageNo": pageNo,
            "pageSize": pageSize
        ]
        let headers = [
            "content-type": "application/json",
            "timezone": localTimeZoneName,
            "username": AuthService.instance.userEmail
            ]
        
        Alamofire.request(URL_PAST_GAME_LIST, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseString
            {(response) in
                if response.result.error == nil{
                    guard let data = response.data else {return}
                    let json = JSON(data: data)
                    let status = json["status"].stringValue
                    UserDataService.instance.setStatus(status: status)
                    if(status == "SUCCESS"){
                        UserDataService.instance.setPastGames(pastGames: self.parseJSON(json: json))
                        completion(true)
                    }
                    else{
                        //Handling Explicitly the Error Message
                        self.errorHandling(json: json)
                        completion(false)
                        
                    }
                }
                else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
        }
        
    }
    func errorHandling(json : JSON){
        if let errors = json["errors"].array {
            for error in errors
            {UserDataService.instance.setError(errorCode: error["errorCode"].stringValue,errorMessage: error["errorMessage"].stringValue)}
        }
    }
    func parseJSON(json : JSON) -> Array<Games>{
        var gamesList : [Games] = []
        if let games = json["games"].array {
            for game in games
            {
                if let teams = game["teams"].array {
                    gamesList.append(Games(
                        gameId: game["gameId"].stringValue, startTime: game["startTime"].stringValue, endTime: game["endTime"].stringValue,
                        venue: game["venue"].stringValue,description : game["description"].stringValue,actualDuration : game["actualDuration"].stringValue,gameTeam1MappingId : teams[0]["gameTeamMappingId"].stringValue,
                        gameTeam2MappingId : teams[1]["gameTeamMappingId"].stringValue,sportName : teams[0]["sportName"].stringValue,team1Image: teams[0]["teamLogo"].stringValue, team1Name: teams[0]["teamName"].stringValue, team2Image: teams[1]["teamLogo"].stringValue, team2Name: teams[1]["teamName"].stringValue,team1_predictedScore : teams[0]["predictedScore"].stringValue, team2_predictedScore : teams[1]["predictedScore"].stringValue,team1_maxPredictedScore : teams[0]["maxPredictedScore"].stringValue, team2_maxPredictedScore : teams[1]["maxPredictedScore"].stringValue,team1_averageScore : teams[0]["averageScore"].stringValue, team2_averageScore : teams[1]["averageScore"].stringValue, team1_actualScore: teams[0]["actualScore"].stringValue, team2_actualScore: teams[1]["actualScore"].stringValue) )
                }}
            
            
        }
        return gamesList
    }
    
}

