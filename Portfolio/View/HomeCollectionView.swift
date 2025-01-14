//
//  HomeCollectionView.swift
//  Portfolio
//
//  Created by Sergey Zakurakin on 1/13/25.
//

import SwiftUI

struct HomeCollectionView: View {
    let collection: Collection
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(collection.title)
                    .font(.headline)
                    .padding(.leading)
                    .padding(.top, 5)
                
                Spacer()
                
                Text("\(collection.totalPhotos)")
            }
            .foregroundStyle(.black)
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
