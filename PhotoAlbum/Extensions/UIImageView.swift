//
//  UIImageView.swift
//  PhotoAlbum
//
//  Created by Hanan on 6/20/19.
//  Copyright © 2019 HANAN. All rights reserved.
//

import UIKit

extension UIImageView {
    func roundImage() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.masksToBounds = true
    }
}
