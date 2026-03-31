//
//  AccountDetailsView.swift
//  FocusFixr
//
//  Created by Adriana Luns on 11/03/2026.
//

import SwiftUI
import SwiftData

struct AccountDetailsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @Query private var accounts: [AccountData]
    
    @State private var accountName: String = ""

    private func loadAccountData() {
        guard let accountData = accounts.first else { return }
        
        accountName = accountData.accountName

    }
    
    private func saveOrUpdateAccountData() {
        if let accountData = accounts.first {
            accountData.accountName = accountName.lowercased(with: .current)

        } else {
            let newAccountData = AccountData(accountName: accountName.lowercased(with: .current))
            
            modelContext.insert(newAccountData)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Account")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(Color.black)
            
            TextField( "", text: $accountName, prompt: Text("e-mail address").foregroundStyle(Color.gray))
                .background(RoundedRectangle(cornerRadius: 3).fill(Color.white))
                .keyboardType(.emailAddress)
                .foregroundColor(.black)
            
            Button("Save"){
                saveOrUpdateAccountData()
                dismiss()
            }
            .padding(5)
            .frame(maxWidth: .infinity)
            .background(Color(red:0.933, green: 0.929, blue: 0.560).opacity(1))
            .foregroundColor(Color(red:0, green: 0.121, blue: 0.2039).opacity(1))
            
        }
        .padding()
        .onAppear {
            loadAccountData()
        }
                  
    }

}

#Preview {
    AccountDetailsView()
}
