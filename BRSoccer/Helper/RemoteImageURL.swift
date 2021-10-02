//
//  RemoteImageURL.swift
//  BRSoccer
//
//  Created by joao camargo on 02/10/21.
//

import Foundation
import SwiftUI


class RemoteImageURL: ObservableObject {
    @Published var data = Data()
    
    init(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async { self.data = data }
        }.resume()
    }
}
