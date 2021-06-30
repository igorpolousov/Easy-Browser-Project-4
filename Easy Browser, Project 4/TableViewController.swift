//
//  TableViewController.swift
//  Easy Browser, Project 4
//
//  Created by Igor Polousov on 30.06.2021.
//

import UIKit

class TableViewController: UITableViewController {

    // Создали массив с сайтами
    var websites = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        websites = ["hackingwithswift.com", "apple.com", "mywool.shop"]
        
        title = "Easy browser"
        navigationController?.navigationBar.prefersLargeTitles = true

    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = websites[indexPath.row]
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "WebView") as? ViewController {
            vc.selectedWebsite = websites[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
