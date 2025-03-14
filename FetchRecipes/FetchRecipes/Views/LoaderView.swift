//
//  LoaderView.swift
//  FetchRecipes
//
//  Created by Luis Puentes on 3/14/25.
//

import SwiftUI

struct LoaderView: View {
    @Binding var isLoading: Bool
    
    var body: some View {
        // To show and hide the progress view with animations
        let opacity: Double = isLoading ? 1 : 0
        
        ZStack {
            Color.black
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .opacity(0.5)
            
            ProgressView("Loading...")
                .foregroundColor(.white)
                .tint(.white)
        }
        .ignoresSafeArea()
        .opacity(opacity)
        .animation(.spring, value: opacity)
    }
}

#Preview {
    LoaderView(isLoading: .constant(true))
}
