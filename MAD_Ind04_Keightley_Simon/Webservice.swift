//
//  Webservice.swift
//  MAD_Ind04_Keightley_Simon
//
//  Created by Simon Keightley on 4/26/24.
//

import Foundation

//custom error for throwing if http is not 200 or 'GET'
enum StatesError: Error {
    case invalidServerResponse
}

class WebService {
    
    func getStates(url: URL) async throws -> [State] {
        //get the data and response from a url session
        let (data, response) = try await URLSession.shared.data(from: url)
        //determine if there is a non-200 html status
        guard let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200 else {
                throw StatesError.invalidServerResponse
            }
        //decode the json being pulled
        return try JSONDecoder().decode([State].self, from: data)
    }
}
