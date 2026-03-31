//
//  FocusFixrTests.swift
//  FocusFixrTests
//
//  Created by Adriana Luns on 27/03/2026.
//

import Testing
@testable import FocusFixr

struct FocusFixrTests {

    @MainActor @Test func initializeMailConnector()  {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let mailConnector: MailConnector = MailConnector()
        
        #expect(mailConnector.smtpHost == "mail.mijndomein.nl" )
        #expect(mailConnector.smtpPort == "587" )
        #expect(mailConnector.smtpUser == "info@adrianaluns.nl" )

//        #expect(mailConnector.imapHost == "imap.xs4all.nl" )
//        #expect(mailConnector.imapPort == "993" )
//        #expect(mailConnector.imapUser == "luns@xs4all.nl" )

    }
    
    @MainActor @Test func setSMTPParams()  {
        let mailConnector: MailConnector = MailConnector()
        
        mailConnector.setSMTPParams(smtpHost: "test.com", smtpPort: 465, smtpUser: "testuser", smtpPWD: "testpwd")
        
        #expect(mailConnector.smtpHost == "test.com" )
        #expect(mailConnector.smtpPort == "465" )
        #expect(mailConnector.smtpUser == "testuser" )
    }
    
    @Test func connectSMPT() async {
        let mailConnector: MailConnector = await MailConnector()
        
        await mailConnector.connectSMTP()

        #expect(mailConnector.isSMTPConnected == true)
    }
    
    @Test func testSendMail() async throws {

        let mailConnector: MailConnector = await MailConnector()
        
        await mailConnector.connectSMTP()
        
        let result = await mailConnector.sendSMTPEmail(to: "peter.luns@outlook.com", recipients: [], subject: "Test", body: "This is a test email.")
        
        #expect(result == true)

    }

}
