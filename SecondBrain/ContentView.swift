//
//  ContentView.swift
//  SecondBrain
//
//  Created by SOOPIN KIM on 2024-08-31.
//

import SwiftUI

struct ContentView: View {
    @State private var message = ""
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("fetchData") {
                fetchData()
                print("message : ", message)
            }
        }
        .padding()
    }
    
    func fetchData() {
        guard let url = URL(string: "http://localhost:3000/api/data") else { return }
        print("here")
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let json = try? JSONSerialization.jsonObject(with: data, options: []),
                   let dict = json as? [String: String] {
                    DispatchQueue.main.async {
                        self.message = dict["message"] ?? "No message"
                    }
                }
            }
        }.resume()
    }
}

#Preview {
    ContentView()
}
