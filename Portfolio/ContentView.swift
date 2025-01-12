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
                
                    Image(.photo)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 400)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
//                        .padding(.top)
                
                Text("Portrait")
                    .font(.largeTitle)
                    
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
