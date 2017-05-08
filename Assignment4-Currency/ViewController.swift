//
//  ViewController.swift
//  Assignment4-Currency
//
//  Created by Ajay Shenoy on 4/14/17.
//  Copyright © 2017 Ajay Shenoy. All rights reserved.
//
import UIKit
class ViewController: UITableViewController{
    let favPage:CurrencyClass=CurrencyClass.CurrencyCodeValue
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeRight:UISwipeGestureRecognizer=UISwipeGestureRecognizer(target: self, action: #selector(HandleSwipe))
        swipeRight.direction=UISwipeGestureRecognizerDirection.right
        view.addGestureRecognizer(swipeRight)
        print(favPage.fav)
            }
    
    // MARK: - Table configuration
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favPage.fav.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let fav=favPage.fav[indexPath.row]
        for (key1,key2) in fav{
            if let home = favPage.currencyCode[key2], let forg = favPage.currencyCode[key1] {
                cell.textLabel?.text = home+"->"+forg
            }
            else
            {
                cell.textLabel?.text = key1+"->"+key2
            }
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        favPage.clickedFav=favPage.fav[indexPath.row]
        favPage.row=indexPath.row
        self.performSegue(withIdentifier: "unwindToConvertor", sender: self)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segue to convertor
    func HandleSwipe(_ sender:UIGestureRecognizer){
        self.performSegue(withIdentifier: "unwindToConvertor", sender: self)
    }
    

}
