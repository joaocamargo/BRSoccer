//
//  BaseServiceProtocol.swift
//  StudyPlayGrounds
//
//  Created by joao camargo on 29/09/21.
//

import Foundation

extension JSONDecoder.DateDecodingStrategy {
    static let iso8601withFractionalSeconds = custom {
        let container = try $0.singleValueContainer()
        let string = try container.decode(String.self)
        guard let date = Formatter.iso8601withFractionalSeconds.date(from: string) else {
            throw DecodingError.dataCorruptedError(in: container,
                  debugDescription: "Invalid date: " + string)
        }
        return date
    }
}


protocol BaseServiceProtocol {
      
    associatedtype T:Codable
    
    func get(id: Int,using session: URLSession, completed: @escaping(Result<T,CustomErrors>) -> Void)
    
    func getAll(fatherId: Int,using session: URLSession, completed: @escaping(Result<[T],CustomErrors>) -> Void)
    
}


extension BaseServiceProtocol {
    func decodeJsonErrors<T:Codable>(_ type: T.Type, _ valueToDecode: Data) throws -> T {
        var result: T
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601withFractionalSeconds
        
        do {
            result = try decoder.decode(type.self, from: valueToDecode)
            return result
        } catch DecodingError.dataCorrupted(let context) {
            print(context)
        } catch DecodingError.keyNotFound(let key, let context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch DecodingError.valueNotFound(let value, let context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch DecodingError.typeMismatch(let type, let context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
        return try decoder.decode(type.self, from: Data())
    }
}


