//
//  TrailerDetailController.swift
//  TrailerApp500790824
//
//  Created by Dennis Pagarusha on 13/04/2019.
//  Copyright © 2019 Dennis Pagarusha. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import AVKit
import AVFoundation

class TrailerDetailController: UIViewController {
    
    let bullet = NSLocalizedString("bullet_dot", comment: "")
    var trailer: Trailer?
    var trailerUrl: URL?
    
    @IBOutlet weak var mainView: View!
    
    @IBOutlet weak var stillImage: UIImageView!
    
    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var trailerButton: UIButton!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var shareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var genreText: String = ""
        let stillUrl = trailer?.stillImageUrl
        let posterUrl = trailer?.posterImageUrl
        
        // Make navigation bar transparent and color return control white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = .white
        
        titleLabel.text = trailer?.title
        trailerButton.setTitle(NSLocalizedString("Watch trailer", comment: ""), for: .normal)
        descriptionTextView.text = trailer?.description
        
        if let url = trailer?.trailerUrl {
            trailerUrl = URL(string: url)!
        }
        
        // Format and genre list
        if let genres = trailer?.genres {
            
            for i in genres.indices {
                genreText += genres[i]
                
                if (i != genres.count - 1) {
                    genreText += " " + bullet + " "
                }
            }
        }
        genreLabel.text = genreText
        
        // Set activity indicator for images
        stillImage.kf.indicatorType = .activity
        posterImage.kf.indicatorType = .activity
        
        // Get still image
        if let url = stillUrl {
            stillImage.kf.setImage(with: URL(string: url), options: [.transition(.fade(0.3))])
        }
        
        // Get poster image
        if let url = posterUrl {
            posterImage.kf.setImage(with: URL(string: url), options: [.transition(.fade(0.3))])
        }
        
    }
    
    @IBAction func playTrailer(_ sender: UIButton) {
        startMoviePlayer(url: trailerUrl!)
    }
    
    @IBAction func shareTrailerUrl(_ sender: UIButton) {
        let items = [trailerUrl]
        let ac = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
        
        if let wPPC = ac.popoverPresentationController {
            wPPC.sourceView = shareButton
        }
        present(ac, animated: true, completion: nil)
        shareButton.alpha = 1
    }
    
    
    @IBAction func buttonTouchDown(_ sender: UIButton) {
        shareButton.alpha = 0.5
    }
    
    /*
     * Spin up AVPlayer for given URL
     */
    func startMoviePlayer(url: URL) {
        
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        present(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
    }
}
