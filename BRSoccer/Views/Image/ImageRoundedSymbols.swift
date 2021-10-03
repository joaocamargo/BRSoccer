//
//  ImageViewContainer.swift
//  BRSoccer
//
//  Created by joao camargo on 02/10/21.
//

import SwiftUI

struct ImageRoundedSymbols: View {
    @ObservedObject var remoteImageURL: RemoteImageURL
    
    init(imageUrl: String) {
        remoteImageURL = RemoteImageURL(imageURL: imageUrl)
    }
    
    var body: some View {
        Image(uiImage: (UIImage(data: remoteImageURL.data) ?? UIImage(named: "brasaoPlaceHolder"))!)
            .resizable()
            .foregroundColor(.white)
            .padding()
            .background(Color.white)
            .clipShape(Circle())
            .frame(width: 70, height: 70)
    }
}
