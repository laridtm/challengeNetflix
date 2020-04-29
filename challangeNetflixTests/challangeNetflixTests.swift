//
//  challangeNetflixTests.swift
//  challangeNetflixTests
//
//  Created by Larissa Diniz  on 20/02/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import XCTest
@testable import challangeNetflix
import RealmSwift

class challangeNetflixTests: XCTestCase {
    
    let decoder = JSONDecoder()
    var movies: [Movie] = []
    var movieSearch: MovieSearch = MovieSearch()
    var movieTakeData: MovieTakeData = MovieTakeData()

    override func setUp() {
        super.setUp()
        
        guard let fileURL = Bundle.main.url(forResource: "movies", withExtension: "json") else {
            print("couldn't find the file")
            return
        }
        
        do {
            let content = try Data(contentsOf: fileURL)
            movies = self.movieTakeData.decoder(data: content)
        } catch let error {
            print(error)
        }
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testDecoding() {
        
        XCTAssertEqual(movies.count, 4)
    }
    
    func testIfTheSearchIsCorrect() {
        
        var moviesSearch: [Movie] = []
        
        moviesSearch = movieSearch.searchMovie(movies: movies, search: "Av")
        
        XCTAssertEqual(moviesSearch.count, 1)
        XCTAssertEqual(moviesSearch[0].title, "Avatar")
        
    }
    
    func testIfTheDatabaseIsAddingCorrectly() {
        
        let database: MovieDatabase = MovieDatabase(config: Realm.Configuration(inMemoryIdentifier: "inMemory"))
        
        for movie in self.movies {
            //Use an in-memory Realm
            database.addFilmDB(movie: movie)
        }
        
        let allObjects = database.retrieveAllObjects()
        
        XCTAssertEqual(allObjects.count, 4)
        XCTAssertEqual(allObjects[0].title, "Avatar")
        XCTAssertEqual(allObjects[1].title, "Interstellar")
        XCTAssertEqual(allObjects[2].title, "Assassin's Creed")
        XCTAssertEqual(allObjects[3].title, "Rogue One: A Star Wars Story")
        
        
    }

}
