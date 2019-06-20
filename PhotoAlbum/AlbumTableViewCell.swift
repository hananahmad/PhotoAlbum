//
//  AlbumTableViewCell.swift
//  PhotoAlbum
//
//  Created by Hanan on 6/20/19.
//  Copyright © 2019 HANAN. All rights reserved.
//

import UIKit
import Kingfisher

class AlbumTableViewCell: UITableViewCell {

    //==================================
    // MARK: - Outlets
    //==================================
    @IBOutlet weak var titleTextLbl: UILabel! // Title of Album
    
    @IBOutlet weak var thumbnailImageView: UIImageView! {
        didSet {
            thumbnailImageView.roundImage()
        }
    }
    
    // Set Album Data
    var item: AlbumViewModel? {
        didSet {
            
            // Set Title
            titleTextLbl.text   = item?.title ?? ""
            
            // Set Thumbnail image
            if let thumbnailURL = item?.thumbnailUrl, !thumbnailURL.isEmpty {
                if let url = URL(string: thumbnailURL) {
                    thumbnailImageView.kf.indicatorType = .activity
                    thumbnailImageView.kf.setImage(with: url)
                }
            }
        }
    }

    
    //==================================
    // MARK: - View LifeCycle
    //==================================
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView?.image = nil
    }
    
}
