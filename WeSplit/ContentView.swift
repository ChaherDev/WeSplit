//
//  ContentView.swift
//  WeSplit
//
//  Created by Chaher Machhour on 23/09/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var total: Double {
        checkAmount + checkAmount / 100 * Double(tipPercentage)
    }
    
    var body: some View {
        VStack {
            NavigationStack {
                Form {
                    Section {
                        TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                        
                        Picker("Number of people", selection: $numberOfPeople) {
                            ForEach(2..<100) {
                                Text("\($0) people")
                            }
                        }
                        // .pickerStyle(.navigationLink)
                    }
                    
                    Section("How much do you want to tip?") {
                        Picker("Tip percentage", selection: $tipPercentage) {
                            ForEach(0 ..< 101) {
                                Text($0, format: .percent)
                            }
                        }
                        .pickerStyle(.navigationLink)
                    }
                    
                    Section("Amount per person") {
                        Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                    
                    Section("Total amount") {
                        Text(total, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .foregroundStyle(tipPercentage == 0 ? .red : .primary)
                    }
                }
                .navigationTitle("WeSplit")
                .toolbar {
                    if amountIsFocused {
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
