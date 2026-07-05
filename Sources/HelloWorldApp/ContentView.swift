import SwiftUI

struct ContentView: View {
    @State private var text = "Hello, World!"

    var body: some View {
        VStack(spacing: 20) {
            Text(text)
                .font(.title)
            Button("Нажми меня") {
                text = "Привет!"
            }
        }
        .padding()
        .frame(width: 400, height: 300)
    }
}
