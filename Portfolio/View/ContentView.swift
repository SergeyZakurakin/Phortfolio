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
    @StateObject var vm = PhotosViewModel()
    
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            
            VStack {
                Text("SERGEY ZAKURAKIN")
                    .foregroundStyle(.black)
                    .fontWeight(.semibold)
                    .font(.title)
                
                Text("PHOTOGRAPHY")
                    .padding(.bottom)
                
                Spacer()
            }
            
            ScrollView {
                VStack {
                    HStack {
                        Text("LIKES")
                            .font(.footnote)
                        Spacer()
                        Image(systemName: "heart.fill")
                        Text("...")
                            .fontWeight(.bold)
                        
                    }
                    .padding(.horizontal)
                    
                    ForEach(vm.photos, id: \.id) { photo in
                        VStack(spacing: 30) {
                            if let urlString = photo.urls?.full, let url = URL(string: urlString) {
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image.resizable().scaledToFill().frame(height: 250).clipShape(RoundedRectangle(cornerRadius: 15))
                                    case .failure:
                                        Image(systemName: "photo.fill").frame(height: 200).clipShape(RoundedRectangle(cornerRadius: 15))
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.top, 60)
                    .task {
                        await vm.fetchAlbums()
                    }
                }
            }
        }
    }
    
    #Preview {
        ContentView()
    }
