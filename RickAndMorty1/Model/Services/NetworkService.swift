//
//  NetworkService.swift
//  RickAndMorty
//
//  Created by Alex Aytov on 18.08.2023.
//

import Foundation


enum NetworkHandlerError: Error {
    case InvalidURL
    case JSONDecodingError
    case RequestError(String)
    case UnknownError
}

public struct NetworkService {
    var baseURL: String = "https://rickandmortyapi.com/api/"
    
    // сервис API запроса
    func getSearchResults<TypeForDecode: Codable>(_ decodeType: TypeForDecode.Type, searchExpression: String?, completion: @escaping (Result<TypeForDecode, Error>) -> Void) {
        
        guard let url = URL(string: baseURL + (searchExpression ?? "")) else {
            completion(.failure(NetworkHandlerError.InvalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data, let decodeResult: TypeForDecode = self.decodeJSONData(data: data) else {
                completion(.failure(NetworkHandlerError.JSONDecodingError))
                return
            }
            
            completion(.success(decodeResult))
        }
        
        print("Запрос с параметром - \(searchExpression ?? "")")
        task.resume()
    }
    
    // сервис декодирования JSON в network model
    private func decodeJSONData<T: Codable>(data: Data) -> T? {
        do {
            let decode = try JSONDecoder().decode(T.self, from: data)
            return decode
        } catch {
            print("Ошибка декодирования - \(error.localizedDescription)")
            return nil
        }
    }
    
    // сервис загрузки картинки по url
    func loadImageAsync(urlString: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        DispatchQueue.global(qos: .userInitiated).async {
            guard let contentOfURL = try? Data(contentsOf: url) else {
                completion(nil)
                return
            }
            completion(contentOfURL)
        }
    }
}
