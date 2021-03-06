//
//  PastPredictionVC.swift
//  Score Pedicta
//
//  Created by Soumya Ranjan Sethy on 12/11/17.
//  Copyright © 2017 Soumya Ranjan Sethy. All rights reserved.
//

import UIKit

class PastPredictionVC: UIViewController,UITableViewDataSource,UITableViewDelegate  {
    @IBOutlet weak var pastTable: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        pastTable.isHidden = true
        pastTable.dataSource = self
        pastTable.delegate = self
        self.pastTable.rowHeight = 250
        self.pastTable.tableFooterView = UIView()
        spinner.isHidden = false
        spinner.startAnimating()
        AuthService.instance.pastGames(pageNo: "0", pageSize: "10", completion:
            { (success) in
                if success {
                    self.pastTable.reloadData()
                    self.pastTable.isHidden = false
                    if UserDataService.instance.getPastGames().count == 0
                    {
                        let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: self.pastTable.bounds.size.width, height: self.pastTable.bounds.size.height))
                        noDataLabel.text          = "No data available"
                        noDataLabel.textColor     = UIColor.black
                        noDataLabel.textAlignment = .center
                        self.pastTable.backgroundView  = noDataLabel
                        self.pastTable.separatorStyle  = .none
                        
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
        return UserDataService.instance.getPastGames().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: pastID) as? PastPredictionTableViewCell
        {
            let game = UserDataService.instance.getPastGames()[indexPath.row]
            cell.updateViews(pastGames: game)
            return cell
        }
        else{
            return PastPredictionTableViewCell()
        }
    }
    
}
