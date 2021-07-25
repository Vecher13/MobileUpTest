//
//  FullScreenViewController.swift
//  MobileUpTest
//
//  Created by Ash on 25.07.2021.
//

import UIKit

class FullScreenViewController: UIViewController {

    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var collectionView: UICollectionView!
    private let photoFether = NetworkPhotoFetcher.shared
    
    var items: [Item] = []
    var indexPath: IndexPath? = nil
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
    
    @IBAction func saveAction(_ sender: Any) {
        let cell = collectionView.visibleCells.first
        scrollViewDidEndDecelerating(collectionView)
        print()
    }
  
    

    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()

        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size

        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)

        guard let indexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }
        self.title = "\(indexPath.row)"
        print(indexPath)
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
        }
        print("info", collectionView.numberOfSections)
        
//        self.indexPath = indexPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        print("will \(indexPath.row)")
     
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        print("end \(indexPath.row)")
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(indexPath.row)
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
