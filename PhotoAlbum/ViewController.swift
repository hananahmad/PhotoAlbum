//
//  ViewController.swift
//  PhotoAlbum
//
//  Created by Hanan on 6/20/19.
//  Copyright © 2019 HANAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //==================================
    // MARK: - Outlets
    //==================================
    @IBOutlet weak var albumsTableView: UITableView!
    
    //==================================
    // MARK: - Variables
    //==================================
    fileprivate let viewModel = ViewControllerViewModel()

    //==================================
    // MARK: - ViewLifecycle
    //==================================
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ALBUMS"
        albumsTableView?.dataSource = viewModel
        albumsTableView?.estimatedRowHeight = 71
        albumsTableView?.rowHeight = UITableView.automaticDimension
        albumsTableView?.register(AlbumTableViewCell.nib, forCellReuseIdentifier: AlbumTableViewCell.identifier)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if NetworkManager.reachability.connection == .cellular || NetworkManager.reachability.connection == .wifi {
            DataBaseManager.saveAlbumsToDb {
                let albums = DataBaseManager.loadAlbumsFromDb()
                self.viewModel.refreshWith(data: albums, {
                    self.albumsTableView.reloadData()
                })
            }
        } else {
            let albums = DataBaseManager.loadAlbumsFromDb()
            if !albums.isEmpty {
                self.viewModel.refreshWith(data: albums, {
                    self.albumsTableView.reloadData()
                })
            } else {
                // No internet connection or no data stored yet.
            }
        }
    }
}

