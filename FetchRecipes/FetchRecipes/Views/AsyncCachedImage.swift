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
                            image = await downloadPhoto(url: url)
                        }
                    }
            }
        }
    }
    
    private func downloadPhoto(url: URL?) async -> UIImage? {
        guard let url = url else {
            return nil
        }
        
        do {
            if let cachedResponse = URLCache.shared.cachedResponse(for: .init(url: url)) {
                return UIImage(data: cachedResponse.data)
            } else {
                let (data, response) = try await URLSession.shared.data(from: url)
                URLCache.shared.storeCachedResponse(.init(response: response, data: data), for: .init(url: url))
                guard let image = UIImage(data: data) else {
                    return nil
                }
                
                return image
            }
        } catch {
            return nil
        }
    }
}
