//
//  FullScreenViewController.swift
//  MobileUpTest
//
//  Created by Ash on 25.07.2021.
//

import UIKit
import Foundation
import Photos

class FullScreenViewController: UIViewController {
    
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var collectionView: UICollectionView!
    private let photoFether = NetworkPhotoFetcher.shared
    var imageTake: UIImageView? = nil
    var items: [Item] = []
    var indexPath: IndexPath? = nil
    var imageURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        layout.scrollDirection = .horizontal
        collectionView.register(UINib(nibName: String(describing: FullScreenCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: "FullScreenCell")
        
        collectionView.performBatchUpdates(nil) { result in
            guard let indexPath = self.indexPath else {return}
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
    }
    
    
    @IBAction func saveAction(_ sender: UIBarItem) {
        
        guard let url = self.imageURL else {return}
        photoFether.getImage(url: url) { image in
            
            self.weiteToPhotoAlbom(image: image)
            
        }
        print("lskdjflkj")
    }
    
    
    //MARK: - identify the cell
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        guard let indexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }
        
        
        let time = items[indexPath.row].date
        self.imageURL = items[indexPath.row].sizes[6].url
        self.title = date(from: time)
        self.indexPath = indexPath
    }
    
    func date(from data: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(data))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM YYYY"
        return dateFormatter.string(from: date)
    }
    
}


extension FullScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FullScreenCell", for: indexPath) as? FullScreenCollectionViewCell else {return UICollectionViewCell()}
        cell.indicator.startAnimating()
        let item = items[indexPath.row]
        let imageURL = item.sizes[6].url
        photoFether.getImage(url: imageURL) { image in
            cell.configCell(photo: image)
            DispatchQueue.main.async {
                self.imageTake?.image = image
                print("downloaded", image)
            }
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameCV = collectionView.frame
        
        return CGSize(width: frameCV.width,
                      height: frameCV.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets (top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0.0)
    }
    
}

//MARK: - Save image

extension FullScreenViewController {
    func weiteToPhotoAlbom(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
        
    }
}
