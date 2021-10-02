//
//  TeamService.swift
//  BRSoccer
//
//  Created by joao camargo on 02/10/21.
//

import Foundation

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
    }


