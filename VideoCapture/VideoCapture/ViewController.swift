//
//  ViewController.swift
//  VideoCapture
//
//  Created by 买明 on 26/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    fileprivate lazy var videoQueue = DispatchQueue.global()
    fileprivate lazy var audioQueue = DispatchQueue.global()
    
    fileprivate lazy var session = AVCaptureSession()
    fileprivate lazy var previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
    
    fileprivate var videoOutput: AVCaptureVideoDataOutput?
    fileprivate var videoInput: AVCaptureDeviceInput?
    fileprivate var movieOutput: AVCaptureMovieFileOutput?
    
}

extension ViewController {
    @IBAction func startCapture(_ sender: UIButton) {
        setupVideo()
        setupAudio()
        
        let movieOutput = AVCaptureMovieFileOutput()
        session.addOutput(movieOutput)
        self.movieOutput = movieOutput
        
        let connection = movieOutput.connection(withMediaType: AVMediaTypeVideo)
        connection?.preferredVideoStabilizationMode = .auto
        
        previewLayer.frame = view.bounds
        view.layer.insertSublayer(previewLayer, at: 0)
        
        session.startRunning()
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/a.mp4"
        print(path)
        let url = URL(fileURLWithPath: path)
        movieOutput.startRecording(toOutputFileURL: url, recordingDelegate: self)
    }
    
    @IBAction func endCapture(_ sender: UIButton) {
        movieOutput?.stopRecording()
        session.stopRunning()
        previewLayer.removeFromSuperlayer()
    }
    
    @IBAction func switchCamera(_ sender: UIButton) {
        guard var position = videoInput?.device.position else { return }
        
        position = position == .front ? .back : .front
        
        guard let devices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as? [AVCaptureDevice] else {
            print("摄像头不可用")
            return
        }
        
        guard let device = devices.filter({ $0.position == position }).first else { return }
        
        guard let videoInput = try? AVCaptureDeviceInput(device: device) else { return }
        
        session.beginConfiguration()
        session.removeInput(self.videoInput)
        session.addInput(videoInput)
        session.commitConfiguration()
        
        self.videoInput = videoInput

    }
}

extension ViewController {
    fileprivate func setupVideo() {
        guard let devices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as? [AVCaptureDevice] else {
            print("摄像头不可用")
            return
        }
        
        guard let device = devices.filter({ $0.position == .front }).first else { return }
        guard let videoInput = try? AVCaptureDeviceInput(device: device) else { return }
        self.videoInput = videoInput
        
        session.addInput(videoInput)
        
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: videoQueue)
        
        session.addOutput(videoOutput)
        
        self.videoOutput = videoOutput
//        connection = videoOutput.connection(withMediaType: AVMediaTypeVideo)
    }
    fileprivate func setupAudio() {
        guard let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio) else { return }
        guard let audioInput = try? AVCaptureDeviceInput(device: device) else { return }
        
        session.addInput(audioInput)
        
        let audioOutput = AVCaptureAudioDataOutput()
        audioOutput.setSampleBufferDelegate(self, queue: audioQueue)
        
        session.addOutput(audioOutput)
        
//        connection = audioOutput.connection(withMediaType: AVMediaTypeAudio)
    }
}

extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate,
                          AVCaptureAudioDataOutputSampleBufferDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        if connection == videoOutput?.connection(withMediaType: AVMediaTypeVideo) {
            print("Video")
        } else {
            print("Audio")
        }
    }
}

extension ViewController: AVCaptureFileOutputRecordingDelegate {
    func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {
        print("开始")
    }
    
    func capture(_ captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [Any]!, error: Error!) {
        print("结束")
    }
}
