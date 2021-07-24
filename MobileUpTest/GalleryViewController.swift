//
//  GalleryViewController.swift
//  MobileUpTest
//
//  Created by Ash on 21.07.2021.
//

import UIKit

class GalleryViewController: UIViewController {

    private let networkService = NetworkService()
    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.getData()
        // Do any additional setup after loading the view.
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
