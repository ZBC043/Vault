//
//  ContentView.swift
//  Vault
//
//  Created by 赵博琛 on 14/03/2023.
//

import SwiftUI

struct ContentView: View {
    let distances = ["5", "10", "15", "20"]
    let modes = ["In range, locked", "In range, unlocked", "Out of range, automatically locked"]
    
    @State private var selectedDistance = "10"
    @State private var lock = false
    @State private var showingLockAlert = false
    @State private var lockImage = "lock.circle.fill"
    @State private var lockMessage = "Lock my wallet"
    @State private var lockPageTitle = "Press OK to exit"
    @State private var locked = "Your wallet is now locked"
    @State private var mode = "Unlocked"
    @State private var reportMessage = "Report wallet lost"
    @State private var reportImage = "exclamationmark.circle.fill"
    @State private var isInRange = true
    
    @State private var reportPageTitle = "WARNING!"
    @State private var reported = "Your wallet is automatically locked as it is far away from you"
    @State private var showingReportAlert = false
    
    var body: some View {
        VStack {
            VStack() {
                Image("logo")
                    .resizable()
                    .frame(width: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)
            }
            
            Spacer()
            
            VStack {
                VStack {
                    Image("map")
                        .renderingMode(.original)
                        .resizable()
                    
                    Form {
                        if isInRange == true && lock == true{
                            Text("Mode: " + modes[0])
                        } else if isInRange == true && lock == false {
                            Text("Mode: " + modes[1])
                        } else if isInRange == false{
                            Text("Mode: " + modes[2])
                        }
                        
                        Picker("Set auto-lock range", selection: $selectedDistance) {
                            ForEach(distances, id: \.self) {
                                Text($0 + " Metres")
                            }
                        }
                    }
                }
                
                Button {
                    reportLost()
                } label: {
                    Label(reportMessage, systemImage: reportImage)
                        .padding()
                        .clipShape(Capsule())
                }
                
                Button {
                    lockButtonTapped()
                } label: {
                    Label(lockMessage, systemImage: lockImage)
                        .padding()
                        .clipShape(Capsule())
                }

                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
        }
        .alert(lockPageTitle, isPresented: $showingLockAlert) {
            Button("OK", action: changeButtonIcon)
        } message: {
            Text(locked)
        }
        .alert(reportPageTitle, isPresented: $showingReportAlert) {
            Button("OK", action: doNothing)
        } message: {
            Text(reported)
        }
    }
    
    func reportLost() {
        isInRange.toggle()
        showingReportAlert = true
    }
    
    func lockButtonTapped() {
        if isInRange == true {
            lock.toggle()
            showingLockAlert = true
        }
    }
    
    func changeButtonIcon() {
        if isInRange == true {
            if lock == true {
                mode = "Locked"
                lockImage = "lock.open.fill"
                lockMessage = "Unlock my wallet"
                locked = "Your property is now unlocked"
            } else {
                mode = "Unlocked"
                lockImage = "lock.circle.fill"
                lockMessage = "Lock my wallet"
                locked = "Your property is now locked"
            }
        }
    }
    
    func doNothing(){
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
