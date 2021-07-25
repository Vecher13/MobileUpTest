//
//  GalleryViewController.swift
//  MobileUpTest
//
//  Created by Ash on 21.07.2021.
//

import UIKit

class GalleryViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    private let fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    private let photoFether = NetworkPhotoFetcher.shared
    private var items: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.register(UINib(nibName: String(describing: PhotoCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: "Cell")
        self.title = "Mobile Up Gallery"
        fetchPhotos()
       
    }
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {

    }
    
    func fetchPhotos(){
        fetcher.getPhotosFromGallery { response in
            guard let items = response?.items else {return}
            self.items = items
            self.collectionView.reloadData()
            print("count of photo: ", items.count)
        }
    }
    @IBAction func logOutTouch(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
        AuthService().endSession()
    
    }
}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PhotoCollectionViewCell else {return UICollectionViewCell()}
        cell.indicator.startAnimating()
        let item = items[indexPath.row]
        let imageURL = item.sizes[6].url
        photoFether.getImage(url: imageURL) { image in
            cell.configCell(photo: image)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width / 2) - 5,
                      height: (view.frame.size.width / 2) - 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets (top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: "FullScreenViewController") as? FullScreenViewController else {return}
        vc.items = self.items
        vc.indexPath = indexPath
        let date = items[indexPath.row].date
        vc.title = vc.date(from: date)
        let imageURL = items[indexPath.row].sizes[6].url
        vc.imageURL = imageURL
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
