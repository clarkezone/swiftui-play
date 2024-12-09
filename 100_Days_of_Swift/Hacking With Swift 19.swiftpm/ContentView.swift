import SwiftUI

struct ContentView: View {
    @State var fromAmount: String = "0"
    @State var sourceFormat: Int = 1
    @State var destFormat: Int = 2
    var body: some View {
        Form {
            Section("From") {
                Picker(selection: $sourceFormat, label: Text("Unit From")) {
                    Text("Farenheit").tag(1)
                    Text("Celcius").tag(2)
                }
                .pickerStyle(.segmented)
            }

            Section("To") {
                Picker(selection: $destFormat, label: Text("Unit From")) {
                    Text("Farenheit").tag(1)
                    Text("Celcius").tag(2)
                }            
                .pickerStyle(.segmented)
            }

            Section("Amounct") {
                TextField("Enter amount", value: $fromAmount, format: .number)
                    .padding()
            }
            

        }
    }
}
