//
//  Beer.swift
//  BeerCollection
//
//  Created by Ilnur on 10.05.2023.
//

import Foundation

struct Beer: Decodable {
    let name: String
    let tagline: String
    let description: String
    let image_url: URL
    let abv: Double
}
