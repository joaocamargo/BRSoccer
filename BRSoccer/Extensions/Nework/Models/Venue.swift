//
//  Venue.swift
//  BRSoccer
//
//  Created by joao camargo on 03/10/21.
//

import Foundation

struct Venue: Codable {
    let venueID: Int
    let name: String
    let capacity: Int
    let city: String
    let countryID: Int

    enum CodingKeys: String, CodingKey {
        case venueID = "venue_id"
        case name, capacity, city
        case countryID = "country_id"
    }
}
