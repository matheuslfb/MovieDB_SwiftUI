//
//  ContentView.swift
//  MovieDB_SwiftUI
//
//  Created by Matheus Lima Ferreira on 3/31/20.
//  Copyright © 2020 Matheus Lima Ferreira. All rights reserved.
//

import SwiftUI


class MoviesObject: ObservableObject {
    @Published var popularMovies: [Movie] = []
    @Published var nowPlayingMovies: [Movie] = []
}


struct MovieListView: View {
    
    @State var searchText : String = ""
    
    @State var image: UIImage = UIImage()
    
    @EnvironmentObject var moviesObject: MoviesObject
    @State var showingAllPopularMovies = false
    
    var body: some View {
        
        NavigationView{
            
            VStack {
                Group {
                    SearchBar(text: $searchText, placeholder: "Search for a movie")
                }
                VStack {
                    list
                }
            }
            .navigationBarTitle("Movies", displayMode: .large)
        }
            
        .onAppear{
            print("view appeared")
            
            NetworkService.sharedInstance.fetchMovies(with: .POPULAR, completion: { result in
                switch result {
                case .success(let movies):
                    DispatchQueue.main.async {
                        self.moviesObject.popularMovies = movies
                    }
                case .failure(_):
                    print("fail to show movies in the view∫")
                }
                
            });
            
            NetworkService.sharedInstance.fetchMovies(with: .NOW_PLAYING, completion: { result in
                switch result {
                case .success(let movies):
                    DispatchQueue.main.async {
                        self.moviesObject.nowPlayingMovies = movies
                    }
                case .failure(_):
                    print("fail to show now playing movies in the view∫")
                }
            });
            UITableView.appearance().separatorStyle = .none
        }
    }
    
    var nowPlayingList: some View {
        
        VStack(alignment: .leading) {
            
            HStack {
                Text("Now Playing")
                    
                    .font(.headline)
                    .padding(.leading, 8)
                
                Spacer()
                
                Button(action: {
                    self.showingAllPopularMovies.toggle()
                }) {
                    Text("See all")
                    }.popover(isPresented: $showingAllPopularMovies) {
                        SeeAllNowPlayingView().environmentObject(self.moviesObject)
                }.foregroundColor(Color.primary)
                
            }
            
            
            
            
            ScrollView(.horizontal){
                HStack {
                    ForEach (moviesObject.nowPlayingMovies, id: \.self) { movie in
                        NavigationLink(destination: MovieDetailView(title: movie.title, overview: movie.overview, vote_average: movie.vote_average.cleanValue, poster_path: movie.poster_path)) {
                            
                            NowPlayingCell(title: movie.title, overview: movie.overview, vote_average: movie.vote_average.cleanValue, poster_path: movie.poster_path)
                        }
                    }
                }
            }
        }
    }
    
    var list: some View {
        List {
            nowPlayingList
            Text("Popular Movies")
                .font(.headline)
                .padding(.leading, 0)
            ForEach(moviesObject.popularMovies.filter {
                self.searchText.isEmpty ? true : $0.title.lowercased().contains(self.searchText.lowercased())
            }, id: \.self) { movie in
                NavigationLink(destination: MovieDetailView(title: movie.title, overview: movie.overview, vote_average: movie.vote_average.cleanValue, poster_path: movie.poster_path)) {
                    MovieCell(title: movie.title, overview: movie.overview, vote_average: movie.vote_average.cleanValue, poster_path: movie.poster_path)
                }
            }
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView().environmentObject(MoviesObject())
    }
}

extension Double{
    var cleanValue: String{
        return String(format: 1 == floor(self) ? "%.0f" : "%.1f", self)
    }
}
