//
//  View.swift
//  IMDB
//
//  Created by Rabin Pun on 12/07/2025.
//

import SwiftUI

extension View {
    
    func errorAlert<E: Error>(error: Binding<E?>, buttonTitle: String = "Ok") -> some View where E: LocalizedError {
        return alert("IMDB", isPresented: .constant(error.wrappedValue != nil)) {
            Button(buttonTitle) {
                error.wrappedValue = nil
            }
        } message: {
            Text(error.wrappedValue?.localizedDescription ?? "Something went wrong.")
        }

    }
}
