//
//  OpenSeaServiceProtocol.swift
//  MyNFTs
//
//  Created by Aymen Aifa on 25.06.22.
//

import Foundation

protocol OpenSeaServiceProtocol {
    func getAssets(_ wallet: String, _ cursor: String?, completion: @escaping (_ result: Result<OpenseaAssets, OpenSeaError>) -> ())
    func getCollection(_ collectionSlug: String, completion: @escaping (_ result: Result<OpenseaCollection, OpenSeaError>) -> ())
}

class OpenSeaService: OpenSeaServiceProtocol {
    
    func getAssets(_ wallet: String, _ cursor: String?, completion: @escaping (Result<OpenseaAssets, OpenSeaError>) -> ()) {
        guard let url = URL(string: "https://api.opensea.io/api/v1/assets?owner=\(wallet)&limit=50&cursor=\(cursor ?? "")") else { completion(.failure(.unknown)); return }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("7c52a7933c7d4fcfb9e4df55a92f7b54", forHTTPHeaderField: "X-API-KEY")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.failure(.error)); return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(OpenseaAssets.self, from: data)
                
                completion(.success(result))
            } catch {
                if let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 400 {
                    
                    completion(.failure(.unknown))
                } else {
                    
                    completion(.failure(.error))
                }
            }
        }.resume()
    }
    
    func getCollection(_ collectionSlug: String, completion: @escaping (Result<OpenseaCollection, OpenSeaError>) -> ()) {
        guard let url = URL(string: "https://api.opensea.io/api/v1/collection/\(collectionSlug)") else { return }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("7c52a7933c7d4fcfb9e4df55a92f7b54", forHTTPHeaderField: "X-API-KEY")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { completion(.failure(.error)); return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(OpenseaCollection.self, from: data)
                
                completion(.success(result))
            } catch {
                
                completion(.failure(.error))
            }
        }.resume()
    }
}
