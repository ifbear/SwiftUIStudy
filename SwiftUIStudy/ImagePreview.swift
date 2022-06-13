//
//  ImagePreview.swift
//  SwiftUIStudy
//
//  Created by dexiong on 2022/6/9.
//

import Foundation
import SwiftUI


struct ImagePreview : View {
    @Binding var image: UIImage
    @Binding var show: Bool
    
    var body: some View {
        ZStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        .padding(8)
        .background(Color.black)
        .cornerRadius(8)
        .shadow(radius: 5)
        .onTapGesture {
            show = false
        }
    }
}
