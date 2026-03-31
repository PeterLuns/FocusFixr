//
//  OtherEmailsView.swift
//  FocusFixr
//
//  Created by Adriana Luns on 17/03/2026.
//

import SwiftUI
import SwiftData

struct OtherEmailsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var otherEmails: [EmailAddresses]
    
    @State private var otherEmailAddress: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Text("Other e-mail adresses")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(Color.black)
            TextField("",text: $otherEmailAddress,prompt: Text("e-mail address").foregroundStyle(Color.gray))
                .background(RoundedRectangle(cornerRadius: 3).fill(Color.white))
                .foregroundStyle(Color.black)
                .keyboardType(.emailAddress)
            
            Button("Add"){
                addItem()
            }
            .padding(5)
            .frame(maxWidth: .infinity)
            .background(Color(red:0.933, green: 0.929, blue: 0.560).opacity(1))
            .foregroundColor(Color(red:0, green: 0.121, blue: 0.2039).opacity(1))

            
            List {
                ForEach(otherEmails){
                    otherEmail in VStack(alignment: .leading){
                        Text(otherEmail.email)
                            .background(RoundedRectangle(cornerRadius: 3).fill( Color.white))
                            .foregroundStyle(Color.black)
                    }
                    .listRowBackground(Color.white)
                }
                .onDelete(perform: deleteEmailAddress)
            }
            .listStyle(.inset)
            .scrollContentBackground(.hidden)



        }
        .padding()
    }
        
    private func addItem(){
        let newEmail = EmailAddresses(email: otherEmailAddress, isSelected: false)
        modelContext.insert(newEmail)
        otherEmailAddress = ""
    }
    
    private func deleteEmailAddress(at offsets: IndexSet){
        for index in offsets{
            modelContext.delete(otherEmails[index])
        }
    }
    
}

#Preview {
    OtherEmailsView()
}
