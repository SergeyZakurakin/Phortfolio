//
//  ContentView.swift
//  Portfolio
//
//  Created by Sergey Zakurakin on 1/11/25.
//


//Key: 30a6e02e23907acde2a36325459ebe9f
//Secret: 9b162a2a602f5f75
import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = AlbumsViewModel()
    
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
        ScrollView {
                
            VStack() {
                    Text("SERGEY ZAKURAKIN")
                    .foregroundStyle(.black)
                    .fontWeight(.semibold)
                        .font(.title)
                
                Text("PHOTOGRAPHY")
                    .padding(.bottom)
                
                HStack {
                    Text("LIKES")
                        .font(.footnote)
                    
                    Spacer()
                    
                    Image(systemName: "heart.fill")
                    
                    Text("...")
                        .fontWeight(.bold)
                }
                .padding(.horizontal)
                
                ForEach(vm.albums) { album in
                    VStack(alignment: .leading) {
                        Text(album.title._content)
                            .font(.headline)
                            .padding(.bottom, 2)
                        
                        if let firstPhoto = album.photosArray.first {
                            AsyncImage(url: URL(string: firstPhoto.imageUrl)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: 100, height: 100)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 200, height: 200)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                case .failure:
                                    Image(systemName: "photo.fill")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 200, height: 200)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        } else {
                            Text("No photos available")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                    
                }
                .padding()
            }
        }
        .task {
            await vm.fetchAlbums()
        }
    }
}

#Preview {
    ContentView()
}
