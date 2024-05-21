//
//  FakeAPIMain.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2024/05/13.
//

import SwiftUI

struct FakeAPIViewMain: View {
    @State private var selectedTab = 0

    let gradientColors = [
        UIColor(red: 0.00, green: 0.27, blue: 0.58, alpha: 1.00).cgColor,
           UIColor(red: 0.06, green: 0.68, blue: 1.00, alpha: 1.00)
            .cgColor]
    
    
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
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                            Text("Products")
                                .font(.callout)
                                .padding(.top, -5)
                        }
                        .frame(width: 80, height: 80)
                        .padding()
                    }
                    .foregroundColor(selectedTab == 0 ? .blue : .gray)
                    
                    Spacer()
                    
                    Button(action: {
                        selectedTab = 1
                    }) {
                        VStack {
                            Image(systemName: "cart.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                            Text("Cart")
                                .font(.callout)
                                .padding(.top, -5)
                        }
                        .frame(width: 80, height: 80)
                        .padding()
                    }
                    .foregroundColor(selectedTab == 1 ? .blue : .gray)
                    
                    Spacer()
                    
                    Button(action: {
                        selectedTab = 2
                    }) {
                        VStack {
                            Image(systemName: "person.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                            Text("Users")
                                .font(.callout)
                                .padding(.top, -5)
                        }
                        .frame(width: 80, height: 80)
                        .padding()
                    }
                    .foregroundColor(selectedTab == 2 ? .blue : .gray)
                }
                .frame(width: 80, height: 60)
                .background(Color(UIColor.systemBackground))
                .padding(.top, 5)
                //.padding(.horizontal)
                
                
                // Display selected tab content
                VStack {
                    if selectedTab == 0 {
                        ProductListView()
                    } else if selectedTab == 1 {
                        CartListView()
                    } else if selectedTab == 2 {
                        FakeAPIUserView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        FakeAPIViewMain()
    }
}
