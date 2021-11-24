//
//  ListView.swift
//  PhotoLoader
//
//  Created by Alexander v. Below on 19.11.21.
//

import SwiftUI

protocol DisplayItem {
    var id: String { get }
    var displayName: String {get}
}

struct ListView: View {
    @StateObject var photoLoader = Remote(url: URL(string: "https://picsum.photos/v2/list")!) { data in
        try? JSONDecoder().decode([PhotoInfo].self, from: data)
    }
    var body: some View {
        NavigationView {
            ZStack {
                if let list = photoLoader.value {
                    List {
                        ForEach(list) { item in
                            ListItemView(title: item.author,

                                         imageLoader: Remote(url: URL(string: item.download_url)!, transform: { data in
                                UIImage(data: data)
                            }))
                        }
                    }
                    .listStyle(.plain)
                    .refreshable {
                        await photoLoader.loadData()
                    }
                } else {
                    ProgressView()
                }
            }
            .navigationTitle("Photos")
        }
    }
}

struct ListItemView: View {
    let title: String
    @StateObject var imageLoader: Remote<UIImage>

    var body: some View {
        NavigationLink(destination: {
            PhotoView(imageLoader: imageLoader)
        },
                       label: {
            ListPhotoView(uiImage: imageLoader.value,

                          title: title)
        }
        )
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
