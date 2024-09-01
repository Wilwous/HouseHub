//
//  AuthService.swift
//  HouseHub
//
//  Created by Антон Павлов on 29.08.2024.
//

import Foundation

final class AuthService {
    
    // MARK: - Public Methods
    
    func performLogin(username: String, password: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        guard let url = URL(string: "https://test.rozentalgroup.ru/version2/entry.php") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let loginString = String(format: "%@:%@", username, password)
        guard let loginData = loginString.data(using: .utf8) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Encoding error"])))
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = ""
        body += "--\(boundary)\r\n"
        body += "Content-Disposition: form-data; name=\"service[0][name]\"\r\n\r\n"
        body += "login\r\n"
        body += "--\(boundary)\r\n"
        body += "Content-Disposition: form-data; name=\"service[0][attributes][login]\"\r\n\r\n"
        body += "\(username)\r\n"
        body += "--\(boundary)\r\n"
        body += "Content-Disposition: form-data; name=\"service[0][attributes][password]\"\r\n\r\n"
        body += "\(password)\r\n"
        body += "--\(boundary)\r\n"
        body += "Content-Disposition: form-data; name=\"service[1][name]\"\r\n\r\n"
        body += "customer_navbar\r\n"
        body += "--\(boundary)--\r\n"
        
        request.httpBody = body.data(using: .utf8)
        
        print("Request prepared, sending...")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Request error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("Response received: \(json)")
                    completion(.success(json))
                } else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON"])))
                }
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
