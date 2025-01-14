//
//  ContentView.swift
//  Portfolio
//
//  Created by Sergey Zakurakin on 1/11/25.
//


//Key: 30a6e02e23907acde2a36325459ebe9f
//Secret: 9b162a2a602f5f75
import SwiftUI

struct HomeView: View {
    @StateObject var vm = CollectionsViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray.ignoresSafeArea()
                ScrollView {
                    VStack {
                        
                        Text("PHOTOGRAPHY")
                            .padding(.bottom)
                        
                        // Показываем каждое фото из коллекций
                        ForEach(vm.collections, id: \.id) { collection in
                            NavigationLink {
                                Text("New screen")
                                
//                                AsyncImage(url: collection) { image in
//                                    image.image
//                                }
                            } label: {
                                HomeCollectionView(collection: collection)
                                
                            }
                        }
                    }
                }
            }
            .task {
                await vm.fetchCollections()
            }
            .navigationTitle("Sergey Zakurakin")
        }
    }
}
#Preview {
    HomeView()
}


//struct PhotosView: View {
//    let collection: Collection
//    @State private var photos: [Photo] = []
//    @StateObject private var vm = CollectionsViewModel()
//    
//    var body: some View {
//        ScrollView {
//            VStack {
//                ForEach(photos, id: \.id) { photo in
//                    if let url = URL(string: photo.urls.regular) {
//                        AsyncImage(url: url) { image in
//                            image.resizable()
//                                .scaledToFit()
//                        } placeholder: {
//                            ProgressView()
//                        }
//                        .frame(height: 200)
//                        .clipShape(RoundedRectangle(cornerRadius: 15))
//                        .padding()
//                    }
//                }
//            }
//            .task {
//                photos = await vm.fetchPhotos(from: "\(collection.id)")
//            }
//        }
//        .navigationTitle(collection.title)
//    }
//}
