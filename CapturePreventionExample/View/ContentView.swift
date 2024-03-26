//
//  ContentView.swift
//  CaptureProtectionExample
//
//  Created by iOS신상우 on 3/25/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("Capture Prevention Label")
                .capturePrevented(isPrevented: true)
                .frame(height: 40)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
