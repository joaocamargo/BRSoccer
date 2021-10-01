//
//  ApiResult.swift
//  StudyPlayGrounds
//
//  Created by joao camargo on 29/09/21.
//

import Foundation


struct ApiResultsAsDictionary<T:Codable>: Codable {
    let query: Query
    let data: [String:T]
}


struct ApiResultsAsArray<T:Codable>: Codable {
    let query: Query
    let data: [T]
}


struct ApiSingleResult<T:Codable>: Codable {
    let query: Query
    let data: T
}
