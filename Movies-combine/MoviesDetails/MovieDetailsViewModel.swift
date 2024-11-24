//
//  MovieDetailsViewModel.swift
//  Movies-combine
//
//  Created by Salah El Sayed on 24/11/2024.
//

import Foundation
import Combine

class MovieDetailsViewModel: ObservableObject {
    
    var movie: Movie
    @Published var data: (reviews: [MovieReview], credits: [MovieCastMember]) = ([], [])
    @Published var anyCancellables = Set<AnyCancellable>()
    
    init(movie: Movie) {
        self.movie = movie
        fetchData()
    }
    
    func fetchData() {
        let fetchReviews = NetworkManager.fetchReviews(for: movie)
        let fetchCredits = NetworkManager.fetchCredits(for: movie)
        
        Publishers.Zip(fetchReviews, fetchCredits)
            .receive(on: DispatchQueue.main)
            .map { (reviews: $0.0.results, credits: $0.1.cast) }
            .sink { result in
                switch result {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] data in
                self?.data = data
            }
            .store(in: &anyCancellables)
    }
}
