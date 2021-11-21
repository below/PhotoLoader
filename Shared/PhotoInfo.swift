//
//  PhotoInfo.swift
//  PhotoLoader
//
//  Created by Alexander v. Below on 17.11.21.
//

import Foundation

struct PhotoInfo {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let download_url: String
}

extension PhotoInfo: Codable {}

extension PhotoInfo: Identifiable {}
