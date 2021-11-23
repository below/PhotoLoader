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
            .task {
                await self.photoLoader.loadData()
            }
        }
    }
}

class ListItem: Identifiable, ObservableObject {
    let item: PhotoInfo
    var imageLoader: Remote<UIImage>
    var id: String { self.item.id }

    init(item: PhotoInfo) {
        self.item = item
        self.imageLoader = Remote(url: URL(string:item.download_url)!) { data in
            UIImage(data: data)
        }
    }
}

struct ListItemView: View {
    let title: String
    @ObservedObject var imageLoader: Remote<UIImage>

    var body: some View {
        NavigationLink(destination: {
            PhotoView(imageLoader: imageLoader)
        },
                       label: {
            ListPhotoView(uiImage: imageLoader.value,

                          title: title)
        }
        )
            .task {
                await self.imageLoader.loadData()
            }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
