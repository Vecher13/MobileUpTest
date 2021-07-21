//
//  AuthService.swift
//  MobileUpTest
//
//  Created by Ash on 20.07.2021.
//

import Foundation
import  VKSdkFramework

final class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate{
 
    
    private let appId = "7907577"
    private let vkSdk: VKSdk
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        print("VKSdk.initialize")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func  wakeUpSession(){
        let scope = ["offline"]
        
        VKSdk.wakeUpSession(scope) { state, error in
            if state == VKAuthorizationState.authorized {
                print("VKAuthorizationState.authorized ")
            } else if state == VKAuthorizationState.initialized {
                print("VKAuthorizationState.initialized")
                VKSdk.authorize(scope)
            } else {
                print("auth problem, state \(state) error \(print(error as Any))")
            }
        }
    }
    
    
    // MARK: VKSdkDelegate
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
    
    // MARK: VKSdkUIDelegate
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
    
}
