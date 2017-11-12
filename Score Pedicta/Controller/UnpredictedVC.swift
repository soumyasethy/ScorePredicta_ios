//
//  TabHomeViewController.swift
//  Score Pedicta
//
//  Created by Soumya Ranjan Sethy on 03/11/17.
//  Copyright © 2017 Soumya Ranjan Sethy. All rights reserved.
//

import UIKit

class UnpredictedVC: UIViewController, UITableViewDataSource,UITableViewDelegate {
   
   
    
    @IBOutlet weak var gamePredictionListTable: UITableView!
    var index : Int = 0
   
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        gamePredictionListTable.dataSource = self
        gamePredictionListTable.delegate = self
        self.gamePredictionListTable.rowHeight = 150
        self.gamePredictionListTable.tableFooterView = UIView()
        spinner.isHidden = false
        spinner.startAnimating()
        AuthService.instance.unpredictedScore(pageNo: "0", pageSize: "10", completion:
            { (success) in
                if success {
                    //print("Score Prediction List is Successfully Updated")
                    self.gamePredictionListTable.reloadData()
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
