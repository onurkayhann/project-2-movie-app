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
    var audioPlayer: AVAudioPlayer?
        @Published var isRecording = false
    
    func requestMicrophoneAccess(completion: @escaping (Bool) -> Void) {
            switch AVAudioSession.sharedInstance().recordPermission {
            case .granted:
                completion(true) // Permission already granted
            case .denied:
                completion(false) // Permission denied
            case .undetermined:
                AVAudioSession.sharedInstance().requestRecordPermission { granted in
                    DispatchQueue.main.async {
                        completion(granted)
                    }
                }
            default:
                completion(false) // Handle unexpected cases
            }
        }
    
    func playAudio(url: URL) {
        if FileManager.default.fileExists(atPath: url.path) {
            print("File exists, proceeding to play audio.")
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
                print("Audio is playing successfully.")
            } catch {
                print("Error playing audio: \(error.localizedDescription)")
            }
        } else {
            print("File does not exist at path: \(url.path)")
        }
    }
    
        
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
            print("Recording started at: \(audioFilename.path)") // Log the recording start path
        } catch {
            print("Failed to start recording: \(error.localizedDescription)")
        }
    }
        
    func stopRecording() -> URL? {
        audioRecorder?.stop()
        isRecording = false
        let url = audioRecorder?.url
        print("Audio file saved at: \(url?.path ?? "No URL")") // Log the saved audio URL
        return url
    }
        
        private func getDocumentsDirectory() -> URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
        }
    
    func recordAndPlayAudio() {
        let audioURL = getDocumentsDirectory().appendingPathComponent("audioComment.m4a")
        startRecording()
        // Call stopRecording at some later point, maybe through a button press
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { // Example of stopping after 5 seconds
            if let recordedURL = self.stopRecording() {
                print("Recording stopped, file saved at: \(recordedURL)")
                self.playAudio(url: recordedURL) // Play the recorded audio
            }
        }
    }
    
    
}
