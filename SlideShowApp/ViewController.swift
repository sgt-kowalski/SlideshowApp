//
//  ViewController.swift
//  SlideShowApp
//
//  Created by ken on 2017/07/29.
//  Copyright © 2017年 ken. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    
    var imageArray:[UIImage] = []   //画像の配列
    var photoNumber:Int = 0         //画像の番号
    var slideShow = false           //スライドショーが再生中か否か
    //var maxNumber:Int = 0         //写真の枚数
    var timer:Timer!
    var timer_sec = 0

    //画像を表示する関数
    func showPicture(){
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.image = imageArray[photoNumber]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //画像を配列に保存
        for i in 0...2{
            imageArray.append(UIImage(named: "\(i).jpg")!)
         }
        
        /*
        while let image = UIImage(named: "(imageArray.count).jpg") {
            imageArray.append(image)
            maxNumber += 1
        }
        */
        
        showPicture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //タイマーで画像の番号を加算
    func updateTimer(timer:Timer){
        timer_sec += 2
        if photoNumber < 2 {
            photoNumber += 1
        }else{
            photoNumber = 0}
        
        showPicture()
    }

    //「進む」ボタンのアウトレットとアクション
    @IBOutlet weak var forwardButton: UIButton!
    @IBAction func forwardButton(_ sender: UIButton) {
        if photoNumber < 2 {
            photoNumber += 1
        }else{
            photoNumber = 0}
            showPicture()
        }

    //「戻る」ボタンのアウトレットとアクション
    @IBOutlet weak var backButton: UIButton!
    @IBAction func backButton(_ sender: UIButton) {
        if photoNumber > 0 {
            photoNumber -= 1
        }else{
            photoNumber = 2}
            showPicture()
        }

    //「再生／停止」ボタンのアウトレットとアクション
    @IBOutlet weak var playAndStop: UIButton!
    @IBAction func playAndStop(_ sender: UIButton) {
        
        //スライドショー再生中
        if slideShow == false{
            sender.setTitle("停止", for: .normal)
            slideShow = true
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            
            forwardButton.isEnabled = false
            forwardButton.alpha = 0.1
            backButton.isEnabled = false
            backButton.alpha = 0.1
        
        //スライドショー停止中
        }else{
            sender.setTitle("再生", for: .normal)
            timer.invalidate()
            slideShow = false
            
            forwardButton.isEnabled = true
            forwardButton.alpha = 1.0
            backButton.isEnabled = true
            backButton.alpha = 1.0
        }
    }
    
    //画面遷移の準備＝表示されている画像の番号を遷移先に渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let largeViewController:LargeViewController = segue.destination as! LargeViewController
        largeViewController.number = photoNumber
        
        //スライドショーが再生中ならば停止状態に戻す
        if slideShow == true{
            timer.invalidate()
            slideShow = false
        
            forwardButton.isEnabled = true
            forwardButton.alpha = 1.0
            backButton.isEnabled = true
            backButton.alpha = 1.0
        
            playAndStop.setTitle("再生", for: .normal)
        }
    }
    
    //遷移先の画面から戻ってくるための関数
    @IBAction func unwind(_ segue:UIStoryboardSegue){
    }
}

