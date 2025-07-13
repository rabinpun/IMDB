//
//  BackButton.swift
//  IMDB
//
//  Created by Rabin Pun on 13/07/2025.
//

import SwiftUI
import FlowStacks

struct BackButton: View {
    
    @EnvironmentObject var navigator: FlowNavigator<AppCoordinator.Screen>
    
    var body: some View {
        Button {
            navigator.goBack()
        } label: {
            Image.chevronLeft
                .foregroundColor(.black)
        }
    }
}

#Preview {
    BackButton()
}
