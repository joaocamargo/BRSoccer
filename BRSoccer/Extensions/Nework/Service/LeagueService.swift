//
//  LeagueService.swift
//  StudyPlayGrounds
//
//  Created by joao camargo on 29/09/21.
//

import Foundation

class LeagueService : BaseServiceProtocol {
    
    //typealias LeagueResult = ApiResult<League>
    
    static let shared = LeagueService()

    typealias T = League
    
    func get(id: Int,using session: URLSession = .shared, completed: @escaping (Result<T, CustomErrors>) -> Void) {
        session.request(endpoint: .league(leagueId: id)) {  data, response, error in

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
        print(Endpoint.leagues(countryId: id).url)
        
        session.request(endpoint: .leagues(countryId: id)) {  data, response, error in

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else { return }
            guard let decodedValue = try? self.decodeJsonErrors(ApiResultsAsDictionary<League>.self, data) else {
                completed(.failure(.invalidData))
                return
            }
            let resultObjects = decodedValue.data.values.map { $0 }
            completed(.success(resultObjects))
        }
    }
}
