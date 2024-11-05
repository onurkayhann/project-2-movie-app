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
            completion(true)
        case .denied:
            completion(false)
        case .undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        default:
            completion(false)
        }
    }
    
    func playAudio(url: URL) {
        if FileManager.default.fileExists(atPath: url.path) {
            print("File exists, proceeding to play audio. \(url.path())")
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
                print("Audio is playing successfully.")
            } catch {
                print("Error playing audio: \(error)")
            }
        } else {
            print("File does not exist at path: \(url.path)")
        }
    }
    
    func startRecording() {
        let id = UUID().uuidString
        let audioFilename = getDocumentsDirectory().appendingPathComponent("comment-\(id).m4a")
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.medium.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.record()
            isRecording = true
            print("Recording started at: \(audioFilename.path)")
        } catch {
            print("Failed to start recording: \(error.localizedDescription)")
        }
    }
    
    func stopRecording() -> URL? {
        audioRecorder?.stop()
        isRecording = false
        let url = audioRecorder?.url
        print("Audio file saved at: \(url?.path ?? "No URL")")
        return url
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func recordAndPlayAudio() {
        let audioURL = getDocumentsDirectory().appendingPathComponent("audioComment.m4a")
        startRecording()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            if let recordedURL = self.stopRecording() {
                print("Recording stopped, file saved at: \(recordedURL)")
                self.playAudio(url: recordedURL)
            }
        }
    }
}
