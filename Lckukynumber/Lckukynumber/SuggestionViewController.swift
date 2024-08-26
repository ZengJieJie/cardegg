//
//  SuggestionViewController.swift
//  Lckukynumber
//
//  Created by adin on 2024/7/16.
//

import UIKit
import Masonry
class SuggestionViewController: LckukynumberBaseViewController {

    @IBOutlet weak var gameview: UIView!
    
    
    @IBOutlet weak var luckynumber: UILabel!
    @IBOutlet weak var symbollab: UILabel!
    
    @IBOutlet weak var marklab: UILabel!
    
    
    @IBOutlet weak var timelabb: UILabel!
    var buttonsimArray: [UIButton] = []
    var bRandomaray: [Any] = []
    
    var timernumber = 60
    var marksco = 0
    var gametimer: Timer?
    var LckyNumber: Int = 0
    var LckyNumbersum: Int = 0
    var LckyNumberjian: Int = 0
    var lastNIBButton: UIButton?
    var secondNIBButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gametimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(gameTimeLabel), userInfo: nil, repeats: true)
        
        
        let numbers = [12, 14, 15, 16, 18, 20, 21, 24, 25, 27, 28, 30, 32, 35, 36, 40, 42, 45, 48, 49]

       
        
        self.LckyNumber = numbers.randomElement()!
        self.LckyNumbersum = numbers.randomElement()!
        
        while (self.LckyNumbersum==self.LckyNumber){
            self.LckyNumbersum = numbers.randomElement()!
        }
       
        
        self.LckyNumberjian = RandomgenerationLckyNumber(between: 2, and: 5)
        
        
        self.bRandomaray = bRandomarayRandomNumbers(count: 36, min: 1, max: 10)
        self.luckynumber.text="Lucky:\(self.LckyNumber) \(self.LckyNumberjian) \(self.LckyNumbersum)"
        self.marklab.text="Score:\(self.marksco)"
        createGrid()
        // Do any additional setup after loading the view.
    }
    
   
    
   
    
    func bRandomarayRandomNumbers(count: Int, min: Int, max: Int) -> [Int] {
        var numbers = [Int]()
        numbers.reserveCapacity(count)
        
        for _ in 0..<count {
            let randomNumber = Int(arc4random_uniform(UInt32(max - min + 1))) + min
            numbers.append(randomNumber)
        }
        
        return numbers
    }
    
    func RandomgenerationLckyNumber(between min: Int, and max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max - min + 1))) + min
    }
    func createGrid() {
        let rows = 6
        let columns = 6
        
        var lastView: UIView? = nil
        
        for i in 0..<rows {
            for j in 0..<columns {
                let button = UIButton(type: .custom)
                let tagsj = Int(arc4random_uniform(4)) + 1
                let imageName = "\(bRandomaray[i * columns + j])"
                
                button.setBackgroundImage(UIImage(named: imageName), for: .normal)
                button.tag = i * columns + j
                
                 button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
                self.gameview.addSubview(button)
                buttonsimArray.append(button)
                
                button.mas_makeConstraints { make in
                    if let lastView = lastView {
                        if j == 0 {
                            make?.top.equalTo()(lastView.mas_bottom)?.offset()(5)
                            make?.left.equalTo()( self.gameview)
                        } else {
                            make?.left.equalTo()(lastView.mas_right)?.offset()(5)
                            make?.top.equalTo()(lastView.mas_top)
                        }
                    } else {
                        make?.top.left().equalTo()( self.gameview)
                    }
                    make?.width.equalTo()(self.gameview)?.multipliedBy()(1.0 / CGFloat(columns))?.offset()(-5)
                    make?.height.equalTo()(button.mas_width)
                }
                
                lastView = button
            }
        }
    }
    
    
    @objc func gameTimeLabel() {
        timernumber -= 1
        timelabb.text = "\(timernumber)"
        
        if timernumber <= 0 {
            gametimer?.invalidate()
            gametimer = nil
            gameoverganmeTime()
        }
    }
    
    func gameoverganmeTime() {
        let message = "Hello, the game is over and your score is \(marksco) points"
        let alertController = UIAlertController(title: "Title", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
            
            let defaults = UserDefaults.standard
            
            var retrievedArray: [Any] = []
            
            retrievedArray=defaults.array(forKey: "myDictArray") ?? []
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

           
            let currentDate = Date()
            let formattedDate = dateFormatter.string(from: currentDate)

           
            let dataArray: [Any] = [
                "*chubtn",
                "\(self.marksco)",
                formattedDate
            ]
            retrievedArray.append(dataArray)
            
            
            
            defaults.set(retrievedArray, forKey: "myDictArray")
            defaults.synchronize()
        }
        
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func backtap(_ sender: Any) {
        
        
        self.dismiss(animated: true)
    }
    
    
    @IBAction func restartbtn(_ sender: Any) {
        let alertController = UIAlertController(title: "Title", message: "Are you sure you want to reset the game?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default) { [self] _ in
            self.bRandomaray = self.bRandomarayRandomNumbers(count: 25, min: 1, max: 10) as [NSNumber]
            self.updateButtonBackgroundImages()
            self.marksco = 0
            self.timernumber = 60
            
            let numbers = [12, 14, 15, 16, 18, 20, 21, 24, 25, 27, 28, 30, 32, 35, 36, 40, 42, 45, 48, 49]

           
            
            self.LckyNumber = numbers.randomElement()!
            self.LckyNumbersum = numbers.randomElement()!
            
            while (self.LckyNumbersum==self.LckyNumber){
                self.LckyNumbersum = numbers.randomElement()!
            }
           
            
            self.LckyNumberjian = self.RandomgenerationLckyNumber(between: 2, and: 5)
            
            self.bRandomaray = bRandomarayRandomNumbers(count: 25, min: 1, max: 10)
            
            self.luckynumber.text="Lucky:\(self.LckyNumber) \(self.LckyNumberjian) \(self.LckyNumbersum)"
            self.marklab.text="Score:\(self.marksco)"
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
   
    @objc func buttonClicked(_ sender: UIButton) {
        sender.isEnabled = false
        sender.alpha = 0.5
        
        secondNIBButton?.isEnabled = true
        secondNIBButton?.alpha = 1.0
        
        secondNIBButton = lastNIBButton
        lastNIBButton = sender
        
        if let lastButton = lastNIBButton, let secondButton = secondNIBButton {
            if let ac = bRandomaray[lastButton.tag] as? NSNumber, let bc = bRandomaray[secondButton.tag] as? NSNumber {
                let acbcSum = ac.intValue * bc.intValue
                let acbcjian = bc.intValue / ac.intValue
                

                if (acbcSum == LckyNumber || acbcjian == LckyNumber||acbcSum == LckyNumberjian || acbcjian == LckyNumberjian||acbcSum == self.LckyNumbersum || acbcjian == LckyNumbersum) {
                    secondButton.isEnabled = true
                    secondButton.alpha = 1.0
                    lastButton.isEnabled = true
                    lastButton.alpha = 1.0
                    
                    modifyArrayItem(at: lastButton.tag, with: RandomgenerationLckyNumber(between: 1, and: 10) as NSNumber)
                    modifyArrayItem(at: secondButton.tag, with: RandomgenerationLckyNumber(between: 1, and: 10) as NSNumber)
                    
                    let tagsj1 = Int(arc4random_uniform(4)) + 1
                    let tagsj2 = Int(arc4random_uniform(4)) + 1
                    secondButton.setBackgroundImage(UIImage(named: "\(bRandomaray[secondButton.tag])"), for: .normal)
                    lastButton.setBackgroundImage(UIImage(named: "\(bRandomaray[lastButton.tag])"), for: .normal)
                    
                    lastNIBButton = nil
                    lastNIBButton = nil
                    marksco += 10
                    marklab.text = "\(marksco)"
                }
            }
        }
    }
    
    func modifyArrayItem(at index: Int, with value: NSNumber) {
        if index < bRandomaray.count {
            bRandomaray[index] = value
        } else {
            print("Index out of bounds")
        }
    }
    
    func updateButtonBackgroundImages() {
        for button in buttonsimArray {
            button.setBackgroundImage(UIImage(named: "\(bRandomaray[button.tag])"), for: .normal)
        }
    }

  
}
