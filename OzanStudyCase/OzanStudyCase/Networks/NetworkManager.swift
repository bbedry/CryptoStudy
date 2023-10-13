//
//  NetworkManager.swift
//  OzanStudyCase
//
//  Created by Bedri Doğan on 13.10.2023.
//

import Foundation

struct NetworkManager {
    private func createRequest(for url: String) -> URLRequest? {
        guard let url = URL(string: url) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        return request
    }
}

