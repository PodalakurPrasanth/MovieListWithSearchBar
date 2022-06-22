//
//  MoviesCollectionViewCell.swift
//  SCBTest
//
//  Created by Prasanth Podalakur on 23/06/22.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    var cellViewModel: MovieCellViewModel? {
        didSet {
            posterImageView.image = cellViewModel?.poster
            movieTitleLabel.text = cellViewModel?.title ?? ""
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        movieTitleLabel.text = nil
    }
}
