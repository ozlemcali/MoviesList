//
//  ContentView.swift
//  MoviesList
//
//  Created by ozlem on 3.11.2022.
//

import SwiftUI

struct ContentView: View {
   
    @StateObject private var movieListVM = MovieListViewModel()
        @State private var searchText: String = ""
        
        var body: some View {
            NavigationView {
                List(movieListVM.movies, id: \.imdbId) { movie in
                    HStack {
                        AsyncImage(url: movie.poster
                                   , content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 100)
                        }, placeholder: {
                            ProgressView()
                        })
                        Text(movie.title)
                        NavigationLink(destination: DetailView(imdbID: movie.imdbId)) {
                                                
                                            }.buttonStyle(PlainButtonStyle())
                                           }
                   
                    
                }.navigationTitle("Movies")

                    .navigationBarTitleDisplayMode(.inline)
               
            }  .listStyle(.plain)
                    .searchable(text: $searchText)
            
                    .onChange(of: searchText) { value in
                        async {
                            if !value.isEmpty &&  value.count > 3 {
                                    await movieListVM.search(name: value)
                            } else if(value.count < 2) {
                                    EmptyView(error: "Please Search a Movie!")
                                }
                        }
                    }
            }
   
        }
    
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
