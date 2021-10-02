//
//  Country.swift
//  BRSoccer
//
//  Created by joao camargo on 02/10/21.
//

import Foundation


struct Country: Codable, Identifiable {
    
    var id : Int {
        return countryID
    }
    
    let countryID: Int
    let name: String
    let countryCode: String
    let continent: String

    enum CodingKeys: String, CodingKey {
        case countryID = "country_id"
        case name
        case countryCode = "country_code"
        case continent
    }
}
