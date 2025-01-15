//
//  PhotosView.swift
//  Portfolio
//
//  Created by Sergey Zakurakin on 1/14/25.
//

import SwiftUI

struct PhotosView: View {
    let collection: Collection
    @StateObject private var vm = CollectionsViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(vm.photos, id: \.id) { photo in
                    if let url = URL(string: photo.urls.regular) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .aspectRatio(contentMode: .fill)
//                                .frame(height: 400)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
                .frame(height: 200)
                .frame(maxWidth: .infinity)
            }
            .task {
                await vm.fetchPhotos(from: collection)
            }
        }
        .navigationTitle(collection.title)
    }
}


//#Preview {
//    PhotosView(collection: Collection(id: "1", title: "Test Collection", coverPhoto: Photo(id: "1", urls: Urls(full: "", regular: "", small: "", thumb: "")), links: CollectionLinks(photos: "https://example.com"), totalPhotos: 10))
//}
