//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Elodie-Anne Parquer on 03/12/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

@testable import Reciplease
import XCTest

class RecipleaseTests: XCTestCase {
    
    func testGetRecipes_WhenNoDataIsPassed_ThenShouldReturnFailedCallback() {
        let session = MockRecipeSession(fakeResponse: FakeResponse(response: nil, data: nil))
        let requestService = RecipeService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        requestService.getRecipes(ingredientList: "avocado") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getRecipes method with no data failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipes_WhenIncorrectResponseIsPassed_ThenShouldReturnFailedCallback() {
        let session = MockRecipeSession(fakeResponse: FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctData))
        let requestService = RecipeService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        requestService.getRecipes(ingredientList: "avocado") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getRecipes method with incorrect response failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipes_WhenUndecodableDataIsPassed_ThenShouldReturnFailedCallback() {
        let session = MockRecipeSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData))
        let requestService = RecipeService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        requestService.getRecipes(ingredientList: "avocado") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getRecipes method with undecodable data failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipes_WhenCorrectDataIsPassed_ThenShouldReturnFailedCallback() {
        let session = MockRecipeSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData))
        let requestService = RecipeService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        requestService.getRecipes(ingredientList: "avocado") { result in
            guard case .success(let data) = result else {
                XCTFail("Test getRecipes method with correct data failed.")
                return
            }
            XCTAssertTrue(data.hits[0].recipe.label == "Mashed Avocado")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
}
