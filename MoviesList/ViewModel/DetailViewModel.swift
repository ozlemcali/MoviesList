//
//  DetailViewModel.swift
//  MoviesList
//
//  Created by ozlem on 3.11.2022.
//

import Foundation
import Combine

class DetailViewModel:ObservableObject {
    
   
    @Published var filmDetails:MovieViewModel?
    @Published var movies = [MovieDetail]()
    
    func getMovieDetail(imdbID:String) {
        let url = URL(string: "\(APIService.baseUrl)?i=\(imdbID)&apikey=\(APIService.apiKey)")
        WebService().requestUrl(url: url,expecting: MovieDetail.self)
        { Result in
            switch Result {
            case.success(let data):
                DispatchQueue.main.async{
                    self.filmDetails = MovieViewModel(movie: data)
                    
                }
            case.failure(let error):
                print("error \(error)")
            }
        }
        
    }
    
    
    struct MovieViewModel {
        
        let movie: MovieDetail
        
        var imdbId: String {
            movie.imdbID
        }
        
        var title: String {
            movie.title
        }
        
        var poster: URL? {
            URL(string: movie.poster)
        }
        
        var released:String {
            movie.released
        }
        
        var director:String {
            movie.director
        }
        
        var plot:String {
            movie.plot
        }
        
    }
    
    
}
