//
//  EmployeesService.swift
//  MVVMExample
//
//   Created by Prasanth Podalakur on 22/03/22.
//

import Foundation

protocol MoviesServiceProtocol {
    func getMovies(completion: @escaping (_ success: Bool, _ results: Movies?, _ error: String?) -> ())
}

class MovieService: MoviesServiceProtocol {
    func getMovies(completion: @escaping (Bool, Movies?, String?) -> ()) {
        HttpRequestHelper().GET(url: "http://www.omdbapi.com/?", params: ["apikey":"b9bd48a6","s":"Marvel", "type": "movie"], httpHeader: .application_json) { success, data in
            if success, let data1 = data {
                do {
                    let model = try JSONDecoder().decode(Movies.self, from: data1)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse Movies to model")
                }
            } else {
                completion(false, nil, "Error: Movies GET Request failed")
            }
        }
    }
}



