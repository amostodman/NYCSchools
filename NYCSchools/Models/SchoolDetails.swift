//
//  SchoolDetails.swift
//  NYCSchools
//
//  Created by Amos Todman on 1/12/24.
//

import Foundation

struct SchoolDetails : Codable {
    let dbn : String?
    let school_name : String?
    let num_of_sat_test_takers : String?
    let sat_critical_reading_avg_score : String?
    let sat_math_avg_score : String?
    let sat_writing_avg_score : String?
    
    static let emptySchoolDetails = SchoolDetails(dbn: nil,
                                           school_name: nil,
                                           num_of_sat_test_takers: nil,
                                           sat_critical_reading_avg_score: nil,
                                           sat_math_avg_score: nil,
                                           sat_writing_avg_score: nil)
    
    static let dummySchoolDetails = SchoolDetails(dbn: "DBN123",
                                           school_name: "school_name",
                                           num_of_sat_test_takers: "10",
                                           sat_critical_reading_avg_score: "80",
                                           sat_math_avg_score: "90",
                                           sat_writing_avg_score: "70")
}

