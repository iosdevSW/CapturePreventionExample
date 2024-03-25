//
//  PreventCapture+View.swift
//  CaptureProtectionExample
//
//  Created by iOS신상우 on 3/25/24.
//

import SwiftUI

struct _CapturePreventView<Content: View>: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = PreventCaptureHostingViewController<Content>
    
    private var isPrevented: Bool
    private let content: () -> Content
    
    init(isPrevented: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.isPrevented = isPrevented
        self.content = content
    }
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        PreventCaptureHostingViewController(isPrevented: isPrevented, content: content)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        uiViewController.isPrevented = isPrevented
    }
}

public struct CapturePrevent<Content: View>: View {
    
    private var isPrevented: Bool
    private let content: () -> Content
    
    public init(isPrevented: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.isPrevented = isPrevented
        self.content = content
    }
    
    public var body: some View {
        _CapturePreventView(isPrevented: isPrevented) {
            content()
        }
    }
}
