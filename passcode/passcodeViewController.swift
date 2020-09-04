//
//  passcodeViewController.swift
//  passcode
//
//  Created by 方芸萱 on 2020/9/3.
//

import UIKit

class passcodeViewController: UIViewController {
    
    @IBOutlet var guessImagesBgs: [UIView]!
    let correctPasscode = [2, 5, 8, 0]
    var guessPasscode = [Int]()
    let guessImageName = ["soldier", "alice", "cat", "hat"]
    @IBOutlet var guessImages: [UIImageView]!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initial()
    }
    func initial(){
        print("initial")
        welcomeLabel.text = "歡迎來到女王茶會\n請輸入邀請函上的通行密碼"
        //clear guessPassscode
        guessPasscode = []
        initialImage()
    }
    func initialImage(){
        for i in 0...guessImages.count-1{
            //set guessImage mask
            let imageView = UIImageView(image: UIImage(named: "\(guessImageName[i])"))
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: 0, y: 0, width: 94, height: 93)
            let blueView = UIView(frame: imageView.frame)
            blueView.backgroundColor = UIColor.white
            guessImagesBgs[i].mask = imageView
            guessImagesBgs[i].addSubview(blueView)
            //clear guessImage
            guessImages[i].isHidden = true
        }
    }
    func checkPasscode(){
        print("check passcode")
      
        if guessPasscode == correctPasscode{
            //if correct, present pass controller
            print("CORRECT")
            performSegue(withIdentifier: "correctPasscode", sender: self)
        }else{
            //if fail, show alert; if user click tryAgain, execute initial()
            print("ERROR")
            let alert = UIAlertController(title: "通行密碼錯誤", message: "請查看邀請函", preferredStyle: .alert)
            let action = UIAlertAction(title: "再試一次", style: .default) { (_) in
                self.initial()
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func pressDeleteButton(_ sender: UIButton) {
        print("press delete button")
        let guessIndex = guessPasscode.count
        if guessIndex > 0{
            guessPasscode.remove(at: guessIndex-1)
            print(guessPasscode)
            //clear guessImage
            guessImages[guessIndex-1].isHidden = true
        }
    }
    
    @IBAction func pressNumButtons(_ sender: UIButton) {
        let btn = sender.tag
//        print("press \(btn)")
        guessPasscode.append(btn)
//        print(guessPasscode)
        let guessIndex = guessPasscode.count
        //set guessImage
        guessImages[guessIndex-1].isHidden = false
        
        //if guess done, then check passcode
        if guessIndex >= 4{
            //delay
            let delaySeconds = 0.1
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delaySeconds) {
                self.checkPasscode()
            }
        }
    }
}
