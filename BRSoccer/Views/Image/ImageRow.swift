//
//  ImageRow.swift
//  BRSoccer
//
//  Created by joao camargo on 02/10/21.
//

import SwiftUI

struct ImageRow: View {
    let model: Team
    var body: some View {
        VStack(alignment: .center) {
            ImageViewContainer(imageUrl: model.logo)
        }
    }
}
