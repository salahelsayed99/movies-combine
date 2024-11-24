//
//  ContentView.swift
//  Movies-combine
//
//  Created by Salah El Sayed on 23/11/2024.
//

import SwiftUI

// MARK: - Moview View

struct MoviesView: View {
    
    // MARK: - Variables
    @StateObject var moviesViewModel = MoviesViewModel()
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 6, alignment: .top),
        GridItem(.flexible(), spacing: 6, alignment: .top),
    ]
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, content: {
                    ForEach(moviesViewModel.movies) { movie in
                        NavigationLink {
                            MoviesDetailsView(movie: movie)
                        } label: {
                            MovieCell(movie: movie)
                        }
                    }
                })
            }
            .navigationTitle("Movies")
        }
        .searchable(text: $moviesViewModel.searchQuery)
    }
}

#Preview {
    MoviesView()
}

// MARK: - moview cell

struct MovieCell: View {
    
    // MARK: - Variables
    var movie: Movie
    
    // MARK: - Body
    var body: some View {
        VStack(content: {
            AsyncImage(url: movie.posterURL) { poster in
                poster
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } placeholder: {
                ProgressView()
                    .frame(width: 100)
            }
            
            Text(movie.title)
                .font(.title)
            Text(movie.overview)
                .font(.caption2)
                .lineLimit(3)
        })
        .padding(.all, 16)
    }
}
