//
//  URLSession+Ext.swift
//  StudyPlayGrounds
//
//  Created by joao camargo on 29/09/21.
//

import Foundation


extension URLSession {
    typealias Handler = (Data?, URLResponse?, Error?) -> Void

    // original, mas esta sendo usado o abaixo
//    @discardableResult
//    func request(
//        endpoint: Endpoint,
//        then handler: @escaping Handler
//    ) -> URLSessionDataTask {
//        let task = dataTask(
//            with: endpoint.url,
//
//            completionHandler: handler
//        )
//
//        task.resume()
//        return task
//    }
    
    @discardableResult
    func request(
        endpoint: Endpoint,
        then handler: @escaping Handler
    ) -> URLSessionDataTask {
        let task = dataTask(
            with: endpoint.request,
            completionHandler: handler
        )

        task.resume()
        return task
    }
    
}
