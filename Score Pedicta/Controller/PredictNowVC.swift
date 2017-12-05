//
//  PredictNowVC.swift
//  Score Pedicta
//
//  Created by Soumya Ranjan Sethy on 05/11/17.
//  Copyright © 2017 Soumya Ranjan Sethy. All rights reserved.
//

import UIKit
import GMStepper

class PredictNowVC: UIViewController {
    @IBOutlet weak var score_card_layer: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var team2_score: GMStepper!
    @IBOutlet weak var team1_score: GMStepper!
    @IBOutlet weak var endTime_txt: UILabel!
    @IBOutlet weak var startTime_txt: UILabel!
    @IBOutlet weak var team1_thumb: UIImageView!
    @IBOutlet weak var team2_thumb: UIImageView!
    @IBOutlet weak var durationTxt: UILabel!
    @IBOutlet weak var descriptionTxt: UILabel!
    @IBOutlet weak var venueTxt: UILabel!
    @IBOutlet weak var team2_name: UILabel!
    @IBOutlet weak var team_name: UILabel!
    @IBOutlet weak var teamVS: UILabel!
    var index:Int = 0
    var Team1_gameTeamMappingId : String = ""
    var Team2_gameTeamMappingId :String = ""
  
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
        let game = UserDataService.instance.getUnpredictedGames()[index]
        // Do any additional setup after loading the view.
        team1_thumb.image = UIImage(data: Data(base64Encoded: game.team1Image, options: .ignoreUnknownCharacters)!)
        team2_thumb.image = UIImage(data: Data(base64Encoded: game.team2Image, options: .ignoreUnknownCharacters)!)
        team_name.text = game.team1Name
        team2_name.text = game.team2Name
        venueTxt.text = game.venue
        durationTxt.text = "Duration : " + game.actualDuration+" mins."
        descriptionTxt.text = "Description : " + game.description
        startTime_txt.text = "Start Time : " + game.startTime
        endTime_txt.text = "End Time : " + game.endTime
        self.title = game.sportName
        Team1_gameTeamMappingId = game.gameTeam1MappingId
        Team2_gameTeamMappingId = game.gameTeam2MappingId
      
       
    }
   
    @IBAction func predictBtnTapped(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        AuthService.instance.predictNow(Team1_gameTeamMappingId: Team1_gameTeamMappingId, Team1_predictedScore: String(Int(team1_score.value)), Team2_gameTeamMappingId: Team2_gameTeamMappingId, Team2_predictedScore: String(Int(team2_score.value)), completion:
            { (success) in
                if success {
                    displayMesssage(type: _success, title: UserDataService.instance.status, body: "Prediction Submitted")
                    self.performSegue(withIdentifier: predictNow_to_Unpredicted, sender: nil)
                }
                else{
                    displayMesssage(type: _error, title: UserDataService.instance.errorCode, body: UserDataService.instance.errorMessage)
                }
                self.spinner.isHidden = true
                self.spinner.stopAnimating()

        })
    }
   
    
}
