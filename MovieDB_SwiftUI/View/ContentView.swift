//
//  ContentView.swift
//  MovieDB_SwiftUI
//
//  Created by Matheus Lima Ferreira on 3/31/20.
//  Copyright © 2020 Matheus Lima Ferreira. All rights reserved.
//

import SwiftUI

struct MovieListView: View {
    //    let movies = ["Matheus", "Luisa", "Ronald", "Nico", "JOao", "Dani", "÷
    @State private var searchText : String = ""
    
    @State var popularMovies: [Movie] = []
    @State var nowPlayingMovies: [Movie] = []
    
    @State var image: UIImage = UIImage()
    
    var body: some View {
        NavigationView{
            
            VStack{
                SearchBar(text: $searchText, placeholder: "Search for a movie")
                list
                .navigationBarTitle("Movies")
            }
            
        }.onAppear{
            print("view appeared")
        
            NetworkService.sharedInstance.fetchMovies(with: .POPULAR, completion: { result in
                switch result {
                case .success(let movies):
                    DispatchQueue.main.async {
                        self.popularMovies = movies
                        print(self.popularMovies.count)
                    }
                case .failure(_):
                    print("fail to show movies in the view∫")
                }
        
            });
        }
    }
    
    var list: some View {
        List {
            ForEach(popularMovies, id: \.self) { movie in
//                MovieCell(title: movie.title, overview: movie.overview, vote_average: movie.vote_average.cleanValue, poster_path: movie.poster_path)
                NavigationLink(destination: MovieDetailView(title: movie.title)) {
                    MovieCell(title: movie.title, overview: movie.overview, vote_average: movie.vote_average.cleanValue, poster_path: movie.poster_path)
                }
            }
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}

extension Double{
    var cleanValue: String{
        return String(format: 1 == floor(self) ? "%.0f" : "%.1f", self)
    }
}
