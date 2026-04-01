//
//  ContentView.swift
//  FocusFixr
//
//  Created by Adriana Luns on 08/03/2026.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var accounts: [AccountData]
    @Query var otherEmails: [EmailAddresses]
    
    @State private var accountDisplayName: String = ""
    
    @State private var Send2Myself: Bool = true
    @State private var Send2Others: Bool = false
    @State private var messageText: String = ""
    
    @FocusState private var isFocused: Bool
        
    var mailConnector: MailConnector = MailConnector()

    private func sendMessage() {
        // clean up, message has been sent
        Task{
            if accounts.first?.accountName == "" {
                _ = Alert(title: Text("Error"), message: Text("No email account configured"), dismissButton: .default(Text("OK")))
            }
            else if messageText.count == 0{
                _ = Alert(title: Text("Error"), message: Text("No message text present"), dismissButton: .default(Text("OK")))
            }
            else {

                await mailConnector.connectSMTP()
                    
                if mailConnector.isSMTPConnected == false  {
                    _ = Alert(title: Text("Error"), message: Text("Could not connect to SMTP server"), dismissButton: .default(Text("OK")))
                } else {
                    let toAddress = accounts.first!.accountName
                    let maxIndex = messageText.count > 60 ? 60 : messageText.count
                    let subject = String(messageText.prefix(maxIndex))
                    let result = await mailConnector.sendSMTPEmail(
                        to: toAddress,
                        recipients: getReciepients(),
                        subject: subject,
                        body: messageText)
                    
                    if result == false {
                        _ = Alert(title: Text("Error"), message: Text("Failied to send email"), dismissButton: .default(Text("OK")))
                    } else {
                        clearMessage()
                    }
                }
            }
        }

    }
    
    private func clearMessage(){
        messageText = ""
    }
    
    private func getReciepients() -> [String] {
        
        let emails = otherEmails.filter({$0.isSelected})
        if emails.count > 0 {
            return emails.map(\.email)
        }
        return []
    }
       
    var body: some View {
            NavigationView {
                ZStack {
                    LinearGradient(
                        gradient: Gradient(
                            colors: [
                                Color(red:0.349, green: 0.552, blue: 0.674, opacity: 1),
                                Color(red:0.941, green: 0.968, blue: 0.976, opacity: 1)
                            ]
                        ),
                        startPoint: .topTrailing,
                        endPoint: .bottomLeading
                    )
                    .edgesIgnoringSafeArea(.all)

                    VStack (alignment: .leading)
                    {
                        // Logo and settings bar
                        HStack{
                            Image("Logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40,height: 40)
                                .foregroundColor(Color.white)
                                
                            
                            Text("FocusFixr")
                                .font(.largeTitle)
                                .bold()
                                .foregroundStyle(Color.black)

                            Spacer()

                            NavigationLink(destination: SettingsView()){
                                Image(systemName: "gear")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color.black)
                                    .padding()
                            }
                        }

                        Toggle("Send to myself",isOn: $Send2Myself)
                            .foregroundStyle(Color.black)

                        
                        if Send2Myself {
                            Text("\t--> \(accounts.first?.accountName ?? "")")
                                .foregroundStyle(Color.black)

                        }
                        
                        Toggle("Send to others",isOn: $Send2Others)
                            .foregroundStyle(Color.black)

                        if Send2Others {
                                List(otherEmails){
                                    otheremail in OtherEmailItem(otheremailItem: otheremail)
                                        .listRowBackground(Color.white)
                                }
                                .listStyle(.inset)
                                .scrollContentBackground(.hidden)
                                .frame(maxWidth: .infinity, maxHeight: 130)
                                
                            NavigationLink(destination: SettingsView()){
                                Text("Add via settings")
                                    .foregroundStyle(Color.black)
                            }
                         
                        }
                        
                        // Actions send & clear
                        HStack{
                            Button{
                                sendMessage()
                                isFocused = false
                            } label: {
                                Text("Send message")
                                    .frame(maxWidth: .infinity)
                            }
                             
                            .disabled( messageText == "")
                            .padding(5)
                            .background(Color(red:0.933, green: 0.929, blue: 0.560).opacity(1))
                            .foregroundColor(Color(red:0, green: 0.121, blue: 0.2039).opacity(1))
                            
                            Button(action: clearMessage){
                                Text("Clear message")
                                    .frame(maxWidth: .infinity)
                            }
                            .padding(5)
                            .background(Color(red:0.933, green: 0.929, blue: 0.560).opacity(1))
                            .foregroundColor(Color(red:0, green: 0.121, blue: 0.2039).opacity(1))

                            
                        }
                        
                        TextEditor(text: $messageText)
                            .scrollContentBackground(.hidden)
                            .foregroundStyle(Color.black)
                            .background(Color.white)
                            .focused($isFocused)
                        
                        FootnoteView()

                    }
                    .padding()

            }
        }
    }
}

struct OtherEmailItem: View {
    var otheremailItem: EmailAddresses
    var body: some View{
        HStack{
            Image(systemName: otheremailItem.isSelected ? "checkmark.square" : "square")
                .background(Color.white)
                .foregroundStyle(Color.black)
            Text(otheremailItem.email)
                .background(Color.white)
                .foregroundStyle(Color.black)
        }
        .onTapGesture{ otheremailItem.isSelected.toggle() }
    }
}

#Preview {
    
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: EmailAddresses.self, configurations: config)
    
    container.mainContext.insert(EmailAddresses(email: "test@test.com", isSelected: true))
    container.mainContext.insert(EmailAddresses(email: "luns@xs4all.nl", isSelected: false))
    container.mainContext.insert(EmailAddresses(email: "adriana.luns@outlook.com", isSelected: false))

    return ContentView().modelContainer(container)
//    NavigationStack{
//        ContentView()
//    }
}
