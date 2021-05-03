//
//  ContentView.swift
//  xTablesChallenge
//
//  Created by Alex Oliveira on 03/05/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                
                VStack {
                    Text("Which tables do you want to practice?")

                    HStack {
                        ForEach(1 ..< 5) {
                            Button("\($0)") {
                                //
                            }
                        }
                    }

                    HStack {
                        ForEach(5 ..< 9) {
                            Button("\($0)") {
                                //
                            }
                        }
                    }

                    HStack {
                        ForEach(9 ..< 13) {
                            Button("\($0)") {
                                //
                            }
                        }
                    }
                }
                
                VStack {
                    Text("How many questions do you want to be asked?")
                    
                    HStack {
                        ForEach(0 ..< 3) {
                            let buttonTitle = 5.0 * pow(2.0, Double($0))
                            Button("\(Int(buttonTitle))") {
                                //
                            }
                        }
                        
                        Button("All") {
                            //
                        }
                    }
                }
                
                Spacer()
                
                Button("Start") {
                    //
                }
                
                Spacer()
            }
            .navigationBarTitle("xTables")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
