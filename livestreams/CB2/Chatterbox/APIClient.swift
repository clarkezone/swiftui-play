//
//  APIClient.swift
//  Chatterbox
//
//  Created by James Clarke on 6/21/25.
//

import Foundation

struct APIClient {
    var apiKey: String
    
    func generatetext(from prompt: String, instructions: String, previousResponse: String?) async throws -> (id: String, message: String) {
        let url = URL(string: "https://api.openai.com/v1/responses")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var requestBody: [String: Any] = [
            "model": "gpt-4.1-nano",
            "input": prompt,
            "instructions": instructions,
            ]
        
        if let previousResponse = previousResponse {
            if previousResponse != "" {
                requestBody["previous_response_id"] = previousResponse
            }
        }
        
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        let (data, _) = try await URLSession.shared.data(for: request)
        print(String(decoding: data, as: UTF8.self))
        let openaiResponse = try JSONDecoder().decode(OpenAIResponse.self, from: data)
        let responseText = openaiResponse.output.first?.content.first?.text ?? ""
        return (openaiResponse.id, responseText)
    }
}
