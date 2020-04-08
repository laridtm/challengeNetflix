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
    
    class Movie: Codable {
        
        let id: String
        let title: String
        let year: String
        let rated: String
        let released: String
        let runtime: String
        let genre: String
        let director: String
        let writer: String
        let actors: String
        let plot: String
        let language: String
        let country: String
        let awards: String
        let poster: String
        let metascore: String
        let resolution: Bool
        let hdr: Bool
        let trailer: URL?
        let images: [URL]
        
        enum CodingKeys: String, CodingKey {
            case id, title, year, rated, released, runtime, genre, director, writer,
            actors, plot, language, country, awards, poster, metascore
            case resolution = "4k"
            case hdr, trailer, images
            
        }
    }
    
    let decoder = JSONDecoder()
    
    var movies = [Movie].self

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
        
        let moviesDecoded = decodeMovies(nameFile: "movies")
        
        XCTAssertEqual(moviesDecoded.count, 4)
    }
    
    
    
  

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
