//
//  main.swift
//  swift-YQL
//
//  Created by David McLaren on 4/2/17.
//  Copyright © 2017 David McLaren. All rights reserved.
//

import Foundation

// Example usage
let myYQL = YQL()
//let queryString = "select * from yahoo.finance.quote where symbol in (\"YHOO\",\"AAPL\",\"GOOG\",\"MSFT\")"
let queryString = "select * from yahoo.finance.xchange where pair in (\"EURUSD\",\"GBPUSD\",\"USDINR\")"
// Network session is asyncronous so use a closure to act upon data once data is returned
myYQL.query(queryString) { jsonDict in
    // With the resulting jsonDict, pull values out
    // jsonDict["query"] results in an Any? object
    // to extract data, cast to a new dictionary (or other data type)
    // repeat this process to pull out more specific information
    let queryDict = jsonDict["query"] as! [String: Any]
    let resultsDict = queryDict["results"] as! [String: Any]
    let rateDict = resultsDict["rate"] as! [Any]
    print(queryDict["count"]!)
    //print(rateDict)
    print(rateDict[2])
}

// Needed to let async operation finish
// Could handle with semaphores or closures instead...
RunLoop.main.run()
