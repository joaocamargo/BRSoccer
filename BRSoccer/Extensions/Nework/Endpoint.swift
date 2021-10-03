//
//  Endpoint.swift
//  StudyPlayGrounds
//
//  Created by joao camargo on 29/09/21.
//

import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
    var method: String = "GET"
    var headers: [String: String] = [:]
}

extension Endpoint {
   
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "app.sportdataapi.com"
        //components.host = "api.cosmos.bluesoft.com.br" //teste com headers
        components.path = "/" + path
        components.queryItems = queryItems

        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }

        return url
    }
    
    var request: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
    
}

extension Endpoint {
    static func leagues(countryId id: Int) -> Self {
        return Endpoint(path: "api/v1/soccer/leagues",
                        queryItems: [ URLQueryItem(name: "apikey", value: sportDataApi.key),URLQueryItem(name: "country_id", value: String(id))],
                        method: "GET",
                        headers: ["Content-Type" : "application/json"])
    }
    
    static func league(leagueId id: Int) -> Self {
        return Endpoint(path: "api/v1/soccer/leagues/\(id)",
                        queryItems: [ URLQueryItem(name: "apikey", value: sportDataApi.key)],
                        method: "GET",
                        headers: ["Content-Type" : "application/json"])
    }
    
    
    static func seasons(leagueId id: Int) -> Self {
        return Endpoint(path: "api/v1/soccer/seasons",
                        queryItems: [ URLQueryItem(name: "apikey", value: sportDataApi.key),URLQueryItem(name: "league_id", value: String(id))],
                        method: "GET",
                        headers: ["Content-Type" : "application/json"])
    }
    
    static func season(seasonId id: Int) -> Self {
        return Endpoint(path: "api/v1/soccer/seasons/\(id)",
                        queryItems: [ URLQueryItem(name: "apikey", value: sportDataApi.key)],
                        method: "GET",
                        headers: ["Content-Type" : "application/json"])
    }
    
    
    static func stages(seasonId id: Int) -> Self {
        return Endpoint(path: "api/v1/soccer/stages",
                        queryItems: [ URLQueryItem(name: "apikey", value: sportDataApi.key),URLQueryItem(name: "season_id", value: String(id))],
                        method: "GET",
                        headers: ["Content-Type" : "application/json"])
    }
    
    static func stage(stageId id: Int) -> Self {
        return Endpoint(path: "api/v1/soccer/stages/\(id)",
                        queryItems: [ URLQueryItem(name: "apikey", value: sportDataApi.key)],
                        method: "GET",
                        headers: ["Content-Type" : "application/json"])
    }
    
    
    static func teams(countryId id: Int) -> Self {
        return Endpoint(path: "api/v1/soccer/teams",
                        queryItems: [ URLQueryItem(name: "apikey", value: sportDataApi.key),URLQueryItem(name: "country_id", value: String(id))],
                        method: "GET",
                        headers: ["Content-Type" : "application/json"])
    }
    
    static func team(teamId id: Int) -> Self {
        return Endpoint(path: "api/v1/soccer/teams/\(id)",
                        queryItems: [ URLQueryItem(name: "apikey", value: sportDataApi.key)],
                        method: "GET",
                        headers: ["Content-Type" : "application/json"])
    }
    
    
    static func matches(seasonId id: Int, dateFrom: String = "2021-09-01",dateTo: String = "2021-09-20") -> Self {
        return Endpoint(path: "api/v1/soccer/matches",
                        queryItems: [ URLQueryItem(name: "apikey", value: sportDataApi.key),
                                      URLQueryItem(name: "season_id", value: String(id)),
                                      URLQueryItem(name: "date_from", value: dateFrom),
                                      URLQueryItem(name: "date_to", value: dateTo)
                                    ],
                        method: "GET",
                        headers: ["Content-Type" : "application/json"])
    }
    
    
    static func matche(matchId id: Int, dateFrom: String = "2021-01-01") -> Self {
        return Endpoint(path: "api/v1/soccer/matches/\(id)",
                        queryItems: [ URLQueryItem(name: "apikey", value: sportDataApi.key)],
                        method: "GET",
                        headers: ["Content-Type" : "application/json"])
    }
    
}
