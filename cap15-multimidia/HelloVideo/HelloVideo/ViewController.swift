//
//  ViewController.swift
//  HelloVideo
//
//  Created by Ricardo Lecheta on 7/5/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    @IBOutlet var videoView : UIView!
    
    let videoUtil = VideoUtil()
    
    override init() {
        super.init(nibName: "ViewController", bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func play() {
        // Reproduz o vídeo (vamos deixar a URL fixa para testar)
        println("play")
        
        let url = NSURL(string:"http://www.livroiphone.com.br/carros/esportivos/ferrari_ff.mp4")
        self.videoUtil.playUrl(url, view: videoView)
    }
    
    @IBAction func pause() {
        println("pause")
        self.videoUtil.pause()
    }
    
    @IBAction func stop() {
        println("stop")
        self.videoUtil.stop()
    }


}

