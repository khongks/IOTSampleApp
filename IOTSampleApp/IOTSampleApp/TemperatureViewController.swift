//
//  TemperatureViewController.swift
//  IOTSampleApp
//
//  Created by khongks on 10/6/17.
//  Copyright © 2017 spocktech. All rights reserved.
//

import UIKit

import SwiftCloudant

class TemperatureViewController: UIViewController {
  
  
  @IBOutlet weak var temperatureLabel: UILabel!
  
  private var jsonTemp = 0.0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
    
  @IBAction func refreshPressed(_ sender: Any) {
    NSLog("refresh IoT Temp button pressed") //get the temp
    //update the label
    getTemperature()
  }

  func getTemperature() {
    let database = "temperatures"
    
    let sortSyntax = Sort(field: "timestamp", sort: Sort.Direction.desc)
    let find = FindDocumentsOperation(selector: [:], databaseName: database, fields: ["payload", "timestamp"], limit: 1, skip: 0, sort: [sortSyntax], bookmark: nil, useIndex: nil, r: 1)
    { (response, httpInfo, error) in
      if let error = error {
        print("Encountered an error while reading a document. Error:\(error)")
      } else {
        print("Read document: \(String(describing: response))")
        self.parseTemperature(jsonData: response!)
      }
    }
    cloudantClient.add(operation: find)
    //update the label
  }
  
  func parseTemperature(jsonData: Any) {
    //get the temp value from JSON
    do {
      let data = try JSONSerialization.data(withJSONObject: jsonData, options: [])
      
      let parsedJson = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
      if let nestedArray = parsedJson["docs"] as? NSArray {
        
        print("nested 1: \(nestedArray)")
        //getting nested temp from payload
        let newDoc = nestedArray[0] as? [String:Any]
        
        print("nested 2: \(String(describing: newDoc))")
        // access nested dictionary values by key
        
        let currentTemperature = (newDoc?["payload"] as! NSString).doubleValue
        
        print("found temp: \(currentTemperature)")
        self.jsonTemp = currentTemperature
        
        // *** update the label ***
        // we need to wait for the results
        temperatureLabel.text = "0.0˚C"
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
          // Put your code which should be executed with a delay here
          NSLog("Read doc: 1 sec")
          self.temperatureLabel.text = "\(self.jsonTemp)˚C"
        })
      }
    } catch let error as NSError {
      print(error)
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
