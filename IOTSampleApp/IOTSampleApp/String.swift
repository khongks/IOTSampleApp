//
//  String.swift
//  IOTSampleApp
//
//  Created by khongks on 10/6/17.
//  Copyright © 2017 spocktech. All rights reserved.
//

import Foundation
import UIKit

// Extending String to support Base64 encoding for network requests
extension String {
  func fromBase64() -> String? {
    guard let data = Data(base64Encoded: self) else {
      return nil
    }
    return String(data: data, encoding: .utf8)
  }
  func toBase64() -> String {
    return Data(self.utf8).base64EncodedString()
  }
}
