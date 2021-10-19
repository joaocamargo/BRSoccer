//
//  TeamService.swift
//  BRSoccer
//
//  Created by joao camargo on 02/10/21.
//

import Foundation
import SwiftUI

class TeamService: BaseServiceProtocol {
    
    static let shared = TeamService()
    
    typealias T = Team
    
    func get(id: Int,using session: URLSession = .shared, completed: @escaping (Result<T, CustomErrors>) -> Void) {
        session.request(endpoint: .team(teamId: id)) {  data, response, error in
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else { return }
            guard let decodedValue = try? self.decodeJsonErrors(ApiSingleResult<T>.self, data) else {
                completed(.failure(.invalidData))
                return
            }
            let result = decodedValue.data
            completed(.success(result))
        }
    }
    
    func getAll(fatherId id: Int,using session: URLSession = .shared, completed: @escaping (Result<[T], CustomErrors>) -> Void) {
        session.request(endpoint: .teams(countryId: id)) {  data, response, error in
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else { return }
            guard let decodedValue = try? self.decodeJsonErrors(ApiResultsAsArray<T>.self, data) else {
                completed(.failure(.invalidData))
                return
            }
            let resultObjects = decodedValue.data.map { $0 }
            completed(.success(resultObjects))
        }
    }
    
//    func getBrasilianFirstDivisionTeamsForced(using session: URLSession = .shared, completed: @escaping (Result<[T], CustomErrors>) -> Void) {
//        SeasonService.shared.getAll(fatherId: LeagueEnum.Brasileirao) { result in
//            switch result{
//            case .success(let seasons):
//                guard let season =  (seasons.first { $0.isCurrent == 1}) else { return }
//
//            case .failure(let failure):
//                completed(.failure(failure))
//            }
//        }
//        //  [8204,8278,12481,12476,12477,12487,8212,12486,8205,8199,8214,8208,8267,8223,12488,12479,8266,12490,8207,8231]
//
//    }
    
    func getBrasilianFirstDivisionTeams(using session: URLSession = .shared, completed: @escaping (Result<[T], CustomErrors>) -> Void) {
        
        SeasonService.shared.getAll(fatherId: LeagueEnum.Brasileirao) { result in
            switch result{
            case .success(let seasons):
                guard let season =  (seasons.first { $0.isCurrent == 1}) else { return }
                //agora tenho todas a season, com a season eu posso chegar nos jogos
                
                MatchesService.shared.getAll(fatherId: season.id) { resultMatches in
                    switch resultMatches {
                    case .success(let matches):
                        //com os jogos eu posso retornar os times
                        let allTeamsFirstLeague = matches.map { $0.homeTeam }
                        
                        let uniqueTeamsFirstLeague = allTeamsFirstLeague.unique(map: { $0.id })
                        
                        completed(.success(uniqueTeamsFirstLeague))
                        
                        
                    case .failure(let failure):
                        completed(.failure(failure))
                    }
                }
                
                
            case .failure(let failure):
                completed(.failure(failure))
            }
        }
        
        
    }
    
}


