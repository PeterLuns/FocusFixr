//
//  LaunchScreenView.swift
//  FocusFixr
//
//  Created by Adriana Luns on 08/03/2026.
//

import SwiftUI

struct LaunchScreenView: View {
    @State private var isActive:Bool = false
    
    var body: some View {
        if isActive
        {
            ContentView()
        }
        else
        {
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
                
                VStack(){
                    Image("Logo_Adriana")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300,height: 100)
                        .padding()
                

                    Text("Capture the thought.")
                        .italic()
                        .bold()
                        .font(.title2)
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 40)
                    
                    

                    Text("Keep your focus")
                        .italic()
                        .bold()
                        .font(.title2)
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 40)

                    Spacer().frame(height: 250)
                    Text("Loading FocusFixr ...")
                        .foregroundStyle(Color.black)
                    
                    ProgressView()
                        .progressViewStyle( CircularProgressViewStyle(tint:Color.white))
                    
                    Spacer().frame(height: 150)
                    FootnoteView()
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter( deadline: .now() + 2)
                {
                    withAnimation
                    {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    LaunchScreenView()
}
