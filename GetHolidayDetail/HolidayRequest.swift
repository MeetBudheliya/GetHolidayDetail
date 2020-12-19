//
//  HolidayRequest.swift
//  GetHolidayDetail
//
//  Created by MAC on 18/12/20.
//

import Foundation
enum holidayError:Error {
    case cannotproccesData
    case noDataAvailable
}
struct HolidayRequest {
    let resourceURL:URL
    let API_Key = "5efaf47b25b6ea0675365a4b720369dcba4e98a6"
    
    init(countryCode:String) {
        let currentDate = Date()
        let formet = DateFormatter()
        formet.dateFormat = "yyyy"
        let currentYear = formet.string(from: currentDate)
        let resourceString = "https://calendarific.com/api/v2/holidays?&api_key=\(API_Key)&country=\(countryCode)&year=\(currentYear)"
        self.resourceURL = URL(string: resourceString)!
        print(resourceURL)
    }
    func getHolidays(completion: @escaping(Result<[HolidayDetail],holidayError>)->Void){
        let dataTask = URLSession.shared.dataTask(with: resourceURL){ data,_,_ in
            guard let jsonData = data else{
                completion(.failure(.noDataAvailable))
                print("noDataAvailable")
                return
            }
            do{
                let decoder = JSONDecoder()
                let holidayResponse = try decoder.decode(Holidayresponse.self, from: jsonData)
                let holiodaydetail = holidayResponse.response.holidays
                //print(holidayResponse.response.holidays)
                completion(.success(holiodaydetail))
            }catch{
                completion(.failure(.cannotproccesData))
                print("CannotproccesData")
            }
        }
        dataTask.resume()
    }
}
