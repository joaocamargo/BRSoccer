//
//  ConfigService.swift
//  StudyPlayGrounds
//
//  Created by joao camargo on 01/10/21.
//

import Foundation

var config = ConfigService()

class ConfigService {
    
    
    func readConfig() -> String {
        if let path = Bundle.main.path(forResource: "Config", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                  
                  if let jsonResult = jsonResult as? Dictionary<String, String>, let config = jsonResult["apiKey2"] {
                      return config
                  }
              } catch {
                   // handle error
              }
        }
        return ""
    }
}
