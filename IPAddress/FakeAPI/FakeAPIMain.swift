//
//  FakeAPIMain.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2024/05/13.
//

import SwiftUI

struct FakeAPIMain: View {
    @State private var selectedTab = 0

    var body: some View {
        NavigationView {
            VStack {
                // Custom top tab bar
                HStack {
                    Button(action: {
                        selectedTab = 0
                    }) {
                        VStack {
                            Image(systemName: "list.dash")
                            Text("Products")
                        }
                        .padding()
                    }
                    .foregroundColor(selectedTab == 0 ? .blue : .gray)
                    
                    Spacer()
                    
                    Button(action: {
                        selectedTab = 1
                    }) {
                        VStack {
                            Image(systemName: "cart.fill")
                            Text("Cart")
                        }
                        .padding()
                    }
                    .foregroundColor(selectedTab == 1 ? .blue : .gray)
                    
                    Spacer()
                    
                    Button(action: {
                        selectedTab = 2
                    }) {
                        VStack {
                            Image(systemName: "person.fill")
                            Text("Users")
                        }
                        .padding()
                    }
                    .foregroundColor(selectedTab == 2 ? .blue : .gray)
                }
                .background(Color(UIColor.systemBackground))
                .padding(.top, 10)
                .padding(.horizontal)
                
                Divider()
                
                // Display selected tab content
                VStack {
                    if selectedTab == 0 {
                        ProductListView()
                    } else if selectedTab == 1 {
                        FakeAPICart()
                    } else if selectedTab == 2 {
                        FakeAPIUser()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        FakeAPIMain()
    }
}
