//
//  Data+Ext.swift
//  StudyPlayGrounds
//
//  Created by joao camargo on 29/09/21.
//

import Foundation

extension Data {
    func printJsonUtf8() -> String {
        return String(data: self, encoding: .utf8)!
    }
}
