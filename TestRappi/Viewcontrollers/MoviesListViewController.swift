//
//  ViewController.swift
//  TestRappi
//
//  Created by Felipe Aragon on 9/7/18.
//  Copyright © 2018 Felipe Aragon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MoviesListViewController: UIViewController {

    
    //Variables
    var reachabilityService: ReachabilityService?
    var array:Variable<[Movie]> = Variable([])
    let disposeBag = DisposeBag()
    var page : Variable<Int> = Variable<Int>(1)
    var totalPage : Int = 0
    
    //views
    @IBOutlet weak var searchView: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setupRx()  {
        
        reachabilityService = try! DefaultReachabilityService()
        
        self.tableview.rowHeight = UITableViewAutomaticDimension
        self.tableview.estimatedRowHeight = 110.0
        
        //fetch movies
        self.page.asObservable().flatMapLatest { currentpage -> Observable<ResultMovie> in
            return ApiServices.shared.getMovies(typeRequest: TypeRequest(rawValue: self.view.tag)!, page: currentpage ).catchErrorJustReturn(ResultMovie())
            }
            .subscribe(onNext: { resultMoview in
                if let totalpage = resultMoview.total_pages, let result = resultMoview.results{
                    
                    self.totalPage = totalpage
                    self.array.value = self.array.value + result
                    DispatchQueue.main.async {
                        StorageServices.shared.saveMovies(resultMovie: self.array.value, typeRequest: TypeRequest(rawValue: self.view.tag)!)
                    }
                }else{
                     DispatchQueue.main.async {
                        if let result = StorageServices.shared.loadMovies(typeRequest: TypeRequest(rawValue: self.view.tag)!){
                            self.array.value = result
                        }
                    }
                }
            }, onError:{ error in
                print(error)
            }).disposed(by: disposeBag)
        
        //draw cell views movie
        self.array.asObservable().bind(to: tableview.rx.items(cellIdentifier: getIdentifierCell(),cellType: MoviesTableViewCell.self)) {
            (index, movie: Movie, cell) in
            
                var urlImage = ""
                if let image = movie.backdrop_path{
                    urlImage = image
                }else if let image = movie.poster_path{
                    urlImage = image
                }
                cell.titleLabel?.text = movie.title
                cell.movieImageView?.sd_setImage(with: URL(string: Constants.API.imageUrlBase+urlImage), completed: nil)
                cell.movieImageView.clipsToBounds = true
                cell.popularityLabel?.text = "\(String(describing: movie.popularity!))"
                cell.numvotesLabel?.text = "\(String(describing: movie.vote_count!))"
                cell.ratedLabel?.text = "\(String(describing: movie.vote_average!))"
            
            }.disposed(by: disposeBag)
        
        //load more cells
        self.tableview.rx.willDisplayCell
            .filter { _ in (Reachability()?.isReachable)! }
            .subscribe(onNext: { cell, indexPath in
            let lastElement = self.array.value.count - 1
            if indexPath.row == lastElement && (self.searchView.text?.isEmpty)!{
               self.page.value = self.page.value + 1
            }
        })
        .disposed(by: disposeBag)
        
        //select movie detail
        self.tableview.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            let currentMovie: Movie = (try! self?.tableview.rx.model(at: indexPath))!
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let detailViewController:MovieDetailViewController = storyBoard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
            detailViewController.movie = currentMovie
            self?.present(detailViewController, animated: true, completion: nil)
            
        }).disposed(by: disposeBag)
        
        //search movies
        self.searchView.rx.text.orEmpty
            .throttle(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe{ query in
                
                if let query = query.element{
                    if query.isEmpty {
                        self.array.value = []
                        self.page.value = 1
                    }else{
                        let filterarray = self.array.value.filter{ ($0.title?.lowercased().contains(query.lowercased()))! }
                        self.array.value = filterarray
                    }
                }
                
            }
            .disposed(by: disposeBag)
        
       
    }
    
    func getIdentifierCell() -> String {
        switch TypeRequest(rawValue: self.view.tag)! {
            case .popular , .upcoming:
                return "cellMovie"
            case .toprated :
                return "cellMovieTop"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

