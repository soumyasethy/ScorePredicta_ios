//
//  PastPredictionTableViewCell.swift
//  Score Pedicta
//
//  Created by Soumya Ranjan Sethy on 12/11/17.
//  Copyright © 2017 Soumya Ranjan Sethy. All rights reserved.
//

import UIKit

class PastPredictionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var scoreLayer : UIImageView!
    @IBOutlet weak var team1 : UIImageView!
    @IBOutlet weak var team2 : UIImageView!
    @IBOutlet weak var team1_name : UILabel!
    @IBOutlet weak var team2_name : UILabel!
    @IBOutlet weak var team1_avg : UILabel!
    @IBOutlet weak var team1_most : UILabel!
    @IBOutlet weak var team1_predicted : UILabel!
    @IBOutlet weak var team2_avg : UILabel!
    @IBOutlet weak var team2_most : UILabel!
    @IBOutlet weak var team2_predicted : UILabel!
    @IBOutlet weak var venue : UILabel!
    @IBOutlet weak var duration : UILabel!
    @IBOutlet weak var sportName : UILabel!
    @IBOutlet weak var time : UILabel!
    @IBOutlet weak var team1Actual : UILabel!
    @IBOutlet weak var team2Actual : UILabel!
    func updateViews(pastGames : Games)
    {
        //print("Updating Past View")
        team1.image = UIImage(data: Data(base64Encoded: pastGames.team1Image, options: .ignoreUnknownCharacters)!)
        team2.image = UIImage(data: Data(base64Encoded: pastGames.team2Image, options: .ignoreUnknownCharacters)!)
        team1_name.text = pastGames.team1Name
        team2_name.text = pastGames.team2Name
        team1Actual.text = pastGames.team1_actualScore
        team2Actual.text = pastGames.team2_actualScore
        venue.text = pastGames.venue
        let result = pastGames.startTime.split(separator: " ")
        sportName.text =  result[0] + " - " + pastGames.sportName
       // let Year = GetOnlyDateMonthYearFromFullDate("yyyy-MM-dd hh:mm:ss.S", conVertFormate: "MMM,dd YYYY", convertDate: pastGames.startTime) as String
           // "startTime": "2017-11-04 15:24:00.0"
       
        time.text = result[1]+""
        team1_avg.text = pastGames.team1_averageScore
        team1_most.text = pastGames.team1_maxPredictedScore
        team1_predicted.text = pastGames.team1_predictedScore
        team2_avg.text = pastGames.team2_averageScore
        team2_most.text = pastGames.team2_maxPredictedScore
        team2_predicted.text = pastGames.team2_predictedScore
        duration.text = "Duration : "+pastGames.actualDuration+" mins"
        
        
//        let borderAlpha : CGFloat = 0.7
//        let cornerRadius : CGFloat = 5.0
//        self.team1Actual.layer.borderWidth = 1.0
//        self.team1Actual.layer.borderLe = 1.0
//        self.team1Actual.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
//        self.team2Actual.layer.borderWidth = 1.0
//        self.team2Actual.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
//        //team1Actual.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
//        self.team2Actual.layer.cornerRadius = cornerRadius
        
        
        
    }
    
}
