//
//  Constants.swift
//  Movies-combine
//
//  Created by Salah El Sayed on 23/11/2024.
//

import Foundation

let jsonDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}()

let apiKey = "da9bc8815fb0fc31d5ef6b3da097a009"
