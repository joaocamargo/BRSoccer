//
//  SeasonService.swift
//  StudyPlayGrounds
//
//  Created by joao camargo on 29/09/21.
//

import Foundation

struct SeasonEnum {
     static let Brasileirao2021 = 1905     
  }


class SeasonService: BaseServiceProtocol {
    
    static let shared = SeasonService()

    typealias T = Season
    
    func get(id: Int,using session: URLSession = .shared, completed: @escaping (Result<T, CustomErrors>) -> Void) {
        session.request(endpoint: .season(seasonId: id)) {  data, response, error in

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
    
    //father == leagueId
    func getAll(fatherId id: Int,using session: URLSession = .shared, completed: @escaping (Result<[T], CustomErrors>) -> Void) {
        print(Endpoint.seasons(leagueId: id).url)
        
        session.request(endpoint: .seasons(leagueId: id)) {  data, response, error in

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
}
