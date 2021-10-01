//
//  League.swift
//  StudyPlayGrounds
//
//  Created by joao camargo on 29/09/21.
//

import Foundation

struct League: Codable, Identifiable {
    
    var id: Int {
        leagueID
    }
    
    let leagueID, countryID: Int
    let name: String
    
    enum CodingKeys: String,CodingKey {
        case leagueID = "league_id"
        case countryID = "country_id"
        case name
    }
}
