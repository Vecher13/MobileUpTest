//
//  PhotoCollectionViewCell.swift
//  MobileUpTest
//
//  Created by Ash on 25.07.2021.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var indicatior: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        imageView.image = nil
        indicatior.isHidden = false
        indicatior.startAnimating()
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(photo: UIImage){
        imageView.image = photo
        if imageView.image != nil {
            indicatior.stopAnimating()
            indicatior.isHidden = true
        }
        
    }

}
