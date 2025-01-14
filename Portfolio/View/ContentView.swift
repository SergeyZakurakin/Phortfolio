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
                    ForEach(vm.photos, id: \.id) { photo in
                        VStack {
                            if !photo.urls.full.isEmpty, let url = URL(string: photo.urls.full) {
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView() // Пока изображение загружается
                                    case .success(let image):
                                        image.resizable()
                                            .scaledToFill()
                                            .frame(height: 200)
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                    case .failure:
                                        Image(systemName: "photo.fill") // В случае ошибки
                                            .frame(height: 200)
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .padding()
                            }
                        }
                        
                        Text("Array Gallery")
                    }
                    
                }
                .padding()
            }
        }
        .task {
            await vm.fetchCollections() // Загружаем коллекции при загрузке вью
        }
    }
}

#Preview {
    ContentView()
}
