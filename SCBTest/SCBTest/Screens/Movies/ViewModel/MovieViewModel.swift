//
//  MovieViewModel.swift
//  SCBTest
//
//  Created by Prasanth Podalakur on 23/06/22.
//

import Foundation
class MovieViewModel: NSObject {
    
    var reloadTableView: (() -> Void)?
    var movies  = MoviesArray()
    private var movieService: MoviesServiceProtocol

    var movieCellViewModels = [MovieCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    var searchMovieCellViewModels = [MovieCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    init(movieService: MoviesServiceProtocol = MovieService()) {
        self.movieService = movieService
    }
    func getEmployees() {
        movieService.getMovies { success, model, error in
            if success, let movies = model?.search {
                self.fetchData(movies: movies)
            } else {
                print(error)
            }
        }
    }
    func fetchData(movies: MoviesArray) {
        self.movies = movies // Cache
        var vms = [MovieCellViewModel]()
        for movie in movies {
            vms.append(createCellModel(movie: movie))
        }
        movieCellViewModels = vms
    }
    func createCellModel(movie: Search) -> MovieCellViewModel {
        return MovieCellViewModel(title: movie.title ?? "", year: movie.year ?? "", imdbID: movie.imdbID ?? "", type: movie.type?.rawValue ?? "", poster: movie.poster ?? "")
    }
    func searchMovies(searchString:String){
        let filterData = movieCellViewModels.filter{
            return $0.title.range(of: searchString, options: .caseInsensitive) != nil
        }
        self.searchMovieCellViewModels = filterData
    }
}
