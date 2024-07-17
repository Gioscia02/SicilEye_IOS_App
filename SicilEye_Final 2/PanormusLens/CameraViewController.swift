// Camera view controller da copiare

import UIKit
import AVFoundation
import Vision
import CoreML

class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    /*
    private let identifierLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    */
    
    
    var classificationResult: ClassificationResult?
    
    private let model: VNCoreMLModel = {
        do {
            let config = MLModelConfiguration()
            let model = try Teatri(configuration: config)
            return try VNCoreMLModel(for: model.model)
        } catch {
            fatalError("Couldn't create VNCoreMLModel: \(error)")
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCamera()
        //setupIdentifierLabel()
    }
    
    private func setupCamera() {
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let captureDevice = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        
        captureSession.addInput(input)
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        previewLayer.videoGravity = .resizeAspectFill
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
    }
    
    /*
    private func setupIdentifierLabel() {
        view.addSubview(identifierLabel)
        identifierLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        identifierLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        identifierLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        identifierLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    */
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        let request = VNCoreMLRequest(model: model) { [weak self] (finishedReq, err) in
            if let err = err {
                print("Failed to perform classification: \(err.localizedDescription)")
                return
            }
            
            guard let results = finishedReq.results as? [VNClassificationObservation],
                  let firstObservation = results.first else {
                return
            }
            
            DispatchQueue.main.async {
                //self?.identifierLabel.text = "\(firstObservation.identifier) \(firstObservation.confidence * 100)"
                
                self?.classificationResult?.identifier = firstObservation.identifier
                self?.classificationResult?.confidence = firstObservation.confidence
                
                print("\(firstObservation.identifier) \(firstObservation.confidence * 100)")
            }
        }
        
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
}
