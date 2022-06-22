//
//  MoviesViewController.swift
//  SCBTest
//
//  Created by Prasanth Podalakur on 23/06/22.
//

import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var mainCollectionView : UICollectionView!
    lazy var viewModel = {
        MovieViewModel()
    }()
    var isSearchButtonTapped = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        self.initViewModel()
        // Do any additional setup after loading the view.
    }
    
    func initView() {
        self.movieSearchBar.delegate = self
        mainCollectionView.register(UINib(nibName: "MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MoviesCollectionViewCell")
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.backgroundColor = UIColor(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1))

    }
    func initViewModel(){
        ProgressHUD.show("Please Wait...")
        viewModel.getEmployees()
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.mainCollectionView.reloadData()
                ProgressHUD.dismiss()
            }
        }
    }
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard self.isSearchButtonTapped else {
            return viewModel.movieCellViewModels.count
        }
        return viewModel.searchMovieCellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as? MoviesCollectionViewCell else{return UICollectionViewCell()}
        if self.isSearchButtonTapped {
            cell.cellViewModel = viewModel.searchMovieCellViewModels[indexPath.row]
        }else {
            cell.cellViewModel = viewModel.movieCellViewModels[indexPath.row]
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: self.mainCollectionView.frame.size.width/2.1, height: collectionView.frame.size.width/2.1)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        self.movieSearchBar.text = ""
        self.view.endEditing(true)
        self.isSearchButtonTapped = false
        self.mainCollectionView.reloadData()
    }
    
}

extension MoviesViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        self.isSearchButtonTapped = true
        if searchText.count == 0 {
            self.isSearchButtonTapped = false
            self.mainCollectionView.reloadData()
        }
        viewModel.searchMovies(searchString: searchText)
    }
}
extension MoviesViewController{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.isSearchButtonTapped = false
        self.mainCollectionView.reloadData()
    }
}
