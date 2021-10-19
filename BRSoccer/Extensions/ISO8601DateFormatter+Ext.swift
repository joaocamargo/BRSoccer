//
//  ISO8601DateFormatter+Ext.swift
//  BRSoccer
//
//  Created by joao camargo on 18/10/21.
//

import Foundation

extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options) {
        self.init()
        self.formatOptions = formatOptions
    }
}
