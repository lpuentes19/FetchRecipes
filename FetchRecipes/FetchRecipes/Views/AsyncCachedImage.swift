//
//  AsyncCachedImage.swift
//  FetchRecipes
//
//  Created by Luis Puentes on 3/14/25.
//

import SwiftUI

@MainActor
struct AsyncCachedImage<ImageView: View, PlaceholderView: View>: View {
    var url: URL?
    @ViewBuilder var content: (Image) -> ImageView
    @ViewBuilder var placeholder: () -> PlaceholderView
    
    @State var image: UIImage? = nil
    
    init(url: URL?, content: @escaping (Image) -> ImageView, placeholder: @escaping () -> PlaceholderView) {
        self.url = url
        self.content = content
        self.placeholder = placeholder
    }
    
    var body: some View {
        VStack {
            if let uiImage = image {
                content(Image(uiImage: uiImage))
            } else {
                placeholder()
                    .onAppear {
                        Task {
                            image = await NetworkManager.shared.downloadPhoto(url: url)
                        }
                    }
            }
        }
    }
}
