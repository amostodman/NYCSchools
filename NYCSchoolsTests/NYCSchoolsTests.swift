//
//  NYCSchoolsTests.swift
//  NYCSchoolsTests
//
//  Created by Amos Todman on 1/12/24.
//

import XCTest
@testable import NYCSchools

@MainActor
final class NYCSchoolsTests: XCTestCase {
    
    // Change this to false to test with live web data
    var isForTesting = true

    func testPopulateSchools() async throws {
        // 440 is the number From "What's in this Dataset?" from https://data.cityofnewyork.us/Education/2017-DOE-High-School-Directory/s3k6-pzi2
        let expectedCount = 440
        
        let viewModel = SchoolsView.ViewModel(isForTesting: isForTesting)
        await viewModel.populateSchools()
        XCTAssertEqual(viewModel.schools.count, expectedCount)
        XCTAssertEqual(viewModel.schoolsFiltered.count, expectedCount)
    }
    
    func testFilterSchools() async throws {
        let searchText = "acorn"
        let expectedSchoolName = "ACORN Community High School"
        let expectedCount = 1
        
        let viewModel = SchoolsView.ViewModel(searchText: searchText, isForTesting: isForTesting)
        await viewModel.populateSchools()
        
        XCTAssertEqual(viewModel.schoolsFiltered.count, expectedCount)
        
        guard 
            let school = viewModel.schoolsFiltered.first,
            let schoolName = school.school_name
        else {
            XCTFail("School not found")
            return
        }
        
        XCTAssertEqual(schoolName, expectedSchoolName)
    }

    func testAverageScoreExist() async throws {
        let searchText = "acorn"
        let expectedTestTakers = "72"
        let expectedCriticalReadingAvg = "384"
        let expectedMathAvg = "364"
        let expectedWritingAvg = "368"
        
        let schoolsViewModel = SchoolsView.ViewModel(searchText: searchText, isForTesting: isForTesting)
        await schoolsViewModel.populateSchools()
        guard let school = schoolsViewModel.schoolsFiltered.first else {
            XCTFail("School not found")
            return
        }
        
        let schoolViewModel = SchoolView.ViewModel(school: school, schoolDetails: SchoolDetails.emptySchoolDetails, isForTesting: isForTesting)
        await schoolViewModel.populateSchoolDetails()
        
        XCTAssertTrue(schoolViewModel.hasSchoolDetails)
        
        XCTAssertEqual(schoolViewModel.schoolDetails.dbn, school.dbn)
        XCTAssertEqual(schoolViewModel.schoolDetails.num_of_sat_test_takers, expectedTestTakers)
        XCTAssertEqual(schoolViewModel.schoolDetails.sat_math_avg_score, expectedMathAvg)
        XCTAssertEqual(schoolViewModel.schoolDetails.sat_writing_avg_score, expectedWritingAvg)
        XCTAssertEqual(schoolViewModel.schoolDetails.sat_critical_reading_avg_score, expectedCriticalReadingAvg)
    }
    
    func testAverageScoreDoesNotExist() async throws {
        let searchText = "clinton s"
        let schoolsViewModel = SchoolsView.ViewModel(searchText: searchText, isForTesting: isForTesting)
        await schoolsViewModel.populateSchools()
        guard let school = schoolsViewModel.schoolsFiltered.first else {
            XCTFail("School not found")
            return
        }
        
        let schoolViewModel = SchoolView.ViewModel(school: school, schoolDetails: SchoolDetails.emptySchoolDetails, isForTesting: isForTesting)
        await schoolViewModel.populateSchoolDetails()
        
        XCTAssertFalse(schoolViewModel.hasSchoolDetails)
    }
}
