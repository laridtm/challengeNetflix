//
//  challangeNetflixTests.swift
//  challangeNetflixTests
//
//  Created by Larissa Diniz  on 20/02/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import XCTest
@testable import challangeNetflix

class challangeNetflixTests: XCTestCase {
    
    let decoder = JSONDecoder()
    var movies: [Movie] = []

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        movies = decodeMovies(nameFile: "movies")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func decodeMovies(nameFile: String) -> [Movie] {
        
        guard let fileURL = Bundle.main.url(forResource: nameFile, withExtension: "json") else {
            print("couldn't find the file")
            return []
        }
        
        do {
            let content = try Data(contentsOf: fileURL)
            
            do {
                let movies = try decoder.decode([Movie].self, from: content)
                return movies
            } catch {
                print(error)
            }
            
        } catch let error {
            print(error)
        }
        return []
    }
    
    func testDecodingIsCorrect() {
        
        XCTAssertEqual(movies.count, 4)
    }
    
//    func testIfTheCellContainsAnImage() {
//
//        let cell: MovieCell
//        cell = MovieCell()
//
//        guard let urlImage: URL = self.movies[0].images[2] else {
//            print(Error.self)
//            return
//        }
//
//        XCTAssertNil(cell.movieImage)
//
//        cell.configureImage(url: urlImage)
//
//        XCTAssertNotNil(cell.movieImage)
//    }
    
  

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
