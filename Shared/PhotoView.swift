//
//  PhotoView.swift
//  PhotoLoader
//
//  Created by Alexander v. Below on 22.11.21.
//

import SwiftUI

struct PhotoView: View {
    @ObservedObject var imageLoader: Remote<UIImage>

    var body: some View {
        ZStack {
        if let uiImage = imageLoader.value {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Text ("Loading")
        }
        }
    }
}
