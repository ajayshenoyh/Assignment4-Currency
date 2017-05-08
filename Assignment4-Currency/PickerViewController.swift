//
//  PickerViewController.swift
//  PickerExample
//
//  Created by Ajay Shenoy on 4/3/17.
//  Copyright © 2017 Ajay Shenoy. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    let convertPage:CurrencyClass = CurrencyClass.CurrencyCodeValue
    var homeCurrencyCode:String="RON"
    var foreignCurrencyCode:String="RON"
    var homeCurrencyValue:String=""
    var foreignCurrencyValue:String=""
    var currency:[String:String]=[:]
    var rate:String=""
    @IBOutlet weak var homeCurrencyPickerView: UIPickerView!
    @IBOutlet weak var foreignCurrencyPickerView: UIPickerView!
    var pickerData = ["Red", "Green", "Blue"]
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeLeft.direction=UISwipeGestureRecognizerDirection.left
        view.addGestureRecognizer(swipeLeft)
        currency=convertPage.currencyCode
        
        // Do any additional setup after loading the view.
        homeCurrencyPickerView.dataSource=self
        homeCurrencyPickerView.tag=1
        homeCurrencyPickerView.delegate=self
        foreignCurrencyPickerView.tag=2
        foreignCurrencyPickerView.dataSource=self
        foreignCurrencyPickerView.delegate=self
        
        
        // Do any additional setup after loading the view.
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            homeCurrencyCode=Array(currency.keys)[row] as String
            homeCurrencyValue=Array(currency.values)[row] as String
        } else if pickerView.tag == 2{
            foreignCurrencyCode=Array(currency.keys)[row] as String
            foreignCurrencyValue=Array(currency.values)[row] as String
        }
    }
    @IBOutlet weak var foreignPickerViewValue: UIPickerView!
    @IBOutlet weak var homePickerViewValue: UIPickerView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBAction func convertCurrency(_ sender: UIButton) {
    
       
        //https://www.ioscreator.com/tutorials/display-an-alert-view-in-ios8-with-swift
        let myYQL = YQL()
        //let queryString = "select * from yahoo.finance.quote where symbol in (\"YHOO\",\"AAPL\",\"GOOG\",\"MSFT\")"
        let queryString = "select * from yahoo.finance.xchange where pair in (\"GBPUSD\",\""+homeCurrencyCode+foreignCurrencyCode+"\")"
        // Network session is asyncronous so use a closure to act upon data once data is returned
        myYQL.query(queryString) { jsonDict in
            // With the resulting jsonDict, pull values out
            // jsonDict["query"] results in an Any? object
            // to extract data, cast to a new dictionary (or other data type)
            // repeat this process to pull out more specific information
            let queryDict = jsonDict["query"] as! [String: Any]
            let resultsDict = queryDict["results"] as! [String: Any]
            let rateArray = resultsDict["rate"] as! [Any]
            let rateDict = rateArray[1] as! [String:String]
            //print(queryDict["count"]!)
            //print(rateDict)
            //print(rateArray[1])
            self.rate=rateDict["Rate"]!
           
        }
        
        if Thread.isMainThread {
            sleep(1)
         self.resultLabel.text="1 \(homeCurrencyValue) = \(self.rate) \(foreignCurrencyValue)"
            
            convertButton.isEnabled = true
            convertButton.setTitleColor(.red, for: .normal)
        }
        // Needed to let async operation finish
        // Could handle with semaphores or closures instead...
        
        RunLoop.main.run()

    }
    @IBOutlet weak var convertButton: UIButton!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //return pickerData.count
        return currency.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //return pickerData[row]
        return "\(Array(currency.values)[row])"
    }
    func handleSwipe(_ sender:UIGestureRecognizer){
        self.performSegue(withIdentifier: "showFav", sender: self)
        
        
    }
    // Enable unwinding other views
    
    @IBAction func unwindToConvertor(segue:UIStoryboardSegue){
        var row1:Int=0
        var row2:Int=0
        var count:Int=0
        for (key,value) in convertPage.clickedFav{
        self.homeCurrencyCode=key
        self.foreignCurrencyCode=value
        }
        for (key,value) in convertPage.currencyCode{
            count=count+1
            if(key == self.homeCurrencyCode){
                self.homeCurrencyValue=value
                row1=count-1
            }
            else if(key == self.foreignCurrencyCode){
                self.foreignCurrencyValue=value
                row2=count-1
            }
        }
        
        
        self.homeCurrencyPickerView.selectRow(row1, inComponent: 0, animated: false)
        self.foreignCurrencyPickerView.selectRow(row2, inComponent: 0, animated: false)
        }
    
    
    @IBAction func addToFav(_ sender: UIButton) {
        var flag=true
        for favor in convertPage.fav
        {
            for (key,value) in favor {
                if homeCurrencyCode==key && foreignCurrencyCode==value {
                    flag=false
                }
            }
        }
        if homeCurrencyCode != foreignCurrencyCode{
            if flag{
                convertPage.fav.append([homeCurrencyCode:foreignCurrencyCode])
            }
            else {
            let alert = UIAlertController(title: "Favorite Conversion", message: "Already added to Favorites!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            }
        }
        else {
            let alert = UIAlertController(title: "Favorite Conversion", message: "Choose different combination!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
