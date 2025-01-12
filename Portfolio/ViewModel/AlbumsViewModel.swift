//
//  AlbumsViewModel.swift
//  Portfolio
//
//  Created by Sergey Zakurakin on 1/12/25.
//

import Foundation


//https://api.flickr.com/services/rest/?method=flickr.people.getPublicPhotos&api_key=30a6e02e23907acde2a36325459ebe9f&user_id=202076311@N05&format=json&nojsoncallback=1

@MainActor
final class AlbumsViewModel: ObservableObject {
    @Published var albums: [Album] = []
    
    func fetchAlbums() async {
        let apiKey = "30a6e02e23907acde2a36325459ebe9f"
        let userId = "202076311@N05"
        let urlString = "https://api.flickr.com/services/rest/?method=flickr.photosets.getList&api_key=\(apiKey)&user_id=\(userId)&format=json&nojsoncallback=1"
        
        guard let url = URL(string: urlString) else {
            return print("Invalid URL")
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("JSON Response: \(jsonString)")
            }
            
            let response = try JSONDecoder().decode(PhotosetsResponse.self, from: data)
            albums = response.photosets.photoset
            
            // После того как альбомы загружены, можно загрузить фотографии для каждого альбома.
            for album in albums {
                await fetchPhotosForAlbum(albumId: album.id)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func fetchPhotosForAlbum(albumId: String) async {
        let apiKey = "30a6e02e23907acde2a36325459ebe9f"
        let urlString = "https://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=\(apiKey)&photoset_id=\(albumId)&format=json&nojsoncallback=1"
        
        guard let url = URL(string: urlString) else {
            return print("Invalid URL")
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let response = try JSONDecoder().decode(PhotosResponse.self, from: data)
            
            // Найти альбом в массиве и добавить фото в его массив
            if let albumIndex = albums.firstIndex(where: { $0.id == albumId }) {
                albums[albumIndex].photosArray = response.photos.photo
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - PhotosetsResponse
struct PhotosetsResponse: Codable {
    let photosets: Photosets
    let stat: String
}

// MARK: - Photosets
struct Photosets: Codable {
    let photoset: [Album]
}

// MARK: - Album
struct Album: Codable, Identifiable {
    let id: String
    let title: Title
    let photos: Int
    var photosArray: [Photo] = [] // Массив фотографий альбома
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case photos = "photos"
    }
}

// MARK: - Title
struct Title: Codable {
    let _content: String
}

// MARK: - Photo
struct Photo: Codable, Identifiable {
    let id: String
    let title: String
    let server: String
    let farm: Int
    let secret: String
    let ispublic: Int
    
    var imageUrl: String {
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg"
    }
}

// MARK: - PhotosResponse
struct PhotosResponse: Codable {
    let photos: Photos
    let stat: String
}

// MARK: - Photos
struct Photos: Codable {
    let photo: [Photo]
}
