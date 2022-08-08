//
//  NetworkManager.swift
//  TernovskoyHW2.10
//
//  Created by Илья Терновской on 11.06.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    
    func fetchData(_ completion: @escaping (BitcoinIndex, [Bitcoin]) -> Void) {
        
        let jsonURL = "https://api.coindesk.com/v1/bpi/currentprice.json"
        guard let url = URL(string: jsonURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error { print(error); return }
            guard let data = data else { return }
            
            do {
                let currencyRates = try JSONDecoder().decode(BitcoinIndex.self, from: data)
                let rates = currencyRates.bpi.map { $0.value }
                completion(currencyRates, rates)
            } catch let jsonError {
                print("Ошибка получения данных:", jsonError)
            }
        }.resume()
    }
}
 
