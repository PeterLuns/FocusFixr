//
//  IMAPConnector.swift
//  RemindMe
//
//  Created by Adriana Luns on 18/03/2026.
//

import SwiftMail
import Foundation
import SwiftUI


class MailConnector {
    
    var smtpServer: SMTPServer? = nil
    var imapServer: IMAPServer? = nil
    
    var smtpHost: String
    var smtpPort: String
    var smtpUser: String
    var smtpPWD: String
    
    var imapHost: String
    var imapPort: String
    var imapUser: String
    var imapPWD: String
    
    var isSMTPConnected: Bool = false
    var isIMAPConnected: Bool = false

    init(){
               
        smtpHost = ProcessInfo.processInfo.environment["SMTP_HOST"] ?? "mail.mijndomein.nl"
        smtpPort = ProcessInfo.processInfo.environment["SMTP_PORT"] ?? "587"
        smtpUser = ProcessInfo.processInfo.environment["SMTP_USERNAME"] ?? "info@adrianaluns.nl"
        smtpPWD = ProcessInfo.processInfo.environment["SMTP_PASSWORD"] ?? "Ibbamnb@2022!!"
        
        imapHost = ProcessInfo.processInfo.environment["IMAP_HOST"] ?? ""
        imapPort = ProcessInfo.processInfo.environment["IMAP_PORT"] ?? ""
        imapUser = ProcessInfo.processInfo.environment["IMAP_USERNAME"] ?? ""
        imapPWD = ProcessInfo.processInfo.environment["IMAP_PASSWORD"] ?? ""
        
    }
    
    func setSMTPParams( smtpHost: String, smtpPort: Int, smtpUser: String, smtpPWD: String){
        self.smtpHost = smtpHost
        self.smtpPort = String(smtpPort)
        self.smtpPWD = smtpPWD
        self.smtpUser = smtpUser
    }

    func setIMAPParams( imapHost: String, imapPort: Int, imapUser: String, imapPWD: String){
        self.imapHost = imapHost
        self.imapPort = String(imapPort)
        self.imapPWD = imapPWD
        self.imapUser = imapUser
    }

    func connectSMTP() async {
        do {
            let portNr = Int(smtpPort) ?? 0
            smtpServer = SMTPServer(host: smtpHost, port: portNr)
            try await smtpServer?.connect()
            try await smtpServer?.login(username: smtpUser, password: smtpPWD)
            isSMTPConnected = true
        } catch {
            // ... handle error
            isSMTPConnected = false
        }
    }
    
    func sendSMTPEmail(to : String, recipients: [String],subject: String, body: String) async -> Bool {
        do {
            var recips: [EmailAddress] = []
            // Create sender and recipients
            let sender = EmailAddress(name: "FocusFixr", address: smtpUser)
            recips.append(EmailAddress(name: to, address: to)) // Primary recipient
            
            if recipients.count != 0 {
                for recipient in recipients {
                    recips.append(EmailAddress(name: recipient, address: recipient))
                    }
            }
            
            // Create a new email message
            let email = Email(sender: sender,
                              recipients: recips,
                              subject: subject,
                              textBody: body
            )
            
            // Send the email
            try await smtpServer?.sendEmail(email)
            return true
        } catch {
            _ = Alert(title: Text("Send Error"),
                      message: Text("Failed to send email: \(error.localizedDescription)"),
                      dismissButton: .default(Text("OK")))
            print ("SMTP error: \(error.localizedDescription)")
            return false
        }
    }
    
    func connectIMAP() async {
        do {
            imapServer = IMAPServer(host: imapHost, port: Int(imapPort)!)
            try await imapServer?.connect()
            try await imapServer?.login(username: imapUser, password: imapPWD)
            isIMAPConnected = true
        } catch {
            isIMAPConnected = false
        }
    }
}
