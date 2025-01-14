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
        ZStack {
            Color.gray.ignoresSafeArea()
            ScrollView {
                VStack {
                    Text("SERGEY ZAKURAKIN")
                        .foregroundStyle(.black)
                        .fontWeight(.semibold)
                        .font(.title)
                    
                    Text("PHOTOGRAPHY")
                        .padding(.bottom)
                    
                    // Показываем каждое фото из коллекций
                    ForEach(vm.collections, id: \.id) { collection in
                        VStack(alignment: .leading) {
                            HStack {
                                Text(collection.title)
                                    .font(.headline)
                                    .padding(.leading)
                                    .padding(.top, 5)
                                
                                Spacer()
                                
                                Text("\(collection.totalPhotos)")
                            }
                            .padding(.horizontal)
                           
                            if let coverPhotoURL = URL(string: collection.coverPhoto.urls.thumb) {
                                
                                AsyncImage(url: coverPhotoURL) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 200)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                } placeholder: {
                                    ProgressView()
                                }
                                
                                .padding(.bottom, 10)
                            }
                        }
                    }
                }
                
            }
        }
        .task {
            await vm.fetchCollections()
        }
    }
}
#Preview {
    HomeView()
}
