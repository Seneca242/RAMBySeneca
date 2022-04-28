//
//  R&MModel.swift
//  RAMBySeneca
//
//  Created by Дмитрий Дмитрий on 27.04.2022.
//

struct RickAndMorty: Decodable {
    let info: Info?
    let results: [Characters]?
}

struct Info: Decodable {
    let pages: Int?
    let next: String?
    let prev: String?
}

struct Characters: Decodable {
    let name: String?
    let status: String?
    let species: String?
    let gender: String?
    let origin: Location?
    let location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
}

struct Location: Decodable {
    let name: String?
    let url: String?
}

struct Episode: Decodable {
    let name: String?
    let date: String?
    let episode: String?
    let characters: [String]?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case date = "air_date"
        case episode = "episode"
        case characters = "characters"
    }
    
    var description: String {
        """
        Title: \(episode ?? "")
        Date: \(date ?? "")
        """
    }
}

enum URLS: String {
    case rickAndMortyAPI = "https://rickandmortyapi.com/api/character"
}
