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
    @Published var photos: [Photo] = []
    
    func fetchCollections() async {
        let accessKey = "Vqc2aHuXb3GZ0zcTx_nSEAVdiPkPD9lFoUBkMXoLunU"
        let username = "xzakx" // Замените на ваше имя пользователя
        let collectionsURL = "https://api.unsplash.com/users/\(username)/collections?client_id=\(accessKey)"
        
        guard let url = URL(string: collectionsURL) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let collections = try JSONDecoder().decode([Collection].self, from: data)
            
            for collection in collections {
                if let firstPhoto = await fetchFirstPhoto(from: collection.id, accessKey: accessKey) {
                    photos.append(firstPhoto)
                }
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func fetchFirstPhoto(from collectionID: String, accessKey: String) async -> Photo? {
        let photosURL = "https://api.unsplash.com/collections/\(collectionID)/photos?client_id=\(accessKey)&per_page=1"
        
        guard let url = URL(string: photosURL) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let photos = try JSONDecoder().decode([Photo].self, from: data)
            return photos.first
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
}

struct Collection: Codable {
    let id: String
    let title: String
}

struct Photo: Codable {
    let id: String
    let urls: Urls
    
}

struct Urls: Codable {
    let full: String
}
