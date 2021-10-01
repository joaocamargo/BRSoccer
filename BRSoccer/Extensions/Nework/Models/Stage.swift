//
//  Stage.swift
//  StudyPlayGrounds
//
//  Created by joao camargo on 30/09/21.
//

import Foundation

struct Stage: Codable , Identifiable {
    
    var id: Int {
        stageID
    }
    
    let stageID: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case stageID = "stage_id"
        case name
    }
}
