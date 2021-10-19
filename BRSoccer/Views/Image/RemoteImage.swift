//
//  RemoteImage.swift
//  BRSoccer
//
//  Created by joao camargo on 18/10/21.
//

import Foundation
import SwiftUI

struct RemoteImage: View {

    
    @ObservedObject var remoteImageURL: RemoteImageURL
    var foreGroundColor: Color = .white
    var backGroundColor: Color = .white
    var width: CGFloat = 70
    var height: CGFloat = 70

    init(imageUrl: String, foreGroundColor: Color = .white, backGroundColor: Color = .white, width: CGFloat = 70, height: CGFloat = 70) {
        remoteImageURL = RemoteImageURL(imageURL: imageUrl)
        self.foreGroundColor = foreGroundColor
        self.backGroundColor = backGroundColor
        self.width = width
        self.height = height
    }
    
//    init(imageUrl: String) {
//        remoteImageURL = RemoteImageURL(imageURL: imageUrl)
//    }
    
    var body: some View {
        Image(uiImage: (UIImage(data: remoteImageURL.data) ?? UIImage(named: "brasaoPlaceHolder"))!)
            .resizable()
            //.foregroundColor(foreGroundColor)
            .padding()
            //.background(Color.white)
            .clipShape(Circle())
            .frame(width: width, height: height)
    }
}
