//
//  LuckymultiplicationViewController.swift
//  Lckukynumber
//
//  Created by adin on 2024/7/16.
//

import UIKit

class LuckymultiplicationViewController: LckukynumberBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func BBACKBTN(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func JIAJIANBTN(_ sender: Any) {
                
                let vc = SimplicityAdditionViewController()
        vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
               
    }
    
    
    @IBAction func CHENGCHUBTN(_ sender: Any) {
        let vc = SuggestionViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func JIAJIANCHENGCHUBTN(_ sender: Any) {
        let vc = DoubleAdditionViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
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
