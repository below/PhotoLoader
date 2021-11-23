//
//  ListPhotoView.swift
//  PhotoLoader
//
//  Created by Alexander v. Below on 22.11.21.
//

import SwiftUI

struct ListPhotoView: View {
    let uiImage: UIImage?
    let title: String

    var body: some View {
        HStack {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 20)
            } else {
                Image(systemName: "photo")
            }
            Text(title)
        }
    }
}

struct ListPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        ListPhotoView(uiImage: nil,
                        title: "Hello")
    }
}
