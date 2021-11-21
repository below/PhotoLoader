//
//  Remote.swift
//  PhotoLoader
//
//  Created by Alexander v. Below on 17.11.21.
//

import Foundation

@MainActor
class Remote<T: Codable>: ObservableObject {
    let url: URL
    @Published private(set) var object: T?
    init(url: URL) {
        self.url = url
    }

    func decode(data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }

    func loadData() async {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let object = try decode(data: data)
            self.object = object
        } catch {
            debugPrint("Error \(error)")
        }
    }
}
