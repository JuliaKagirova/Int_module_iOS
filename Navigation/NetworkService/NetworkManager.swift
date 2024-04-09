//
//  NetworkManager.swift
//  Navigation
//
//  Created by Юлия Кагирова on 25.03.2024.
//

import UIKit

enum AppConfiguration: String, CaseIterable {
    case people = "https://swapi.dev/api/people/"
    case planets = "https://swapi.dev/api/planets/"
    case films = "https://swapi.dev/api/films/"
}

struct NetworkManager {
    static func request(_ url: AppConfiguration) {
        var request: URLRequest?
        
        switch url {
        case .people:
            break
        case .planets:
            break
        case .films:
            let url = URL(string: url.rawValue)!
            request = URLRequest(url: url)
        }
        guard let request else {
            return
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                print("DataTask error:" + error.localizedDescription)
                return
            }
            guard let response = response as? HTTPURLResponse,
                  Array(200...300).contains(response.statusCode)
            else { return }
            guard let data else { return }
            print(String(bytes: data, encoding: .utf8))
            print(response.statusCode, response.allHeaderFields)

        }
        task.resume()
     }
}
