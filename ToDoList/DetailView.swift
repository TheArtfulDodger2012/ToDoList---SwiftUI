//
//  DetailView.swift
//  ToDoList
//
//  Created by Ron Lane on 4/4/24.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) private var dismiss
    var passedValue: String

    var body: some View {
        VStack {
            Image(systemName: "swift")
                .resizable()
                .scaledToFit()
                .foregroundColor(.orange)
            
            Text("You Are a Swifty Legend! \nAnd you passed over the value \(passedValue)")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Button("Get Back!") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    DetailView(passedValue: "Item 1")
}
