//  Endpoints.swift
//  Sykora's Recipe Fetch

import Foundation

class Endpoints {
    enum Recipe {
        // in reality, I'd probably have some custom Endpoint struct to handle the url components for different servers
        static let fetch = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")! // TODO: implement above
        static let malformed = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")!
        static let empty = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")!
    }
}
