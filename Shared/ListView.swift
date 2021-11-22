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
                            NavigationLink(destination: {
                                PhotoView(imageLoader: Remote(url:URL(string: item.download_url)!) { data in
                                    UIImage(data: data)
                                })
                            },
                                           label: { Text(item.author) }
                            )
                        }
                    }
                    .listStyle(.plain)
                    .refreshable {
                        await photoLoader.loadData()
                    }
                } else {
                    Text ("Loading …")
                }
            }
            .navigationTitle("Photos")
            .task {
                await self.photoLoader.loadData()
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
