//
//  GamePredictionList.swift
//  Score Pedicta
//
//  Created by Soumya Ranjan Sethy on 03/11/17.
//  Copyright © 2017 Soumya Ranjan Sethy. All rights reserved.
//

import Foundation
struct Games
{
    private(set) public var gameId : String
    private(set) public var startTime : String
    private(set) public var endTime : String
    private(set) public var venue : String
    private(set) public var description : String
    private(set) public var actualDuration : String
    
    private(set) public var gameTeam1MappingId : String
    private(set) public var gameTeam2MappingId : String
    private(set) public var sportName : String
    private(set) public var team1Image : String
    private(set) public var team1Name : String
    private(set) public var team2Image : String
    private(set) public var team2Name : String
    
    private(set) public var team1_predictedScore : String
    private(set) public var team2_predictedScore : String
    private(set) public var team1_maxPredictedScore : String
    private(set) public var team2_maxPredictedScore : String
    private(set) public var team1_averageScore : String
    private(set) public var team2_averageScore : String
    private(set) public var team1_actualScore : String
    private(set) public var team2_actualScore : String
    
    
    init(gameId: String, startTime: String, endTime: String, venue: String,description : String,actualDuration : String,gameTeam1MappingId : String,gameTeam2MappingId : String,sportName : String ,team1Image:String, team1Name: String,team2Image: String, team2Name: String,team1_predictedScore : String, team2_predictedScore : String,team1_maxPredictedScore : String, team2_maxPredictedScore : String,team1_averageScore : String, team2_averageScore : String, team1_actualScore: String, team2_actualScore : String) {
        
        self.gameId = gameId
        self.startTime = startTime
        self.endTime = endTime
        self.venue = "Venue : "+venue
        self.description = description
        self.actualDuration = actualDuration
        
        self.gameTeam1MappingId = gameTeam1MappingId
        self.gameTeam2MappingId = gameTeam2MappingId
        self.sportName = description
        self.team1Image = team1Image
        self.team1Name = team1Name
        self.team2Image = team2Image
        self.team2Name = team2Name
        
        self.team1_predictedScore = team1_predictedScore
        self.team2_predictedScore = team2_predictedScore
        self.team1_maxPredictedScore = team1_maxPredictedScore
        self.team2_maxPredictedScore = team2_maxPredictedScore
        self.team1_averageScore = team1_averageScore
        self.team2_averageScore = team2_averageScore
        self.team1_actualScore = team1_actualScore
        self.team2_actualScore = team2_actualScore
        
        
    }
    
}
