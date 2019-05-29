//
//  BannerCollectionViewCell.swift
//  eCommerceApp
//
//  Created by Patricia Benitez on 4/20/19.
//  Copyright © 2019 Patricia Benitez. All rights reserved.
//

import UIKit
import Kingfisher

class BannerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerTitle: UILabel!
    @IBOutlet weak var bannerNote: UILabel!
    @IBOutlet weak var bannerImage: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.bannerImage.layer.cornerRadius = CGFloat(roundf(Float(self.bannerImage.frame.size.width / 20.0)))
    }
    
    func setBanner(banner: Banner) {
        bannerTitle.text = banner.name
        bannerNote.text = banner.note
        if let imageUrl = banner.imageUrl {
            bannerImage.kf.setImage(with: URL(string: imageUrl))
        }
        else {
            bannerImage.image = #imageLiteral(resourceName: "noimage")
        }
    }
}
