//
//  DashboardService.swift
//  HouseHub
//
//  Created by Антон Павлов on 29.08.2024.
//

import Foundation

final class DashboardService {
    
    // MARK: - Public Methods
    
    func fetchDashboardData(completion: @escaping (Result<[String: Any], Error>) -> Void) {
        guard let url = URL(string: "https://test.rozentalgroup.ru/version2/entry.php") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let loginString = "test_user:123456aB"
        let loginData = loginString.data(using: .utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = ""
        body += "--\(boundary)\r\n"
        body += "Content-Disposition: form-data; name=\"service[0][name]\"\r\n\r\ncustomer_dashboard\r\n"
        body += "--\(boundary)\r\n"
        body += "Content-Disposition: form-data; name=\"service[1][name]\"\r\n\r\nmy_profile\r\n"
        body += "--\(boundary)\r\n"
        body += "Content-Disposition: form-data; name=\"service[2][name]\"\r\n\r\nmy_new_notifications\r\n"
        body += "--\(boundary)\r\n"
        body += "Content-Disposition: form-data; name=\"service[2][attributes][mode]\"\r\n\r\nprivate\r\n"
        body += "--\(boundary)--\r\n"
        
        request.httpBody = body.data(using: .utf8)
        
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
