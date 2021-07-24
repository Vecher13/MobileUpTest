//
//  GalleryViewController.swift
//  MobileUpTest
//
//  Created by Ash on 21.07.2021.
//

import UIKit

class GalleryViewController: UIViewController {

    private let fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    override func viewDidLoad() {
        super.viewDidLoad()
      
        fetcher.getPhotosFromGallery { <#Response?#> in
            <#code#>
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
