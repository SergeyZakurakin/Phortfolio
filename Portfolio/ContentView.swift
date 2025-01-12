//
//  ContentView.swift
//  Portfolio
//
//  Created by Sergey Zakurakin on 1/11/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
        ScrollView {
                
            VStack(alignment: .leading) {
                    Text("SERGEY ZAKURAKIN")
                    .foregroundStyle(.black)
                        .font(.title)
                Text("PHOTOGRAPHY")
                    .padding(.bottom)
                
                HStack {
                    Text("LIKES")
                    
                    Spacer()
                    
                    Image(systemName: "heart.fill")
                    
                }
                .padding(.horizontal)
                
                    Image(.photo)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 400)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
//                        .padding(.top)
                        
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
