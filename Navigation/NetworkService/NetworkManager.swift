//
//  NetworkManager.swift
//  Navigation
//
//  Created by Юлия Кагирова on 25.03.2024.
//

import UIKit

enum AppConfiguration: String, CaseIterable {
    case people = "https://swapi.dev/api/people/"
    case planets =  "https://swapi.dev/api/planets/"
    case films = "https://swapi.dev/api/films/"
    
    var url: URL? {
        URL(string: self.rawValue)
    }
}

struct NetworkManager {
    
    static func request(_ url: URL) {
        switch url {
        case AppConfiguration.people.url:
            let url = AppConfiguration.people.url
            let request = URLRequest(url: url!)
            NetworkManager.request(url!)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error {
                    print(error.localizedDescription)
                    return
                }
                guard let response = response as? HTTPURLResponse,
                      Array(200...300).contains(response.statusCode)
                else {
                    print("response.statusCode")
                    return
                }
                guard let data else { return }
                print(String(bytes: data, encoding: .utf8)!)
            }
            task.resume()
        case AppConfiguration.planets.url:
            let url = AppConfiguration.planets.url
            let request = URLRequest(url: url!)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error {
                    print(error.localizedDescription)
                    return
                }
                guard let response = response as? HTTPURLResponse,
                      Array(200...300).contains(response.statusCode)
                else {
                    print("response.statusCode")
                    return
                }
                guard let data else { return }
                print(String(bytes: data, encoding: .utf8)!)
            }
            task.resume()
            NetworkManager.request(url!)
        case AppConfiguration.films.url:
            let url = AppConfiguration.films.url
            let request = URLRequest(url: url!)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error {
                    print(error.localizedDescription)
                    return
                }
                guard let response = response as? HTTPURLResponse,
                      Array(200...300).contains(response.statusCode)
                else {
                    print("response.statusCode")
                    return
                }
                guard let data else { return }
                print(String(bytes: data, encoding: .utf8)!)
            }
            task.resume()
            NetworkManager.request(url!)
        default:
            break
        }
    }
}
