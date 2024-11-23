//
//  Network.swift
//  NetworkCall
//
//  Created by Vincent on 27/07/2023.
//

import Combine
import Foundation

func fetchMovies() -> some Publisher<MovieResponse, Error> {
    let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)")!
    
    return URLSession
        .shared
        .dataTaskPublisher(for: url)
        .map(\.data)
        .decode(type: MovieResponse.self, decoder: jsonDecoder)
}
