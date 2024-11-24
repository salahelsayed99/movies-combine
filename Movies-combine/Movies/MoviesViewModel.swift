//
//  MoviesViewModel.swift
//  Movies-combine
//
//  Created by Salah El Sayed on 23/11/2024.
//

import Foundation
import Combine

class MoviesViewModel: ObservableObject {
    
    // MARK: - Variables
    @Published private var allMovies: [Movie] = []
    @Published private var searchResults: [Movie] = []
    
    @Published var searchQuery: String = ""
    var anyCancellables = Set<AnyCancellable>()
    
    var movies: [Movie] {
        if searchQuery.isEmpty {
            return allMovies
        } else {
            return searchResults
        }
    }
    
    // MARK: - Initializer
    init() {
        fetchData()
        setupSearchEngine()
    }
    
    // MARK: - API
    private func fetchData() {
        NetworkManager.fetchMovies()
            .map(\.results)
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .finished: print("finished")
                case .failure(let error):
                    print("Error; \(error)")
                }
            } receiveValue: { [weak self] items in
                self?.allMovies = items
            }
            .store(in: &anyCancellables)
    }
    
    private func setupSearchEngine() {
        // Listen to search text changes
        $searchQuery
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main) // Wait for the user to stop typing
            .removeDuplicates() // Prevent duplicate queries
            .map { query in
                NetworkManager.searchMovies(for: query) // Create a new publisher for the query
            }
            .switchToLatest() // Cancel previous requests if a new query is made
            .replaceError(with: MovieResponse(results: [])) // Handle errors gracefully
            .map(\.results) // Extract the results array
            .receive(on: DispatchQueue.main) // Update the UI on the main thread
            .sink { result in
                switch result {
                case .finished: print("finished")
                case .failure(let error):
                    print("Error; \(error)")
                }
            } receiveValue: { [weak self] items in
                self?.searchResults = items
            }
            .store(in: &anyCancellables)
    }
}
