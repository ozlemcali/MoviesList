//
//  HomeView.swift
//  MoviesList
//
//  Created by ozlem on 3.11.2022.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var vm = ContentViewModel()
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical,showsIndicators: false) {
                ForEach(vm.movies) { item in
                    NavigationLink(destination: DetailView(imdbID: item.imdbID)) {
                        ListView(data: item)
                    }.buttonStyle(PlainButtonStyle())
                }
                
                vm.loadData(searchText: searchText)
                /*
                if vm.searchString.isEmpty   {
                    EmptyView(error: "Please Search a Movie") }
                else if vm.errorMessage != "" {
                    Text(vm.errorMessage) }
                 */
            }
            
            .navigationTitle("Movies")
            .navigationBarTitleDisplayMode(.inline)
        }.searchable(text: $vm.searchString,placement:.navigationBarDrawer(displayMode:.always)).disableAutocorrection(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
