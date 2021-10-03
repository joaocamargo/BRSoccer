//
//  Stats.swift
//  BRSoccer
//
//  Created by joao camargo on 03/10/21.
//

import Foundation

struct Stats: Codable {
    let homeScore, awayScore: Int
    let htScore, ftScore: String?
    let etScore, psScore: String?

    enum CodingKeys: String, CodingKey {
        case homeScore = "home_score"
        case awayScore = "away_score"
        case htScore = "ht_score"
        case ftScore = "ft_score"
        case etScore = "et_score"
        case psScore = "ps_score"
    }
}
