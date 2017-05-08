//
//  ViewController.swift
//  Assignment4-Currency
//
//  Created by Ajay Shenoy on 4/14/17.
//  Copyright © 2017 Ajay Shenoy. All rights reserved.
//
import UIKit
//UITableViewDelegate, UITableViewDataSource
class ViewController: UITableViewController{
    let favPage:CurrencyClass=CurrencyClass.CurrencyCodeValue
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeRight:UISwipeGestureRecognizer=UISwipeGestureRecognizer(target: self, action: #selector(HandleSwipe))
        swipeRight.direction=UISwipeGestureRecognizerDirection.right
        view.addGestureRecognizer(swipeRight)
        print(favPage.fav)
            }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favPage.fav.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let fav=favPage.fav[indexPath.row]
        for (key,value) in fav{
        cell.textLabel?.text = key+"->"+value
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
    func HandleSwipe(_ sender:UIGestureRecognizer){
        self.performSegue(withIdentifier: "unwindToConvertor", sender: self)
    }
    
   
            //Data has to be a variable name in your RandomViewController
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    //}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
