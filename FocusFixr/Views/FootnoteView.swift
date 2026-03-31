//
//  FootnoteView.swift
//  FocusFixr
//
//  Created by Adriana Luns on 18/03/2026.
//

import SwiftUI

struct FootnoteView: View {
    var body: some View {
        Text("Created for Adriana Luns by PSoftware \u{00A9}")
            .font(.footnote)
            .frame(maxWidth: .infinity, alignment: .bottom)
            .foregroundStyle(Color(.black))

    }
}

#Preview {
    FootnoteView()
}
