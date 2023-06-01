//
//  ScannerView.swift
//  halal
//
//  Created by Damir Akbarov on 17.05.2023.
//

import SwiftUI
import AVKit

struct ScannerView: View {
    // MARK: - Properties
    @State private var isScanning: Bool = false
    @State private var session: AVCaptureSession = .init()
    @State private var cameraPermission: Permission = .idle
    @State private var barcodeOutput: AVCaptureMetadataOutput = .init()
    @State private var scannedCode: String = ""
    
    // MARK: - Error properties
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    
    @Environment(\.openURL) private var openURL
    @State private var scanDelegate = ScannerDelegate()
    
    var body: some View {
        VStack(spacing: 8) {
            Button {
            } label: {
                Image(systemName: "xmark")
                    .font(.title3)
                    .foregroundColor(.green)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Place the Barcode code inside the area")
                .font(.title3)
                .foregroundColor(.black.opacity(0.8))
                .padding(.top, 20)
            Text("Scanning will start automatically")
                .font(.callout)
                .foregroundColor(.gray)
            
            Spacer(minLength: 0)
            
            // Scanner
            GeometryReader {
                let size = $0.size
                ZStack {
                    CameraView(frameSize: CGSize(width: size.width, height: size.width), session: $session)
                        .scaleEffect(0.97)
                    
                    ForEach(0...4, id: \.self) { index in
                        let rotation = Double(index) * 90
                        RoundedRectangle(cornerRadius: 2, style: .circular)
                            .trim(from: 0.61, to: 0.64)
                            .stroke(Color.green, style: StrokeStyle(lineWidth: 5,
                                                       lineCap: .round,
                                                       lineJoin: .round))
                            .rotationEffect(.init(degrees: rotation))
                    }
                }
                .frame(width: size.width, height: size.width)
                .overlay(alignment: .top, content: {
                    Rectangle()
                        .fill(Color.green)
                        .frame(height: 2.5)
                        .shadow(color: .black.opacity(0.8), radius: 8, x: 0, y: isScanning ? 15 : -15)
                        .offset(y: isScanning ? size.width : 0)
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .padding(.horizontal, 45)
            Spacer(minLength: 15)
            
            Button {
                if !session.isRunning && cameraPermission == .approved {
                    reactivateCamera()
                    activateScannerAnimation()
                }
            } label: {
                Image(systemName: "qrcode.viewfinder")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
            }
            
            Spacer(minLength: 45)
        }
        .padding(15)
        .onAppear(perform: checkCameraPermission)
        .alert(errorMessage, isPresented: $showError) {
            if cameraPermission == .denied {
                Button("Settings") {
                    let settings = UIApplication.openSettingsURLString
                    if let settingsURL = URL(string: settings) {
                        openURL(settingsURL)
                    }
                }
                
                Button("Cancel", role: .cancel) {
                    
                }
            }
        }
        .onChange(of: scanDelegate.scannedCode) { newValue in
            if let code = newValue {
                scannedCode = code
                DispatchQueue.global(qos: .background).async {
                    session.stopRunning()
                }
                deActivateScannerAnimation()
                presentError("Barcode found: " + "\(code)")
                scanDelegate.scannedCode = nil
            }
        }
    }
    
    func activateScannerAnimation() {
        withAnimation(.easeOut(duration: 0.85).delay(0.1).repeatForever(autoreverses: true)) {
            isScanning = true
        }
    }
    
    func reactivateCamera() {
        DispatchQueue.global(qos: .background).async {
            session.startRunning()
        }
    }
    
    func deActivateScannerAnimation() {
        withAnimation(.easeOut(duration: 0.85)) {
            isScanning = false
        }
    }
    
    func checkCameraPermission() {
        Task {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                cameraPermission = .approved
                if session.inputs.isEmpty {
                    setupCamera()
                } else {
                    session.startRunning()
                }
            case .notDetermined:
                /// Requesting Camera Access
                if await AVCaptureDevice.requestAccess(for: .video) {
                    /// Permission Granted
                    cameraPermission = .approved
                    setupCamera()
                } else {
                    /// Permission Denied
                    cameraPermission = .denied
                }
            case .denied, .restricted:
                cameraPermission = .denied
                presentError("Please provide access to Camera for scanning codes")
            default: break
            }
        }
    }
    
    func presentError(_ message: String) {
        errorMessage = message
        showError.toggle()
    }
    
    func setupCamera() {
        do {
            // Finding Back Camera
            guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera],
                                                                mediaType: .video,
                                                                position: .back).devices.first else {
                presentError("UNKNOWN DEVICE ERROR")
                return
            }
            //        Camera Input
            let input = try AVCaptureDeviceInput(device: device)
            //            For Extra Saftey Checking Whether input & output can be added to the session
            guard session.canAddInput(input), session.canAddOutput(barcodeOutput) else { presentError("UNKNOWN INPUT ERROR")
                return
            }
            
            session.beginConfiguration()
            session.addInput(input)
            session.addOutput(barcodeOutput)
            barcodeOutput.metadataObjectTypes = [.ean8, .ean13]
            barcodeOutput.setMetadataObjectsDelegate(scanDelegate, queue: .main)
            session.commitConfiguration()
            DispatchQueue.global(qos: .background).async {
                session.stopRunning()
            }
            activateScannerAnimation()
        } catch {
            presentError(error.localizedDescription)
        }
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
