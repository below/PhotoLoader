//
//  Remote.swift
//  PhotoLoader
//
//  Created by Alexander v. Below on 17.11.21.
//

import Foundation

class Remote<T>: ObservableObject {
    let url: URL
    let transform: (Data) -> T?
    @Published private(set) var value: T?
    init(url: URL, transform: @escaping (Data) -> T?) {
        self.url = url
        self.transform = transform
    }

    @MainActor
    func loadData() async {
        if value != nil {
            return
        }
        do {
            let name = url.lastPathComponent
            debugPrint("Loading \(name)")
            let (data, _) = try await URLSession.shared.data(from: url)
            let object = transform(data)
            self.value = object
        } catch {
            debugPrint("Error \(error)")
        }
    }
}
