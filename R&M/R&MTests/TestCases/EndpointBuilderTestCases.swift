@testable import R_M
import XCTest

final class EndpointBuilderTestCases: XCTestCase {
    func test_guaranteeRandomCharactersAreBeingRequested() throws {
        // Given
        let networkSpy = RequestManagerSpy()
        let sut = CharacterStoredRepo(networkService: networkSpy)

        // When
        sut.randomCharacters() { _ in }

        // Verify
        let resultingURL = try XCTUnwrap(networkSpy.invokedRequestURL, "No URL assembled on this request")
        XCTAssertEqual(resultingURL.url?.absoluteString,
                       "https://rickandmortyapi.com/api/character?page=3",
                       "Malformed URL for random characters request")
        XCTAssertEqual(networkSpy.invokedRequestCount, 1, "No request for random characters hit")
    }

    //    func test_guaranteeRandomPagesForCharacters_onEachOccasion() {
    //        // Given
    //        let sut = EndpointBuilder(host: <#T##String#>, path: <#T##String#>)
    //    }
}
