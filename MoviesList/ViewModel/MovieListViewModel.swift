//
//  MovieListViewModel.swift
//  MoviesList
//
//  Created by ozlem on 4.11.2022.
//

import Foundation

@MainActor
class MovieListViewModel: ObservableObject {
    
    @Published var movies: [MovieViewModel] = []
    @Published var errorMessage : String = ""
    
    func search(name: String) async {
        do {
            let movies = try await WebService().getMovies(searchTerm: name)
            self.movies = movies.map(MovieViewModel.init)
            
        } catch {
            EmptyView(error: "Movie Not Found!")
            print(error.localizedDescription)
        }
    }
    
}


struct MovieViewModel {
    
    let movie: Movie
    
    var imdbId: String {
        movie.imdbID
    }
    
    var title: String {
        movie.title
    }
    
    var poster: URL? {
        URL(string: movie.poster)
    }
}
