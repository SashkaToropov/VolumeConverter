//
//  ContentView.swift
//  VolumeConverter
//
//  Created by  Toropov Oleksandr on 12.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State var checkAmount = 0.0
    @State var inputUnit = "mililiters"
    @State var outputUnit = "liters"
    @FocusState var amountIsFocused: Bool
    
    let units = ["mililiters","liters","cups","pints","gallons"]
    
    var convertedMeasurement: Measurement<UnitVolume> {
        Measurement(value: checkAmount, unit: UnitVolume.fromString(inputUnit)).converted(to: UnitVolume.fromString(outputUnit))
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("From:") {
                    TextField("Amount", value: $checkAmount, format: .number)
                        .keyboardType(.numberPad)
                        .focused($amountIsFocused)
                    
                    Picker("Input unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("To:") {
                    Picker("Output unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Result") {
                    Text("\(convertedMeasurement.value.formatted()) \(outputUnit)")
                }
            }
            .navigationTitle("VolumeConverter")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

extension UnitVolume {
    static func fromString(_ unitString: String) -> UnitVolume {
        switch unitString {
        case "mililiters":
            return .milliliters
        case "liters":
            return .liters
        case "cups":
            return .cups
        case "pints":
            return .imperialPints
        case "gallons":
            return .gallons
        default:
            return .milliliters
        }
    }
}

#Preview {
    ContentView()
}
