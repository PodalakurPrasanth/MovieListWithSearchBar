//
//  MovieCellViewModel.swift
//  SCBTest
//
//  Created by Prasanth Podalakur on 23/06/22.
//

import Foundation
import UIKit
struct MovieCellViewModel {
    var title: String
    var year: String
    var imdbID: String
    var type: String
    var poster:UIImage?
    
    init(title: String, year: String, imdbID: String, type: String, poster:String){
        self.title = title
        self.year = year
        self.imdbID = imdbID
        self.type = type
        self.poster = self.posterStringToImageConvertion(poster: poster)
    }
    mutating func posterStringToImageConvertion(poster: String) -> UIImage?{
        guard let url = URL(string: poster) else { return nil }
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
                return image
            }
        }
        return nil
    }
}
