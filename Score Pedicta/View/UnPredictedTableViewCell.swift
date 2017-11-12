 //
//  GameCellTableViewCell.swift
//  Score Pedicta
//
//  Created by Soumya Ranjan Sethy on 03/11/17.
//  Copyright © 2017 Soumya Ranjan Sethy. All rights reserved.
//

import UIKit

class UnPredictedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var team1 : UIImageView!
    @IBOutlet weak var team2 : UIImageView!
    @IBOutlet weak var team1_name : UILabel!
    @IBOutlet weak var team2_name : UILabel!
    @IBOutlet weak var venue : UILabel!
    @IBOutlet weak var sportName : UILabel!
    
    
    func updateViews(game : Games)
    {
       // print("Updating View:  ")
        team1.image = UIImage(data: Data(base64Encoded: game.team1Image, options: .ignoreUnknownCharacters)!)
        team2.image = UIImage(data: Data(base64Encoded: game.team2Image, options: .ignoreUnknownCharacters)!)
        team1_name.text = game.team1Name
        team2_name.text = game.team2Name
        venue.text = game.venue
        sportName.text = game.sportName
    
    }
}
