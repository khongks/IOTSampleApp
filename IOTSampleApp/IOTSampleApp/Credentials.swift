//
//  Credentials.swift
//  IOTSampleApp
//
//  Created by khongks on 10/6/17.
//  Copyright © 2017 spocktech. All rights reserved.
//

import Foundation

class Credentials {
  
  /*
  {
  "username": "4b16b0da-212f-4fc5-bc34-31274dfe37c2",
  "password": "MNXRxpefbN",
  "host": "twcservice.mybluemix.net",
  "port": 443,
  "url": "https://4b16b0da-212f-4fc5-bc34-31274dfe37c2:MNXRxpefbN@twcservice.mybluemix.net"
  }
  */
  // The Weather Channel
  static let weatherHost = "twcservice.mybluemix.net"
  static let weatherUsername = "4b16b0da-212f-4fc5-bc34-31274dfe37c2"
  static let weatherPassword = "MNXRxpefbN"

 /*
   {
   "username": "ab73cb00-8aa3-4e92-b22b-82bf3ca54758-bluemix",
   "password": "a51f5f519eb9541b824955cfde1ccda77c8c387624f0d37c13bb503891b9c8c9",
   "host": "ab73cb00-8aa3-4e92-b22b-82bf3ca54758-bluemix.cloudant.com",
   "port": 443,
   "url": "https://ab73cb00-8aa3-4e92-b22b-82bf3ca54758-bluemix:a51f5f519eb9541b824955cfde1ccda77c8c387624f0d37c13bb503891b9c8c9@ab73cb00-8aa3-4e92-b22b-82bf3ca54758-bluemix.cloudant.com"
   }
  */
  // Cloudant
  static let cloudantUrl = NSURL(string: "https://ab73cb00-8aa3-4e92-b22b-82bf3ca54758-bluemix:a51f5f519eb9541b824955cfde1ccda77c8c387624f0d37c13bb503891b9c8c9@ab73cb00-8aa3-4e92-b22b-82bf3ca54758-bluemix.cloudant.com")
  static let cloudantUsername = "ab73cb00-8aa3-4e92-b22b-82bf3ca54758-bluemix"
  static let cloudantPassword = "a51f5f519eb9541b824955cfde1ccda77c8c387624f0d37c13bb503891b9c8c9"
  
  // Watson IOT
  static let IOT_BASE = "messaging.internetofthings.ibmcloud.com"
  static let ORG_ID = "oweys3"
  static let IOT_API_KEY = "a-oweys3-2orwiyui8e"
  static let IOT_AUTH_TOKEN = "WvZlsB--xnpLLKV(m6"
  
  static let DEV_TYPE = "RPI3"
  static let DEV_ID = "RaspberryPI3"
  
  /*
   {
   "url": "https://stream.watsonplatform.net/text-to-speech/api",
   "username": "c70a4c48-5e70-41d6-95a0-26e42d74c9f0",
   "password": "7NM87PhR48n2"
   }
  */
  static let textToSpeechUsername = "c70a4c48-5e70-41d6-95a0-26e42d74c9f0"
  static let textToSpeechPassword = "7NM87PhR48n2"
  
  /*
   {
   "url": "https://stream.watsonplatform.net/speech-to-text/api",
   "username": "548d701c-5d76-491a-918d-d076ae2f4a16",
   "password": "gBvUejeK7Icz"
   }
  */
  static let speechToTextUsername = "548d701c-5d76-491a-918d-d076ae2f4a16"
  static let speechToTextPassword = "gBvUejeK7Icz"
}
