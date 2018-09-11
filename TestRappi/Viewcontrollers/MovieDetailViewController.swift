//
//  MovieDetailViewController.swift
//  TestRappi
//
//  Created by Felipe Aragon on 9/11/18.
//  Copyright © 2018 Felipe Aragon. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift

class MovieDetailViewController: UIViewController {

    //Views
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var numVoteLabel: UILabel!
    @IBOutlet weak var ratedLabel: UILabel!
    @IBOutlet weak var btnDone: UIButton!
    
    //Variables
    var movie : Movie?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie{
            if let title = movie.title{
                titleMovieLabel.text = title
                titleMovieLabel.sizeToFit()
            }
            if let overview = movie.overview{
                overviewLabel.text = overview
                overviewLabel.sizeToFit()
            }
            if let popularity = movie.popularity{
                popularityLabel.text = "\(popularity)"
            }
            if let numvote = movie.vote_count{
                numVoteLabel.text = "\(numvote)"
            }
            if let rated = movie.vote_average{
                ratedLabel.text = "\(rated)"
            }
            if let urlimage = movie.poster_path{
                imageMovie.sd_setImage(with: URL(string: Constants.API.imageUrlBaseLarge+urlimage), completed: nil)
                imageMovie.clipsToBounds = true
            }else if let urlimage = movie.backdrop_path{
                imageMovie.sd_setImage(with: URL(string: Constants.API.imageUrlBaseLarge+urlimage), completed: nil)
                imageMovie.clipsToBounds = true
            }
            
            btnDone.rx.tap.subscribe({ [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
