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
    

}

extension MainTableViewController {
    func fetchBitcoin() {
        let jsonURL = "https://api.coindesk.com/v1/bpi/currentprice.json"
        guard let url = URL(string: jsonURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let bitcoin = try JSONDecoder().decode([Bitcoin].self, from: data)
                DispatchQueue.main.async {
                    self.bitcoin = bitcoin
                    self.tableView.reloadData()
                }
               
            } catch let error {
                print(error.localizedDescription)
            }

        }.resume()
    }
}
