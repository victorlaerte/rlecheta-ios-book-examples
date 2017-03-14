//
//  ViewController.swift
//  HelloAcelerometro
//
//  Created by Ricardo Lecheta on 7/14/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var motionManager = CMMotionManager()
    
    // Acelerômetro
    @IBOutlet var labelX: UILabel!
    @IBOutlet var labelY: UILabel!
    @IBOutlet var labelZ: UILabel!
    
    @IBOutlet var progressX: UIProgressView!
    @IBOutlet var progressY: UIProgressView!
    @IBOutlet var progressZ: UIProgressView!
    
    // Gyro
    @IBOutlet var labelX2: UILabel!
    @IBOutlet var labelY2: UILabel!
    @IBOutlet var labelZ2: UILabel!
    
    @IBOutlet var progressX2: UIProgressView!
    @IBOutlet var progressY2: UIProgressView!
    @IBOutlet var progressZ2: UIProgressView!
    
    override init() {
        super.init(nibName: "ViewController", bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fila
        let queue = NSOperationQueue()
        
        // Acelerômetro
        if(motionManager.accelerometerAvailable) {
            
            // closure do handler para receber resposta do acelerômetro
            let handler = { (data: CMAccelerometerData!, error: NSError!) -> Void in
                println(data.acceleration.x)
                
                // A interface precisa ser atualizada pela thread de UI
                dispatch_async(dispatch_get_main_queue(), {
                    self.updateAcelerometro(data)
                })
            }
            // Tempo para receber updates (em segundos)
            motionManager.accelerometerUpdateInterval = 0.1
            
            // Inicia
            motionManager.startAccelerometerUpdatesToQueue(queue, withHandler: handler )
            
            // Inicia
            //            motionManager.startAccelerometerUpdatesToQueue(queue, withHandler:
            //                {
            //                    (data: CMAccelerometerData!, error: NSError!) -> Void in
            //                    let x = data.acceleration.x
            //                    let y = data.acceleration.y
            //                    let z = data.acceleration.z
            //                })
            
        } else {
            println("Sensor de acelerômetro não disponível.")
        }
        
        // Giroscópio
        if(motionManager.gyroAvailable) {
            
            // closure do handler para receber resposta do acelerômetro
            let handler = { (data: CMGyroData!, error: NSError!) -> Void in
                println(data.rotationRate.x)
                
                // A interface precisa ser atualizada pela thread de UI
                dispatch_async(dispatch_get_main_queue(), {
                    self.updateGyro(data)
                })
            }
            
            // Tempo para receber updates (em segundos)
            motionManager.gyroUpdateInterval = 0.1
            
            motionManager.startGyroUpdatesToQueue(queue, withHandler: handler )
        } else {
            println("Sensor de giroscópio não disponível.")
        }
    }
    
    override func didReceiveMemoryWarning() {
        println("didReceiveMemoryWarning")
        
        // Para o acelerômetro
        motionManager.stopAccelerometerUpdates()
        motionManager.stopGyroUpdates()
    }
    
    deinit {
        // Para o acelerômetro
        motionManager.stopAccelerometerUpdates()
        motionManager.stopGyroUpdates()
    }
    
    func updateAcelerometro(data: CMAccelerometerData) {
        
        labelX.text = NSString(format: "X: %.2f", data.acceleration.x)
        labelY.text = NSString(format: "Y: %.2f", data.acceleration.y)
        labelZ.text = NSString(format: "Z: %.2f", data.acceleration.z)
        
        progressX.progress = Float(round(data.acceleration.x));
        progressY.progress = Float(round(data.acceleration.y));
        progressZ.progress = Float(round(data.acceleration.z));
    }
    
    func updateGyro(data: CMGyroData) {
        
        labelX2.text = NSString(format: "X: %.2f", data.rotationRate.x);
        labelY2.text = NSString(format: "Y: %.2f", data.rotationRate.y);
        labelZ2.text = NSString(format: "Z: %.2f", data.rotationRate.z);
        
        progressX2.progress = Float(round(data.rotationRate.x));
        progressY2.progress = Float(round(data.rotationRate.y));
        progressZ2.progress = Float(round(data.rotationRate.z));
    }
    
    override func shouldAutorotate() -> Bool  {
        return false
    }
}

