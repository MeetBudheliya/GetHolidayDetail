//
//  DataModel.swift
//  GetHolidayDetail
//
//  Created by MAC on 18/12/20.
//

import Foundation
struct Holidayresponse:Decodable {
    var response:Holidays
}
struct Holidays:Decodable {
    var holidays:[HolidayDetail]
}
struct HolidayDetail:Decodable {
    var name:String
    var description:String
    var date:Dateinfo
}
struct Dateinfo:Decodable {
    var iso:String
}
