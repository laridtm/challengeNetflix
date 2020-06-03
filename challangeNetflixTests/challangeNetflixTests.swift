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
    var worker: MovieListWorkerProtocol?
    let dataprovider: MovieListDataProvider = MovieListDataProvider(config: Realm.Configuration(inMemoryIdentifier: "inMemory"))
    
    override func setUp() {
        super.setUp()
        
        worker = MovieListWorker(dataProvider: dataprovider)
        
        guard let fileURL = Bundle.main.url(forResource: "movies", withExtension: "json") else {
            print("couldn't find the file")
            return
        }
        
        do {
            let content = try Data(contentsOf: fileURL)
            movies = try JSONDecoder().decode([Movie].self, from: content)
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
        
        var moviesSearch: [Movie]?
        
        moviesSearch = worker?.searchMovie(movies: self.movies, search: "Av")
        
        if let searchResult = moviesSearch {
            XCTAssertEqual(searchResult.count, 1)
            XCTAssertEqual(searchResult[0].title, "Avatar")
        } else {
            XCTAssertTrue(false)
        }
    }
    
    func testIfTheDatabaseIsAddingCorrectly() {
        
        let database: HandlerDatabase = HandlerDatabase(config: Realm.Configuration(inMemoryIdentifier: "inMemory"))
        
        for movie in self.movies {
            //Use an in-memory Realm
            database.add(object: movie.toMovieRealm())
        }
        
//        worker?.dataProviderList.add(movies: self.movies)
        
        let allObjects = database.retrieveAllObjects(type: MovieRealm.self) as! [MovieRealm]
        
        XCTAssertEqual(allObjects.count, 4)
        XCTAssertEqual(allObjects[0].title, "Avatar")
        XCTAssertEqual(allObjects[1].title, "Interstellar")
        XCTAssertEqual(allObjects[2].title, "Assassin's Creed")
        XCTAssertEqual(allObjects[3].title, "Rogue One: A Star Wars Story")
        
        
    }
    
}
