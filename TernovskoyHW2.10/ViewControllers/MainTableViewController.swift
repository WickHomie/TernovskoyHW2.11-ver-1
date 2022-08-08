//
//  MainTableViewController.swift
//  TernovskoyHW2.10
//
//  Created by Илья Терновской on 07.06.2022.
//

import UIKit
import Alamofire

class MainTableViewController: UITableViewController {
    
    private var bitcoin: [Bitcoin] = []
    private var spinnerView: UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
        spinnerView = showSpinner(in: tableView)
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
        AF.request("https://api.coindesk.com/v1/bpi/currentprice.json")
            .validate()
            .responseDecodable(of: [BitcoinIndex].self) { response in
                switch response.result {
                    case .success(let value):
                    guard let bitcoinsData = value as? [[String:Any]] else { return }
                    
                    for bitcoinData in bitcoinsData {
                        let bitcoin = Bitcoin(
                            code: bitcoinData["code"] as? String,
                            symbol: bitcoinData["symbol"] as? String,
                            rate: bitcoinData["rate"] as? String,
                            description: bitcoinData["description"] as? String,
                            rate_float: bitcoinData["rate_float"] as? Double
                        )
                        self.bitcoin.append(bitcoin)
                    }
                    
                    DispatchQueue.main.async {
                        self.spinnerView?.stopAnimating()
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
    

}

