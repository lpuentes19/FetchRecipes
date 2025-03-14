//
//  EmptyListView.swift
//  FetchRecipes
//
//  Created by Luis Puentes on 3/14/25.
//

import SwiftUI

struct EmptyListView: View {
    var body: some View {
        Text("No recipes found. Please try again later.")
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .padding(.horizontal, 24)
            .font(.headline)
            .background(Color.gray.opacity(0.2))
    }
}

#Preview {
    EmptyListView()
}
