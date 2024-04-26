//
//  NetworkClient.swift
//  Navigation
//
//  Created by Юлия Кагирова on 23.04.2024.
//

import Foundation

protocol INetworkClient {
    func request(with urlRequest: URLRequest, completion: @escaping(Result<Data, NetworkError>) -> Void)
}

final class NetworkClient: INetworkClient {
    func request(with urlRequest: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                DispatchQueue.main.async {
                    completion(.failure(.custom(description: error.localizedDescription)))
                }
            }
            guard let data else {
                DispatchQueue.main.async {
                    completion(.failure(.server))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }.resume()
    }
    
    
}
