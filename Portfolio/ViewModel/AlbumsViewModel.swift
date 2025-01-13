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
final class PhotosViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    
    func fetchAlbums() async {
        let accessKey = "Vqc2aHuXb3GZ0zcTx_nSEAVdiPkPD9lFoUBkMXoLunU"
        let username = "xzakx"
        let urlString = "https://api.unsplash.com/users/\(username)/photos?client_id=\(accessKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode([Photo].self, from: data)
            photos = response
        } catch {
            print("Error: \(error)")
        }
    }
}
