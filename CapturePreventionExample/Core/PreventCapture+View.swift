//
//  PreventCapture+View.swift
//  CaptureProtectionExample
//
//  Created by iOS신상우 on 3/25/24.
//

import SwiftUI

struct _CapturePreventView<Content: View>: UIViewRepresentable {

    typealias UIViewType = CapturePreventingView
    
    private var isPrevented: Bool
    private let content: () -> Content
    
    init(isPrevented: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.isPrevented = isPrevented
        self.content = content
    }
    
    func makeUIView(context: Context) -> CapturePreventingView {
        let hostingVC = UIHostingController(rootView: content())
        return CapturePreventingView(isPrevented: isPrevented, contentView: hostingVC.view)
    }
    
    func updateUIView(_ uiView: CapturePreventingView, context: Context) {
        uiView.preventCapture = isPrevented
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
