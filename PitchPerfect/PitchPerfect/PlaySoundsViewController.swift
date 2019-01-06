//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Leonardo Oliva Kraciunas on 06/01/19.
//  Copyright © 2019 Leonardo Oliva Kraciunas. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    // MARK: - TODO
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    // MARK: - TODO
    enum ButtonType: Int {
        case slow = 0, fast, high, low, echo, reverb
    }
    
    // MARK: - Superclass override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtons()
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    // MARK: - Método que corrige o tamanho das imagens dos botões em diferentes resoluções
    func fixImageSize(button : UIButton ) {
        button.contentMode = .center
        button.imageView?.contentMode = .scaleAspectFit
    }
    
    func setupButtons() {
        let buttons = [slowButton, fastButton, highPitchButton, lowPitchButton, echoButton, reverbButton, stopButton]
        for button in buttons {
            if let button = button {
                fixImageSize(button: button)
            }
        }
    }
    
    // MARK: - IBActions
    
    // MARK: Método que toca o audio de acordo com a caracteristica do botão
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch ButtonType(rawValue: sender.tag)! {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .high:
            playSound(pitch: 1000)
        case .low:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    // MARK: Método que para o audio que está sendo tocado
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        stopAudio()
    }
}
