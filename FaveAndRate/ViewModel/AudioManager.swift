//
//  AudioManage.swift
//  FaveAndRate
//
//  Created by Hampus Andersson on 2024-11-04.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import AVFoundation

class AudioManager: ObservableObject {
    
    private var audioRecorder: AVAudioRecorder?
        @Published var isRecording = false
        
        func startRecording() {
            let audioFilename = getDocumentsDirectory().appendingPathComponent("audioComment.m4a")
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            do {
                audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
                audioRecorder?.record()
                isRecording = true
            } catch {
                print("Failed to start recording: \(error.localizedDescription)")
            }
        }
        
        func stopRecording() -> URL? {
            audioRecorder?.stop()
            isRecording = false
            return audioRecorder?.url
        }
        
        private func getDocumentsDirectory() -> URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
        }
    
    
    
    
}
