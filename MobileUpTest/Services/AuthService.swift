//
//  AuthService.swift
//  MobileUpTest
//
//  Created by Ash on 20.07.2021.
//

import Foundation
import  VKSdkFramework

protocol  AuthServiceDelegate: AnyObject {
    func authServiceShouldShow(viewContriller: UIViewController)
    func authServiceSignIn()
    func authServiceDidSignInFail()
}

final class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate{
 
    
    private let appId = "7907577"
    private let vkSdk: VKSdk
    
    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        print("VKSdk.initialize")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    weak var delegate: AuthServiceDelegate?
    
    func  wakeUpSession(){
        let scope = ["offline"]
        
        VKSdk.wakeUpSession(scope) { [delegate] state, error in
            
            switch state {
            case .initialized:
                VKSdk.authorize(scope)
            case .authorized:
                delegate?.authServiceSignIn()
            default:
                print("auth problem, state \(state) error \(print(error as Any))")
                
                delegate?.authServiceDidSignInFail()
            }
        }
    }
    
    
    // MARK: VKSdkDelegate
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            delegate?.authServiceSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
        delegate?.authServiceDidSignInFail()
    }
    
    // MARK: VKSdkUIDelegate
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.authServiceShouldShow(viewContriller: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
    
}
