//
//  SoundRecordUtil.swift
//  HelloMusica
//
//  Created by Ricardo Lecheta on 7/5/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import Foundation
import AVFoundation

class SoundRecordUtil : NSObject, AVAudioRecorderDelegate {
    
    var soundRecorder :AVAudioRecorder?

    // Inicia e para gravação
    func start(file: String) -> NSURL! {
        
        let audioSession = AVAudioSession.sharedInstance()
        
        var error : NSError?
        
        // Inicia a sessão
        audioSession.setActive(true, error: &error)
        
        if (error != nil) {
            println("Error \(error)")
            return nil
        }
        
        // Cria a gravação do som no arquivo especificado
        audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, error: &error)
        
        if (error != nil) {
            println("Error \(error)")
            return nil
        }

        // Cria a URL com o caminho do arquivo para gravação
        var path = NSTemporaryDirectory() + "/" + file
        println("Gravar file: \(path)")
        let url = NSURL(string: path)

        // Cria a gravação do som no arquivo especificado
        self.soundRecorder = AVAudioRecorder(URL: url, settings: nil, error: &error)
        self.soundRecorder!.delegate = self
        
        if (error != nil) {
            println("Error \(error)")
            return nil
        }
        
        // Inicia a gravação
        self.soundRecorder!.prepareToRecord()
        self.soundRecorder!.record()
        
        return url
    }
    
    func stop() {
        // Para a gravação
        self.soundRecorder!.stop()
        let audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    
    // Fim da gravação
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        println("Fim da gravação, sucesso \(flag)")
    }
}