//
//  Remote.swift
//  PhotoLoader
//
//  Created by Alexander v. Below on 17.11.21.
//

import Foundation
import Combine

class Remote<T>: ObservableObject {
    let url: URL
    let transform: (Data) -> T?
    var subscriptionAlert: AnyCancellable?

    @Published private(set) var value: T?
    init(url: URL, transform: @escaping (Data) -> T?) {
        self.url = url
        self.transform = transform
        subscriptionAlert = self.objectWillChange.handleEvents(receiveSubscription:  { s in
            Task() {
                await self.loadData()
            }
        })
            .sink { _ in return }
    }

    @MainActor
    func loadData() async {
        let name = url.path
        do {
            debugPrint("Loading \(name)")
            let (data, _) = try await URLSession.shared.data(from: url)
            debugPrint("-> Finished \(name)")
            let object = transform(data)
            self.value = object
        } catch {
            debugPrint("Error \(error)")
        }
    }
}
