//
//  NetworkManager.swift
//  Navigation
//
//  Created by Юлия Кагирова on 25.03.2024.
//

import UIKit

enum AppConfiguration {
    case people
    case planets
    case films
}

struct NetworkManager {
    
    static func request(for configuration: AppConfiguration) {
        
        switch configuration {
        case .people:
            if let url = URL(string: "https://swapi.dev/api/people/") {
                let request = URLRequest(url: url)
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
            }
        case .planets:
            if let url = URL(string: "https://swapi.dev/api/planets/") {
                let request = URLRequest(url: url)
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
            }
        case .films:
            if let url = URL(string: "https://swapi.dev/api/films/") {
                let request = URLRequest(url: url)
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
            }
        }
    }
}








