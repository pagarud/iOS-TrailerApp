//
//  ViewController.swift
//  TrailerApp500790824
//
//  Created by Dennis Pagarusha on 12/04/2019.
//  Copyright © 2019 Dennis Pagarusha. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    var trailers: [Trailer] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("main_app_title", comment: "")
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        
        // Set datasource for tableview
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TrailerTableCell", bundle: nil), forCellReuseIdentifier: "TrailerTableCell")
        
        // Get data from API
        let url = NSLocalizedString("base_url", comment: "")
        
        let spinner = createSpinner()
        
        Alamofire.request(url)
            .responseData(completionHandler: { [weak self] (response) in
                guard let jsonData = response.data else { return }
                
                let decoder = JSONDecoder()
                let data = try? decoder.decode([Trailer].self, from: jsonData)
                
                self?.trailers = data!
                
                self?.removeSpinner(spinner: spinner)
            })
        
        setUpRefreshControl()
    }
    
    // Set up refresh control
    func setUpRefreshControl() {
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc func refresh() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func createSpinner() -> SpinnerViewController {
        let child = SpinnerViewController()
        
        // Add the spinner viewcontroller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        return child
    }
    
    func removeSpinner(spinner: SpinnerViewController) {
        spinner.willMove(toParent: nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return trailers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Fetch container for current cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrailerTableCell", for: indexPath) as! TrailerTableCell
        
        // Set cell attributes
        let trailer: Trailer = trailers[indexPath.row]
        
        cell.titleLabel.text = trailer.title
        let posterUrl = URL(string: trailer.posterImageUrl)
        cell.posterImageView.kf.indicatorType = .activity
        cell.posterImageView.kf.setImage(with: posterUrl, options: [.transition(.fade(0.3))])
        cell.descriptionTextView.text = trailer.description
        
        return cell
    }
}

// Set Detail view delegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Define current storyboard
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Get a reference to the new controller
        let trailerDetailController: TrailerDetailController = storyboard.instantiateViewController(withIdentifier: "TrailerDetailController") as! TrailerDetailController
        
        // Pass current trailer on to detail view
        trailerDetailController.trailer = trailers[indexPath.row]
        
        // Set push view
        self.navigationController?.pushViewController(trailerDetailController, animated: true)
    }
}
