//
//  SeasonService.swift
//  StudyPlayGrounds
//
//  Created by joao camargo on 29/09/21.
//

import Foundation

// MARK: - DataClass
struct Season: Codable, Identifiable {
    
    var id: Int  {
        return seasonID
    }
    
    let seasonID: Int
    let name: String
    let isCurrent, countryID, leagueID: Int
    let startDate, endDate: String

    enum CodingKeys: String, CodingKey {
        case seasonID = "season_id"
        case name
        case isCurrent = "is_current"
        case countryID = "country_id"
        case leagueID = "league_id"
        case startDate = "start_date"
        case endDate = "end_date"
    }
}
