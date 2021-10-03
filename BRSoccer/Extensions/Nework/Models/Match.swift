//
//  Match.swift
//  BRSoccer
//
//  Created by joao camargo on 03/10/21.
//

import Foundation

struct Match: Codable, Identifiable {
    
    var id: Int {
        return matchID
    }
    
    let matchID, statusCode: Int
    let status: String
    let matchStart: String
    let leagueID, seasonID: Int
    let homeTeam, awayTeam: Team
    let stats: Stats
    let venue: Venue

    enum CodingKeys: String, CodingKey {
        case matchID = "match_id"
        case statusCode = "status_code"
        case status
        case matchStart = "match_start"
        case leagueID = "league_id"
        case seasonID = "season_id"
        case homeTeam = "home_team"
        case awayTeam = "away_team"
        case stats, venue
    }
}

enum Status: String, Codable {
    case canceled = "canceled"
    case empty = ""
    case finished = "finished"
    case notstarted = "notstarted"
    case postponed = "postponed"
}


enum StatusCode: Int {
  case  notstarted = 0
  case  Inplay =  1
  case  Halftime = 11
  case  Extratime = 12
  case  Penalties = 13
  case  Breaktime = 14
  case  Awarding = 15
  case  UpdateLater = 2
  case  EndedEvent = 3
  case  Afterpenalties = 31
  case  AfterExtra = 32
  case  Postponed = 4
  case  Cancelled = 5
  case  Abandoned = 6
  case  Interrupted = 7
  case  Suspended = 8
  case  Awarded   = 9
  case  Delayed    = 10
  case  ToBeAnnounced = 17
}
