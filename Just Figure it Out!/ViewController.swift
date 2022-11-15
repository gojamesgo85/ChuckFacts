//
//  ViewController.swift
//  Just Figure it Out!
//
//  Created by James on 11/10/22.
//

import UIKit

struct ChuckFact: Decodable {
    let value : String
}
var chuckLabel = UILabel()

//var printFacts = String()
class ViewController: UIViewController {

    let benjamin = ChuckButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        configureSubViews()
    }
    
    func configureSubViews() {
        view.addSubview(benjamin)
        view.addSubview(chuckLabel)
        
        benjamin.translatesAutoresizingMaskIntoConstraints = false
        chuckLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        chuckLabel.backgroundColor = .systemBlue
        
        chuckLabel.layer.borderWidth = 1
        chuckLabel.numberOfLines = 12
        chuckLabel.textAlignment = .center
        chuckLabel.adjustsFontForContentSizeCategory = true
        chuckLabel.font = .systemFont(ofSize: 40)
        chuckLabel.layer.cornerRadius = 23
        chuckLabel.layer.masksToBounds = true
        chuckLabel.font = UIFont.systemFont(ofSize: 23)
        chuckLabel.textColor = .white
        

        
        benjamin.addTarget(self, action: #selector(giveMeTheFact), for: .touchUpInside)
        
        
        
        NSLayoutConstraint.activate([
            benjamin.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            benjamin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            benjamin.heightAnchor.constraint(equalToConstant: 50),
            benjamin.widthAnchor.constraint(equalToConstant: 300),
            
            chuckLabel.bottomAnchor.constraint(equalTo: benjamin.topAnchor, constant: -100),
            chuckLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            chuckLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            chuckLabel.widthAnchor.constraint(equalToConstant: 350),
            
        
        ])
    }
    @objc func giveMeTheFact() {
      
        let headers = [
            "accept": "application/json",
            "X-RapidAPI-Key": "bc9a73da7dmshad208c4b6a57bf9p13e4f3jsnf6beb9575ddb",
            "X-RapidAPI-Host": "matchilling-chuck-norris-jokes-v1.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://matchilling-chuck-norris-jokes-v1.p.rapidapi.com/jokes/random")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                _ = response as? HTTPURLResponse
        
                let facts = try? JSONDecoder().decode(ChuckFact.self, from: data!)
                if let facts = facts {
                    
                    DispatchQueue.main.async {
                        chuckLabel.text = facts.value
                    }
                    
                }
                
                
                    
                
                
            }
             
        })

        dataTask.resume()
    
    }
    
    
    
    
}

