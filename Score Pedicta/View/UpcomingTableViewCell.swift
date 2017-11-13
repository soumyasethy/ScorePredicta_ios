//
//  UpcomingTableViewCell.swift
//  Score Pedicta
//
//  Created by Soumya Ranjan Sethy on 07/11/17.
//  Copyright © 2017 Soumya Ranjan Sethy. All rights reserved.
//

import UIKit

class UpcomingTableViewCell: UITableViewCell {
   
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
    
    
    func updateViews(upcomingGame : Games)
    {
        //print("Updating Upcoming View")
        team1.image = UIImage(data: Data(base64Encoded: upcomingGame.team1Image, options: .ignoreUnknownCharacters)!)
        team2.image = UIImage(data: Data(base64Encoded: upcomingGame.team2Image, options: .ignoreUnknownCharacters)!)
        team1_name.text = upcomingGame.team1Name
        team2_name.text = upcomingGame.team2Name
//        venue.text = upcomingGame.venue
//        let result = upcomingGame.startTime.split(separator: " ")
//        sportName.text =  result[0] + "-" + upcomingGame.sportName
//        time.text = result[1]+""
        team1_avg.text = "Avg. Predicted : "+upcomingGame.team1_averageScore
        team1_most.text = "Most Predicted : "+upcomingGame.team1_maxPredictedScore
        team1_predicted.text = upcomingGame.team1_predictedScore
        team2_avg.text = "Avg. Predicted : "+upcomingGame.team2_averageScore
        team2_most.text = "Most Predicted : "+upcomingGame.team2_maxPredictedScore
        team2_predicted.text = upcomingGame.team2_predictedScore
//        duration.text = "Duration : "+upcomingGame.actualDuration+" mins"
//
//        
    
        let cornerRadius : CGFloat = 5.0
        self.team1_most.layer.borderWidth = 1.0
        self.team1_most.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.team1_most.layer.cornerRadius = cornerRadius
        
        self.team1_avg.layer.borderWidth = 1.0
        self.team1_avg.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.team1_avg.layer.cornerRadius = cornerRadius
        
        self.team2_most.layer.borderWidth = 1.0
        self.team2_most.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.team2_most.layer.cornerRadius = cornerRadius
        
        self.team2_avg.layer.borderWidth = 1.0
        self.team2_avg.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.team2_avg.layer.cornerRadius = cornerRadius
       
        
        
        
    }
}
