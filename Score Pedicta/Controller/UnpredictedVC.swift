//
//  TabHomeViewController.swift
//  Score Pedicta
//
//  Created by Soumya Ranjan Sethy on 03/11/17.
//  Copyright © 2017 Soumya Ranjan Sethy. All rights reserved.
//

import UIKit
import Pastel

class UnpredictedVC: UIViewController, UITableViewDataSource,UITableViewDelegate {
   
   
    
    @IBOutlet weak var gamePredictionListTable: UITableView!
    var index : Int = 0
   
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let pastelView = PastelView(frame: view.bounds)
//        // Custom Direction
//        pastelView.startPastelPoint = .bottomLeft
//        pastelView.endPastelPoint = .topRight
//
//        // Custom Duration
//        pastelView.animationDuration = 3.0
//
//        // Custom Color
//        pastelView.setColors([UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
//                              UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
//                              UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
//                              UIColor(red: 32/255, green: 76/255,  blue: 255/255, alpha: 1.0),
//                              UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
//                              UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
//                              UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0)])
//
//        pastelView.startAnimation()
//        view.insertSubview(pastelView, at: 4)

        // Do any additional setup after loading the view.
        gamePredictionListTable.dataSource = self
        gamePredictionListTable.delegate = self
        self.gamePredictionListTable.rowHeight = 200
        self.gamePredictionListTable.tableFooterView = UIView()
        spinner.isHidden = false
        spinner.startAnimating()
        AuthService.instance.unpredictedScore(pageNo: "0", pageSize: "10", completion:
            { (success) in
                if success {
                    //print("Score Prediction List is Successfully Updated")
                    self.gamePredictionListTable.reloadData()
                    if UserDataService.instance.getUnpredictedGames().count == 0
                    {
                        let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: self.gamePredictionListTable.bounds.size.width, height: self.gamePredictionListTable.bounds.size.height))
                        noDataLabel.text          = "No data available"
                        noDataLabel.textColor     = UIColor.black
                        noDataLabel.textAlignment = .center
                        self.gamePredictionListTable.backgroundView  = noDataLabel
                        self.gamePredictionListTable.separatorStyle  = .none
                        
                    }
                }
                else{
                    displayMesssage(type: _error, title: UserDataService.instance.errorCode, body: UserDataService.instance.errorMessage)
                }
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
                
        })
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDataService.instance.getUnpredictedGames().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: gamePredictionListCell) as? UnPredictedTableViewCell
        {
            let game = UserDataService.instance.getUnpredictedGames()[indexPath.row]
            cell.updateViews(game: game)
            return cell
        }
        else{
            return UnPredictedTableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("Selected Row : ", indexPath.row)
        //let game = UserDataService.instance.getGamePredictionList()[indexPath.row]
        index = indexPath.row
        performSegue(withIdentifier: predictNow, sender: index)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let predictNowVC = segue.destination as? PredictNowVC
        let barBtn = UIBarButtonItem()
        barBtn.title = ""
        navigationItem.backBarButtonItem = barBtn
        //predictNowVC?.initPredictionDeatils(game : sender as! GamePredictionList)
        predictNowVC?.index = index
    }
    
}
