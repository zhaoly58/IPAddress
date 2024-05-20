

import Foundation

func getPublicIPAddress(completion: @escaping (String?) -> Void) {
    let url = URL(string: "https://api.ipify.org")!

    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if error != nil {
            print("Error fetching IP address: (error)")
            completion(nil)
            return
        }

        if let data = data, let publicIP = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) {
            completion(publicIP)
        } else {
            print("Unable to fetch IP address.")
            completion(nil)
        }
    }

    task.resume()
}


// Usage
//getPublicIPAddress { publicIP in
//    if let publicIP = publicIP {
//        var userInputIP = publicIP
//        print("My public IP Address is: (userInputIP)")
//        // Save the IP address to user defaults or handle as needed
//    }
//}
