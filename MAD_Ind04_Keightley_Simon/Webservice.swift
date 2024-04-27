//
//  Webservice.swift
//  MAD_Ind04_Keightley_Simon
//
//  Created by Simon Keightley on 4/26/24.
//

import Foundation

enum StatesError: Error {
    case invalidServerResponse
}

class WebService {
    
    func getStates(url: URL) async throws -> [State] {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200 else {
                throw StatesError.invalidServerResponse
            }
        return try JSONDecoder().decode([State].self, from: data)
    }
}
