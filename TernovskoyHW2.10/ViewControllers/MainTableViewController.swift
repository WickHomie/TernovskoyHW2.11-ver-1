//
//  MainTableViewController.swift
//  TernovskoyHW2.10
//
//  Created by Илья Терновской on 07.06.2022.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    private var bitcoin: [Bitcoin] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setResult()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bitcoin.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RatesTableViewCell
        let bitcoin = bitcoin[indexPath.row]
        cell.configure(with: bitcoin)
        
        return cell
    }
    
    private func setResult() {
        NetworkManager.shared.fetchData { _, bitcoin in
            DispatchQueue.main.async {
                self.bitcoin = bitcoin
                self.tableView.reloadData()
            }
        }
    }
    

}

