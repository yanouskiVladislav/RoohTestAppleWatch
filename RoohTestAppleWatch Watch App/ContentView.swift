import SwiftUI

enum CharacterAttribute: String, CaseIterable, Identifiable{
    case age = "Age"
    case height = "Height"
    case weight = "Weight"
    var id: String { self.rawValue }
}

struct ContentView: View {
    @State private var selectedAttribute: CharacterAttribute = .age
    @State private var selectedAge: Int = 0
    @State private var selectedHeight: Int = 0
    @State private var selectedWeight: Int = 0
    @State private var showingPicker = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                avatarImage
                attributeText("Age", value: $selectedAge, attribute: .age)
                attributeText("Height", value: $selectedHeight, attribute: .height)
                attributeText("Weight", value: $selectedWeight, attribute: .weight)
            }
            .padding(.horizontal, 5)
        }
        .sheet(isPresented: $showingPicker) {
            AttributePickerView(selectedAttribute: $selectedAttribute, selectedAge: $selectedAge, selectedHeight: $selectedHeight, selectedWeight: $selectedWeight, showingPicker: $showingPicker)
        }
        
    }
    
    private var avatarImage: some View {
        Image("avatar-1")
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
            .frame(width: 50, height: 50)
    }
    
    private func attributeText(_ label: String, value: Binding<Int>, attribute: CharacterAttribute) -> some View {
        Text("\(label): \(value.wrappedValue)")
            .padding(.leading, 5)
            .padding(.top, 5)
            .font(.system(size: 20))
            .onTapGesture {
                selectedAttribute = attribute
                showingPicker = true
            }
    }
}

struct AttributePickerView: View {
    @Binding var selectedAttribute: CharacterAttribute
    @Binding var selectedAge: Int
    @Binding var selectedHeight: Int
    @Binding var selectedWeight: Int
    @Binding var showingPicker: Bool
    
    var body: some View {
        VStack {
            Text("Select a \(selectedAttribute.rawValue.lowercased())")
            Picker("", selection: binding(for: selectedAttribute)) {
                ForEach(0..<101) {
                    Text("\($0)").tag($0)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 150, height: 100)
            .clipped()
            Button("Done") {
                showingPicker = false
            }
        }
        .padding()
    }
    
    private func binding(for attribute: CharacterAttribute) -> Binding<Int> {
        switch attribute {
        case .age:
            return $selectedAge
        case .height:
            return $selectedHeight
        case .weight:
            return $selectedWeight
        }
    }
}
