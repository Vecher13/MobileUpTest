//
//  AuthViewController.swift
//  MobileUpTest
//
//  Created by Ash on 20.07.2021.
//

import UIKit

class AuthViewController: UIViewController {
    @IBOutlet var label: UILabel!
    @IBOutlet var button: UIButton!
    
    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Mobile Up \nGallery"
        button.layer.cornerRadius = 8
        authService = AuthService()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInTouch(_ sender: Any) {
        authService.wakeUpSession()
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
