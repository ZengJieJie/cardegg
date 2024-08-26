//
//  LUCKYGAViewController.swift
//  Lckukynumber
//
//  Created by adin on 2024/7/16.
//

import UIKit

class LUCKYGAViewController: LckukynumberBaseViewController, UITextViewDelegate {

    @IBOutlet weak var sumbtn: UIButton!
    @IBOutlet weak var optextview: UITextView!
    var TipsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        optextview.delegate = self
        optextview.tintColor = UIColor.white
                
        TipsLabel = UILabel(frame: CGRect(x: 5, y: 8, width: optextview.frame.size.width - 10, height: 20))
        TipsLabel.text = "Enter your comments here"
        TipsLabel.textColor = UIColor.white
        TipsLabel.font = UIFont.boldSystemFont(ofSize: 20)
                
        optextview.addSubview(TipsLabel)
        TipsLabel.isHidden = optextview.text.count > 0
        
        // Do any additional setup after loading the view.
    }
    
    


    @IBAction func disclikc(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        TipsLabel.isHidden = true
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            TipsLabel.isHidden = textView.text.count > 0
        }

        func textViewDidChange(_ textView: UITextView) {
            TipsLabel.isHidden = textView.text.count > 0
        }
    
    
    @IBAction func sumclickBTN(_ sender: UIButton) {
        
        if optextview.text.count > 0 {
                   sender.isUserInteractionEnabled = false
            sumbtn.isUserInteractionEnabled = false
                   let delayTime = DispatchTime.now() + 0.8
                   DispatchQueue.main.asyncAfter(deadline: delayTime) {
                       self.sumbtn.isUserInteractionEnabled = true
                       sender.isUserInteractionEnabled = true
                       let alertController = UIAlertController(title: "Tips", message: "We have received your comments", preferredStyle: .alert)
                       
                       let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                           self.optextview.text = ""
                       }
                       
                       alertController.addAction(okAction)
                       self.present(alertController, animated: true, completion: nil)
                   }
               } else {
                   let alertController = UIAlertController(title: "Tips", message: "Please enter your comments", preferredStyle: .alert)
                   
                   let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                   
                   alertController.addAction(okAction)
                   self.present(alertController, animated: true, completion: nil)
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
