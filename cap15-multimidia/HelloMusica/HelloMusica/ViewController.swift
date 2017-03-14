//
//  ViewController.swift
//  HelloMusica
//
//  Created by Ricardo Lecheta on 7/5/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let sound = SoundUtil()
    let soundRecord = SoundRecordUtil()
    
    var urlGravacao : NSURL!
    
    override init() {
        super.init(nibName: "ViewController", bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func play() {
        // Toca a música thai.mp3
        self.sound.playFile("thai.mp3")
    }
    
    @IBAction func pause() {
        println("pause")
        self.sound.pause()
    }
    
    @IBAction func stop() {
        println("stop")
        self.sound.stop()
    }

    @IBAction func startRecord () {
        println("startRecord")
        // Cria o arquivo para gravar
        self.urlGravacao = self.soundRecord.start("musica.caf")
    }
    
    @IBAction func stopRecord() {
        println("stopRecord")
        // Para a gravação
        self.soundRecord.stop()
    }
    
    @IBAction func playRecord() {
        println("playRecord")
        if(self.urlGravacao != nil) {
            // Toca a música gravada
            self.sound.playUrl(self.urlGravacao)
        }
    }
}

