//
//  ImageViewContainer.swift
//  BRSoccer
//
//  Created by joao camargo on 02/10/21.
//

import SwiftUI

struct ImageViewContainer: View {
    @ObservedObject var remoteImageURL: RemoteImageURL
    
    init(imageUrl: String) {
        remoteImageURL = RemoteImageURL(imageURL: imageUrl)
    }
    
    var body: some View {
        Image(uiImage: (UIImage(data: remoteImageURL.data) ?? UIImage(named: "brasaoPlaceHolder"))!)
            .resizable()
        //.clipShape(Circle())
        //.overlay(Circle().stroke(Color.black, lineWidth: 3.0))
            .frame(width: 50, height: 50)
    }
}
