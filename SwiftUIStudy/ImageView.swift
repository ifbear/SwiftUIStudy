//
//  ImageView.swift
//  SwiftUIStudy
//
//  Created by dexiong on 2022/6/9.
//

import SwiftUI

struct ImageView : View {
    @Binding var image: UIImage
    @State var showPreview = false
    var body: some View {
        return Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipped()
            .onTapGesture {
                showPreview = true
            }
            .sheet(isPresented: $showPreview) {
                VStack {
                    HStack {
                        Button {
                            showPreview = false
                        } label: {
                            Text("Done")
                                .bold()
                        }
                        Spacer()
                    }
                    .padding()
                    Preview(items: [ImageItem(image)])
                }
                
            }
    }
}
