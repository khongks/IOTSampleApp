//
//  CameraViewController.swift
//  IOTSampleApp
//
//  Created by khongks on 10/6/17.
//  Copyright © 2017 spocktech. All rights reserved.
//

import UIKit
import SwiftCloudant

class CameraViewController: UIViewController {

  @IBOutlet weak var imageFromDb: UIImageView!
  
  var fetchedImage: UIImage!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
  }
    
  
  @IBAction func showPicturePressed(_ sender: Any) {
    getPicture()
  }
  
  func getPicture() {
    let database = "pictures"
    
    //get picture
    let find = FindDocumentsOperation(
      selector: [:],
      databaseName: database,
      fields: ["value", "pic_date"],
      limit: 1,
      skip: 0,
      sort:  [],
      bookmark: nil,
      useIndex: nil,
      r: 1) { (response, httpInfo, error) in
        if let error = error {
          print("Encountered an error while reading a document. Error:\(error)")
        } else {
          //get the temp value from JSON
          do {
            let data = try JSONSerialization.data(
              withJSONObject: response!,
              options: [])
            
            let parsedJson = try JSONSerialization.jsonObject(
              with: data,
              options: []) as! [String:Any]
            if let nestedArray = parsedJson["docs"] as? NSArray {
              
              //getting nested temp from payload
              let newDoc = nestedArray[0] as? [String:Any]
              
              // access nested dictionary values by key
              let encodedImage = newDoc?["value"] as! String
              let index = encodedImage.index(
                encodedImage.startIndex,
                offsetBy: 22)
              
              let jpgImage = encodedImage.substring(from: index)
              //data:image/png;base64,
              
              let imageData = NSData(base64Encoded: jpgImage, options: [])!
              let image = UIImage(data: imageData as Data)
              
              print(image?.size as Any)
              self.fetchedImage = image!
              
              //show the picture //we need to wait for the result
              DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10), execute: {
                self.imageFromDb.image = self.fetchedImage
              })
            }
          } catch  let error as NSError {
            print(error)
          }
        }
    }
    cloudantClient.add(operation:find)
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
