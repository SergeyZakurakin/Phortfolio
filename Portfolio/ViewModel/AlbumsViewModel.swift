//
//  AlbumsViewModel.swift
//  Portfolio
//
//  Created by Sergey Zakurakin on 1/12/25.
//

import Foundation



//aplication ID: 696190
//Access Key: Vqc2aHuXb3GZ0zcTx_nSEAVdiPkPD9lFoUBkMXoLunU
//Secret key: Gab7b2Av1ELIczeve677CLBppxyq8jMjTSsYfDC4D1k

@MainActor
final class CollectionsViewModel: ObservableObject {
    @Published var collections: [Collection] = []
    @Published var photos: [Photo] = []
    
    private let accessKey = "Vqc2aHuXb3GZ0zcTx_nSEAVdiPkPD9lFoUBkMXoLunU"
    
    func fetchCollections() async {
        
        let username = "xzakx" // Замените на ваше имя пользователя
        let collectionsURL = "https://api.unsplash.com/users/\(username)/collections?client_id=\(accessKey)"
        
        guard let url = URL(string: collectionsURL) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let fetchedCollections = try JSONDecoder().decode([Collection].self, from: data)
            
            collections = fetchedCollections
        } catch {
            print("Error: \(error)")
        }
    }
    
    func fetchPhotos(from collection: Collection) async {
        guard let url = URL(string: collection.links.photos + "?client_id=\(accessKey)") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let fetchPhotos = try JSONDecoder().decode([Photo].self, from: data)
            photos = fetchPhotos
        } catch {
            print("Error: \(error)")
        }
    }
}

struct Collection: Codable {
    let id: String
    let title: String
    let coverPhoto: Photo
    let links: CollectionLinks
    let totalPhotos: Int

    enum CodingKeys: String, CodingKey {
        case id, title
        case coverPhoto = "cover_photo"
        case links
        case totalPhotos = "total_photos"
    }
}

struct Photo: Codable {
    let id: String
    let urls: Urls
}

struct Urls: Codable {
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

struct CollectionLinks: Codable {
    let photos: String

    enum CodingKeys: String, CodingKey {
        case photos
    }
}
