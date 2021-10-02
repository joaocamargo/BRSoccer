//
//  StagesService.swift
//  StudyPlayGrounds
//
//  Created by joao camargo on 30/09/21.
//

import Foundation

class StageService: BaseServiceProtocol {
    
    static let shared = StageService()

    typealias T = Stage
    
    func get(id: Int,using session: URLSession = .shared, completed: @escaping (Result<T, CustomErrors>) -> Void) {
        session.request(endpoint: .stage(stageId: id)) {  data, response, error in

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
        print(Endpoint.stages(seasonId: id).url)
        
        session.request(endpoint: .stages(seasonId: id)) {  data, response, error in

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
