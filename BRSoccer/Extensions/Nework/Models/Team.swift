//
//  Team.swift
//  BRSoccer
//
//  Created by joao camargo on 02/10/21.
//

import Foundation


struct Team: Codable, Identifiable {
    
    var id: Int {
        return teamID
    }
    
    let teamID: Int
    let name, shortCode: String
    let commonName: String?
    let logo: String
    let country: Country
    
    
    var nameToShow : String {
        return commonName != nil && commonName != "" ? commonName! : name
    }

    enum CodingKeys: String, CodingKey {
        case teamID = "team_id"
        case name
        case shortCode = "short_code"
        case commonName = "common_name"
        case logo, country
    }
}
