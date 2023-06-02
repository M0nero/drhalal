//
//  ScannerView.swift
//  halal
//
//  Created by Damir Akbarov on 17.05.2023.
//

import SwiftUI
import AVKit

struct ScannerView<ProductModifier: ViewModifier>: View {
    // MARK: - Properties
    @ObservedObject var viewModel: ScannerViewModel
    
    @State private var session: AVCaptureSession = AVCaptureSession()
    @State private var barcodeOutput: AVCaptureMetadataOutput = .init()
    private let sessionQueue = DispatchQueue(label: "sessionQueue")
    let productModifier: ProductModifier
    
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Наведите камеру на штрихкод")
                .font(.title3)
                .foregroundColor(.black.opacity(0.8))
                .padding(.top, 20)
            Text("Сканирование начнется автоматически")
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
                        .shadow(color: .black.opacity(0.8), radius: 8, x: 0, y: viewModel.isScanning ? 15 : -15)
                        .offset(y: viewModel.isScanning ? size.width : 0)
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .padding(.horizontal, 45)
            Spacer(minLength: 15)
            
            Button {
                if !session.isRunning && viewModel.cameraPermission == .approved {
                    reactivateCamera()
                    activateScannerAnimation()
                } else {
                    sessionQueue.async {
                        session.stopRunning()
                        deActivateScannerAnimation()
                    }
                }
            } label: {
                Image(systemName: "qrcode.viewfinder")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
            }
            
            Spacer(minLength: 45)
        }
        .padding(15)
        .modifier(productModifier)
        .onAppear(perform: checkCameraPermission)
        .alert(viewModel.errorMessage, isPresented: $viewModel.showError) {
            if viewModel.cameraPermission == .denied {
                Button("Settings") {
                    let settings = UIApplication.openSettingsURLString
                    if let settingsURL = URL(string: settings) {
                        openURL(settingsURL)
                    }
                }
                
                Button("Cancel", role: .cancel) { }
            }
        }
        .onChange(of: viewModel.scanDelegate.scannedCode) { newValue in
            if let code = newValue {
                session.stopRunning()
                deActivateScannerAnimation()
            }
        }
    }
    
    func activateScannerAnimation() {
        DispatchQueue.main.async {
            withAnimation(.easeOut(duration: 0.85).delay(0.1).repeatForever(autoreverses: true)) {
                viewModel.isScanning = true
            }
        }
    }
    
    func reactivateCamera() {
        sessionQueue.async {
            session.startRunning()
        }
    }
    
    func deActivateScannerAnimation() {
        DispatchQueue.main.async {
            withAnimation(.easeOut(duration: 0.85)) {
                viewModel.isScanning = false
            }
        }
    }
    
    func checkCameraPermission() {
        Task {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                viewModel.cameraPermission = .approved
                if session.inputs.isEmpty {
                    setupCamera()
                } else {
                    reactivateCamera()
                }
            case .notDetermined:
                /// Requesting Camera Access
                if await AVCaptureDevice.requestAccess(for: .video) {
                    /// Permission Granted
                    viewModel.cameraPermission = .approved
                    setupCamera()
                } else {
                    /// Permission Denied
                    viewModel.cameraPermission = .denied
                }
            case .denied, .restricted:
                viewModel.cameraPermission = .denied
                viewModel.presentError("Please provide access to Camera for scanning codes")
            default: break
            }
        }
    }
    
    func setupCamera() {
        sessionQueue.async {
            do {
                // Finding Back Camera
                guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera],
                                                                    mediaType: .video,
                                                                    position: .back).devices.first else {
                    viewModel.presentError("UNKNOWN DEVICE ERROR")
                    return
                }
                //        Camera Input
                let input = try AVCaptureDeviceInput(device: device)
                
                guard session.canAddInput(input), session.canAddOutput(barcodeOutput) else {
                    viewModel.presentError("UNKNOWN INPUT ERROR")
                    return
                }
                
                session.beginConfiguration()
                session.addInput(input)
                session.addOutput(barcodeOutput)
                barcodeOutput.metadataObjectTypes = [.ean8, .ean13]
                barcodeOutput.setMetadataObjectsDelegate(viewModel.scanDelegate, queue: DispatchQueue(label: "metadataObjectsQueue"))
                session.commitConfiguration()
                
                session.startRunning()
                activateScannerAnimation()
            } catch {
                viewModel.presentError(error.localizedDescription)
            }
        }
    }
}
