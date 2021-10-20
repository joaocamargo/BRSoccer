//
//  MatchesService.swift
//  BRSoccer
//
//  Created by joao camargo on 03/10/21.
//

import Foundation

class MatchesService : BaseServiceProtocol {
    
    //typealias LeagueResult = ApiResult<League>
    
    static let shared = MatchesService()
    
    typealias T = Match
    
    func get(id: Int,using session: URLSession = .shared, completed: @escaping (Result<T, CustomErrors>) -> Void) {
        session.request(endpoint: .matche(matchId: id)) {  data, response, error in

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
        //print(Endpoint.leagues(countryId: id).url)
        
        session.request(endpoint: .matches(seasonId: id)) {  data, response, error in

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
    
    func getAllMatchesOfADate(fatherId id: Int, matchDate: Date,using session: URLSession = .shared, completed: @escaping (Result<[T], CustomErrors>) -> Void) {
        //print(Endpoint.leagues(countryId: id).url)
        
        let matchDateString = matchDate.addDays(numberOfDays: 0).converToYearMonthDateFormat()
        let matchDateEndString = Date().converToYearMonthDateFormat() // matchDate.addDays(numberOfDays: 0).converToYearMonthDateFormat()
        
        SeasonService.shared.getAll(fatherId: LeagueEnum.Brasileirao) { result in
            switch result{
            case .success(let seasons):
                guard let season =  (seasons.first { $0.isCurrent == 1}) else { return }
                
                session.request(endpoint: .matches(seasonId: season.id,dateFrom: matchDateString, dateTo: matchDateEndString)) {  data, response, error in
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
            case .failure(let error):
                print(error.localizedDescription)
                //agora tenho todas a season, com a season eu posso chegar nos jogos
            }
        }
    }
}
