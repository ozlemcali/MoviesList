//
//  WebService.swift
//  MoviesList
//
//  Created by ozlem on 3.11.2022.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badID
}

enum CustomError:Error {
    case invalidUrl
    case invalidData
}


class WebService {
   
    func requestUrl<T: Codable>(
    url:URL?,
    expecting:T.Type,
    completion: @escaping(Result<T,Error>) -> Void)    {
     
        guard let url = url else{
            completion(.failure(CustomError.invalidUrl))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { Data, _, Error in
            guard let data = Data else{
                if let Error = Error {
                    completion(.failure(Error))
                } else{
                    completion(.failure(CustomError.invalidUrl))
                }
                return
            }
            do{
                let results = try JSONDecoder().decode(expecting, from: data)
                completion(.success(results))
            }
            catch{
                completion(.failure(CustomError.invalidData))
            }
        }
        task.resume()
    }
    
    
    
    func getMovies(searchTerm: String) async throws -> [Movie] {
           
           var components = URLComponents()
           components.scheme = "http"
           components.host = "omdbapi.com"
           components.queryItems = [
               URLQueryItem(name: "s", value: searchTerm.trimmed()),
               URLQueryItem(name: "apikey", value: "fc3c8304")
           ]
        
           
           guard let url = components.url else {
               throw NetworkError.badURL
           }
           
           let (data, response) = try await URLSession.shared.data(from: url)
           
           guard (response as? HTTPURLResponse)?.statusCode == 200 else {
               throw NetworkError.badID
           }
           
           let movieResponse = try? JSONDecoder().decode(MovieResponse.self, from: data)
           return movieResponse?.movies ?? []
           
       }
       
    
    
    
}


extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
