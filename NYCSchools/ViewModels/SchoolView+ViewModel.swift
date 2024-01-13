//
//  SchoolView+ViewModel.swift
//  NYCSchools
//
//  Created by Amos Todman on 1/12/24.
//

import Foundation
import SwiftUI

extension SchoolView {
    @MainActor
    class ViewModel: ObservableObject {
        var isForTesting: Bool = false
        
        @Published var school: School
        @Published var schoolDetails: SchoolDetails
        
        let navigationTitle = "School Details"
        let avgScoresText = "Average Scores"
        let locationText = "Contact Details"
        let numOfSatTestTakers = "Number of SAT test takers"
        let satCriticalReadingAvgScore = "SAT Critical reading"
        let satMathAvgScore = "SAT Math"
        let satWritingAvgScore = "SAT Writing"
        let additionalDetailsText = "Additional Details"
        let overviewText = "Overview"
        let academicOpportunitiesText = "Academic Opportunities"
        let sportsSectionText = "School Sports"
        let requirementsSectionText = "Requirements"
        let noDataText = "No data"
        
        var hasSchoolDetails: Bool {
            return !(schoolDetails.num_of_sat_test_takers == nil
            && schoolDetails.sat_math_avg_score == nil
            && schoolDetails.sat_writing_avg_score == nil
            && schoolDetails.sat_critical_reading_avg_score == nil)
        }
        
        init(school: School, schoolDetails: SchoolDetails, isForTesting: Bool = false) {
            self.isForTesting = isForTesting
            self.school = school
            self.schoolDetails = schoolDetails
        }
        
        func populateSchoolDetails() async {
            if isForTesting {
                populateSchoolDetailsFromJSONFile(filename: "SchoolDetails")
                return
            }
            
            do {
                var schoolDetailsUrlcomponents = URLComponents(string: Constants.Urls.schoolUrl.absoluteString)!

                schoolDetailsUrlcomponents.queryItems = [
                    URLQueryItem(name: "dbn", value: school.dbn)
                ]

                guard let schoolUrl = schoolDetailsUrlcomponents.url else {
                    throw URLError(.badURL)
                }
                
                let response = try await WebService().get(url: schoolUrl) { data in
                                    return try? JSONDecoder().decode([SchoolDetails].self, from: data)
                                }
                if let details = response.first {
                    self.schoolDetails = details
                }
            } catch {
                print("\(error.localizedDescription)")
            }
        }
        
        func populateSchoolDetailsFromJSONFile(filename: String) {
            do {
                let response = try WebService().loadJson(filename: filename) { data in
                                    return try? JSONDecoder().decode([SchoolDetails].self, from: data)
                                }
                
                let result = response.filter {
                    $0.dbn == school.dbn
                }
                
                if let schoolDetails = result.first {
                    self.schoolDetails = schoolDetails
                }
            } catch {
                print("\(error.localizedDescription)")
            }
        }
    }
}
