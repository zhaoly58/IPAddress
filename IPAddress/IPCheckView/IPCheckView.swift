//
//  IPCheckView.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2024/05/12.
//

import SwiftUI
import URLImage
import GoogleMobileAds


struct IPCheckTab: View {
    
    @State var ipAddress : IPAddress? = nil
    @State var userInputIP: String = ""
    @State var isShowingAlert = false
    @FocusState private var isTextFieldFocused: Bool
    var hitUrl : String = ""
    @State private var loadedImage: UIImage?
//    @StateObject private var interstitial = InterstitialAd()
    @StateObject private var interstitialVM = InterstitialViewModel()
    @StateObject private var viewModel = NotificationViewModel()
    
    
    var body: some View {
        ScrollView(showsIndicators: false){
            if let loadedImage = loadedImage {
                Image(uiImage: loadedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 360, height: 180)
            } else {
                ProgressView()
                    .dynamicTypeSize(.xLarge)// Display a loading indicator until the image is loaded
            }
            
            //            Image("blueIPLogo")
            //                .resizable()
            //                .aspectRatio(contentMode: .fit)
            //                .frame(width: 120, height: 120)
            
            
            VStack {
                TextField("Enter IP Address", text: $userInputIP)
                    .frame(width: 240, height: 10)
                    .focused($isTextFieldFocused)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .padding(.horizontal)
                
                VStack{
                    Button("Check") {
                        fetchDataFromAPI()
                        isTextFieldFocused = false
                    }
                    .frame(width: UIScreen.main.bounds.width - 320, height: 30)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 2)
                    }
                    .alert(isPresented: $isShowingAlert) {
                        Alert(title: Text("报错了!"), message: Text("请输入 IP 地址"), dismissButton: .default(Text("欧克~")))
                    }
                    
                    Button("Clear") {
                        userInputIP = ""
                    }
                    .frame(width: UIScreen.main.bounds.width - 320, height: 30)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.red, lineWidth: 2)
                    )
                    
                    
                    Button("My IP Address"){
                        getPublicIPAddress { publicIP in
                            if let publicIP = publicIP {
                                userInputIP = publicIP
                                print("My public IP Address is: \(userInputIP)")
                                // Save the IP address to user defaults or handle as needed
                                
                            }
                            fetchDataFromAPI()
                        }
                        
                    }
                    .frame(width: UIScreen.main.bounds.width - 240, height: 30)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.green, lineWidth: 2)
                    )
                    
                    Button("Show Interstitial ads") {
                        interstitialVM.showAd()
                    }
                    .frame(width: UIScreen.main.bounds.width - 240, height: 30)
                    .background(Color.yellow)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.orange.opacity(0.8), lineWidth: 2)
                    )
                    
                    HStack {
                        Button("请求通知权限") {
                            viewModel.requestAuthorization()
                        }
                        .frame(width: UIScreen.main.bounds.width - 240, height: 30)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.red, lineWidth: 2)
                        )
                        
                        Button("发送本地通知") {
                            viewModel.sendLocalNotification()
                        }
                        .frame(width: UIScreen.main.bounds.width - 240, height: 30)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 2)
                        }
                    }
                    
//                    Button("显示全屏广告") {
//                        if let root = UIApplication.shared.windows.first?.rootViewController {
//                            interstitial.showAd(from: root)
//                        }
//                    }
//                    .disabled(!interstitial.isAdReady)
//                    .padding()
//                    .background(interstitial.isAdReady ? Color.blue : Color.gray)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
                }
                .padding(.top, 10)
//                .task{
//                    await interstitialVM.loadAd()
//                }
            }
            .task{
                await interstitialVM.loadAd()
                print("✅ interstitial Ad is ready!")
            }
            .padding()
            
            VStack(){
                Divider()
                
                HStack(){
                    Text("IP address:")
                    Spacer()
                    Text(ipAddress?.ip ?? "")
                }
                Divider()
                
                HStack(){
                    Text("Country name: ")
                    Spacer()
                    Text(ipAddress?.countryName ?? "")
                }
                Divider()
                
                HStack(){
                    Text("ISP:")
                    Spacer()
                    Text(ipAddress?.isp ?? "")
                }
                Divider()
                
                HStack(){
                    Text("IP number:")
                    Spacer()
                    Text(ipAddress?.ipNumber ?? "")
                }
                Divider()
                
                HStack(){
                    Text("IP version:")
                    Spacer()
                    if let ipVersion = ipAddress?.ipVersion, ipVersion != 0 {
                        Text("\(ipVersion)")
                    } else {
                        Text("")
                    }
                    //Text(ipAddress?.ipVersionAsString ?? "")
                }
                Divider()
                
                HStack(){
                    Text("Country code:")
                    Spacer()
                    Text(ipAddress?.countryCode2 ?? "")
                }
                Divider()
                
                HStack(){
                    Text("Response code:")
                    Spacer()
                    Text(ipAddress?.responseCode ?? "")
                }
                Divider()
                
                HStack(){
                    Text("Response message:")
                    Spacer()
                    Text(ipAddress?.responseMessage ?? "")
                }
                Divider()
                
            }
            .frame(maxWidth: UIScreen.main.bounds.width)
            //.background(Color.cyan)
            .padding()
        }
        
        .padding()
        .gesture(TapGesture().onEnded { _ in
            isTextFieldFocused = false // Dismiss the keyboard when tapping outside
        })
        .onAppear{
            loadImageFromURL()
            getPublicIPAddress { publicIP in
                if let publicIP = publicIP {
                    userInputIP = publicIP
                    print("My public IP Address is: \(userInputIP)")
                    // Save the IP address to user defaults or handle as needed
                    
                }
                fetchDataFromAPI()
            }
        }
    }
    
    
    
    func fetchDataFromAPI() {
        let hitUrl = URL(string: "https://api.iplocation.net/?ip=\(userInputIP)")!
        let request = URLRequest(url: hitUrl)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return
            }
            do {
                let decodedIPAddress = try JSONDecoder().decode(IPAddress.self, from: data)
                ipAddress = decodedIPAddress
                print(ipAddress!)
                print(hitUrl)
                
                if let response = response as? HTTPURLResponse {
                    print("response.url = \(String(describing:response.url))")
                    print("response.mimeType = \(String(describing: response.mimeType))")
                    print("response.expectedContentLength = \(response.expectedContentLength)")
                    print("response.textEncodingName = \(String(describing: response.textEncodingName))")
                    print("response.suggestedFilename = \(String(describing: response.suggestedFilename ))")
                    print("response.statusCode = \(response.statusCode)")
                    print("response.statusCode localizedString=\(HTTPURLResponse.localizedString(forStatusCode: response.statusCode))")
                }
            } catch let error {
                print(error)
            }
        }
        task.resume()
        
        if userInputIP == "" {
            print("The inputted address is empty")
        }
        if userInputIP.isEmpty {
            isShowingAlert = true // Show alert if userInputIP is empty
            return
        }
    }
    
    func loadImageFromURL() {
        guard let imageUrl = URL(string: urlOfTopImage) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            guard let data = data, let loadedImage = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                self.loadedImage = loadedImage
            }
        }
        task.resume()
    }
    
}






//#Preview {
//    IPCheckTab()
//}
