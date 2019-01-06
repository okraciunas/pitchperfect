//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Leonardo Oliva Kraciunas on 06/01/19.
//  Copyright © 2019 Leonardo Oliva Kraciunas. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecord: AVAudioRecorder!
    
    // MARK: - IBOutlets
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI(state: .read)
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        configureUI(state: .recording)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let filePath = URL(string: "\(dirPath)/\(recordingName)")
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
        
        try! audioRecord = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecord.delegate = self
        audioRecord.isMeteringEnabled = true
        audioRecord.prepareToRecord()
        audioRecord.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        configureUI(state: .read)
        audioRecord.stop()
        
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
    }
    
    func configureUI(state: RecordState) {
        switch state {
        case .read:
            recordLabel.text = RecordStateMessage.Read
            recordButton.isEnabled = true
            stopRecordButton.isEnabled = false
            
        case .recording:
            recordLabel.text = RecordStateMessage.Recording
            recordButton.isEnabled = false
            stopRecordButton.isEnabled = true
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag  {
            performSegue(withIdentifier: StoryboardSegue.RecordSoundsToPlaySounds , sender: audioRecord.url)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryboardSegue.RecordSoundsToPlaySounds {
            let playSoundViewController = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundViewController.recordedAudioURL = recordedAudioURL
        }
    }
}
