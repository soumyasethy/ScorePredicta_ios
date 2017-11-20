//
//  UpcomingVC.swift
//  Score Pedicta
//
//  Created by Soumya Ranjan Sethy on 07/11/17.
//  Copyright © 2017 Soumya Ranjan Sethy. All rights reserved.


import UIKit
import SwiftMessages

class UpcomingVC: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
   @IBOutlet weak var upcomingTable: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        upcomingTable.isHidden = true
        upcomingTable.dataSource = self
        upcomingTable.delegate = self
        self.upcomingTable.rowHeight = 255
        self.upcomingTable.tableFooterView = UIView()
        spinner.isHidden = false        
        spinner.startAnimating()
        AuthService.instance.upcomingGames(pageNo: "0", pageSize: "10", completion:
            { (success) in
                if success {
                    //print("Upcoming Game List is Successfully Updated")
                    self.upcomingTable.reloadData()
                    self.upcomingTable.isHidden = false
                      }
                else{
                    displayMesssage(type: _error, title: UserDataService.instance.errorCode, body: UserDataService.instance.errorMessage)
                }
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
                
        })
        
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDataService.instance.getUpcomingGames().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: upcomingID) as? UpcomingTableViewCell
        {
            let game = UserDataService.instance.getUpcomingGames()[indexPath.row]
            cell.updateViews(upcomingGame: game)
            return cell
        }
        else{
            return UpcomingTableViewCell()
        }
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Selected Row : ", indexPath.row)
//        //let game = UserDataService.instance.getGamePredictionList()[indexPath.row]
//        index = indexPath.row
//        performSegue(withIdentifier: "predictNow", sender: index)
//    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let predictNowVC = segue.destination as? PredictNowVC
//        let barBtn = UIBarButtonItem()
//        barBtn.title = ""
//        navigationItem.backBarButtonItem = barBtn
//        //predictNowVC?.initPredictionDeatils(game : sender as! GamePredictionList)
//        predictNowVC?.index = index
//    }
}

