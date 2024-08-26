//
//  AppDelegate.swift
//  Lckukynumber
//
//  Created by adin on 2024/7/16.
//

import UIKit
import Adjust
import AppTrackingTransparency

extension Notification.Name {
    static let StruckShowADSNotification = Notification.Name("showAds")
}

var adsData: [String: Any]?

@main
class AppDelegate: UIResponder, UIApplicationDelegate ,AdjustDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        let dictArray: [[String: Any]]? = nil
        
        let defaults = UserDefaults.standard
        
        let retrievedArray = defaults.array(forKey: "myDictArray")
        if  ((retrievedArray == nil)){
            defaults.set(dictArray, forKey: "myDictArray")
        }

        defaults.synchronize()
        
        let token = "rz80bwazigao"
        let environment = ADJEnvironmentProduction
        let myAdjustConfig = ADJConfig(
               appToken: token,
               environment: environment)
        myAdjustConfig?.delegate = self
        myAdjustConfig?.logLevel = ADJLogLevelVerbose
        Adjust.appDidLaunch(myAdjustConfig)
        return true
    }
  
    func applicationDidBecomeActive(_ application: UIApplication) {
        Adjust.trackSubsessionStart()
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.4) {
            if #available(iOS 14, *) {
                ATTrackingManager.requestTrackingAuthorization { status in
                }
            }
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        Adjust.trackSubsessionEnd()
    }
    
    func adjustEventTrackingSucceeded(_ eventSuccessResponseData: ADJEventSuccess?) {
        print("adjustEventTrackingSucceeded")
    }
    
    func adjustEventTrackingFailed(_ eventFailureResponseData: ADJEventFailure?) {
        print("adjustEventTrackingFailed")
    }
    
    func adjustAttributionChanged(_ attribution: ADJAttribution?) {
        print("adid\(attribution?.adid ?? "")")
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .StruckShowADSNotification, object: nil, userInfo: nil)
        }
    }
   

}

