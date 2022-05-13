//
//  FoodSearchAPI.swift
//  NutriPal (iOS)
//
//  Created by Jessie Pao on 5/9/22.
//

import Foundation

// Connect to the API to search for food.
class FoodSearch {
    func SearchingFor(searchedName: String) async throws -> (Optional<FoodItemModel>, Int) {
        
        let headers = [
            "X-RapidAPI-Host": "nutritionix-api.p.rapidapi.com",
            "X-RapidAPI-Key": "c7083ff65cmshd57333733ad1c92p19f77cjsne3d64637b272"
        ]
        
        let finalString = searchedName.replacingOccurrences(of: " ", with: "%20")
        
        let url = URL(string: "https://nutritionix-api.p.rapidapi.com/v1_1/search/\(finalString)?fields=item_name%2Citem_id%2Cbrand_name%2Cnf_calories%2Cnf_total_fat%2Cnf_protein%2Cnf_total_carbohydrate")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let (data, response) = try await URLSession.shared.data(for: request)
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode != 200 {
                print ("httpResponse.statusCode: \(httpResponse.statusCode)")
                return (nil, httpResponse.statusCode)
            } else {
                let decodedData = try? JSONDecoder().decode(FoodItemModel.self, from: data)
                print(decodedData)
                return (decodedData, (httpResponse.statusCode))
            }
        }
        return (nil, 500)
    }
}
