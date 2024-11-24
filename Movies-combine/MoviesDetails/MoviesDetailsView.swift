//
//  MoviesDetailsView.swift
//  Movies-combine
//
//  Created by Salah El Sayed on 24/11/2024.
//

import SwiftUI
import Combine

struct MoviesDetailsView: View {
    
    // MARK: - Variables
    @StateObject var viewModel: MovieDetailsViewModel
    
    // MARK: - Initializer
    init(movie: Movie) {
        _viewModel = StateObject(wrappedValue: MovieDetailsViewModel(movie: movie))
    }
    
    // MARK: - Body
    var body: some View {
        List {
            CreditsView(credits: viewModel.data.credits)
            ReviewsView(reviews: viewModel.data.reviews)
        }
        .navigationTitle("Details")
    }
}

#Preview {
    MoviesDetailsView(movie: Movie(id: 580489,
                                   title: "Venom: Let There Be Carnage",
                                   overview: "After finding a host body in investigative reporter Eddie Brock, the alien symbiote must face a new enemy, Carnage, the alter ego of serial killer Cletus Kasady.",
                                   posterPath: "/rjkmN1dniUHVYAtwuV3Tji7FsDO.jpg"))
}

// MARK: - CreditView

struct CreditsView: View {
        
    var credits: [MovieCastMember]
    
    var body: some View {
        Section("Credits") {
            ForEach(credits, id: \.id) { credit in
                VStack(alignment: .leading) {
                    Text(credit.name)
                        .font(.headline)
                    Text("As: \(credit.character)")
                        .font(.title2)
                }
            }
        }
    }
}

// MARK: - ReviewView

struct ReviewsView: View {
    
    var reviews: [MovieReview]
    
    var body: some View {
        Section("Reviews") {
            ForEach(reviews, id: \.id) { review in
                VStack(spacing: 8) {
                    Text(review.author)
                        .font(.headline)
                        .foregroundColor(.red)
                    HStack(alignment: .top) {
                        Text("Writed: ")
                            .bold()
                        Text(review.content)
                            .font(.caption)
                    }
                }
            }
        }
    }
}
