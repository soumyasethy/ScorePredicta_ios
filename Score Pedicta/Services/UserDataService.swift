//
//  UserDataService.swift
//  Score Pedicta
//
//  Created by Soumya Ranjan Sethy on 03/11/17.
//  Copyright © 2017 Soumya Ranjan Sethy. All rights reserved.
//

import Foundation

class UserDataService {
    
    static let instance = UserDataService()
    
    public private(set) var status = ""
    func setStatus(status: String){
        self.status = status
    }
    
    //Handling LogIn Details
    public private(set) var firstName = ""
    public private(set) var lastName = ""
    public private(set) var dob = ""
    public private(set) var emailAddress = ""
    public private(set) var lastLoginDate = ""
    public private(set) var address = ""
    public private(set) var postalCode = ""
    public private(set) var phoneNo = ""
    public private(set) var createDate = ""
    public private(set) var modifiedDate = ""
    
    func setUserDetails( firstName: String, lastName: String, dob: String, emailAddress: String, lastLoginDate: String, address: String, postalCode: String,
                         phoneNo: String, createDate: String, modifiedDate: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.dob = dob
        self.emailAddress = emailAddress
        self.lastLoginDate = lastLoginDate
        self.address = address
        self.postalCode = postalCode
        self.phoneNo = phoneNo
        self.createDate = createDate
        self.modifiedDate = modifiedDate
    }
    
    //Handling Error
    public private(set) var errorCode = ""
    public private(set) var errorMessage = ""
    
    func setError(errorCode: String, errorMessage: String) {
        self.errorCode = errorCode
        self.errorMessage = errorMessage
    }
    
    public private(set) var unpredictedGamesArray: [Games] = []
    func setUnpredictedGames(unpredictedGames: [Games]) {
        self.unpredictedGamesArray = unpredictedGames
    }
    func getUnpredictedGames() -> [Games]{
        return unpredictedGamesArray
    }
    public private(set) var upcomingGamesArray: [Games] = []
    func setUpcomingGames(upcomingGames: [Games]) {
        self.upcomingGamesArray = upcomingGames
    }
    func getUpcomingGames() -> [Games]{
        return upcomingGamesArray
    }
    public private(set) var pastGamesArray: [Games] = []
    func setPastGames(pastGames: [Games]) {
        self.pastGamesArray = pastGames
    }
    func getPastGames() -> [Games]{
        return pastGamesArray
    }

    
  
    
}












