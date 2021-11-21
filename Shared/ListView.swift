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
    @StateObject var photoLoader = Remote<[PhotoInfo]>(url: URL(string: "https://picsum.photos/v2/list")!)
    var body: some View {
        NavigationView {
            if let list = photoLoader.object {
                List {
                    ForEach(list) { item in
                        Text(item.author)
                    }
                    .refreshable {
                        await photoLoader.loadData()
                    }
                }
            } else {
                Text ("Loading …")
            }
        }
        .task {
            await self.photoLoader.loadData()
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
