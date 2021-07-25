//
//  FullScreenCollectionViewCell.swift
//  MobileUpTest
//
//  Created by Ash on 25.07.2021.
//

import UIKit

class FullScreenCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        imageView.image = nil
        indicator.isHidden = false
        indicator.startAnimating()
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(photo: UIImage){
        imageView.image = photo
        if imageView.image != nil {
            indicator.stopAnimating()
            indicator.isHidden = true
        }
        
    }

}
