@testable import R_M
import XCTest

final class EndpointBuilderTestCases: XCTestCase {
    private func buildSpiedSUT(
        with randomGenerator: Randomable = RandomGenerator(totalPages: 20)
    ) -> (CharacterStoredRepo, RequestManagerSpy) {
        let networkSpy = RequestManagerSpy()
        let sut = CharacterStoredRepo(networkService: networkSpy, randomGenerator: randomGenerator)

        return (sut, networkSpy)
    }

    func test_guaranteeRandomCharactersAreBeingRequested() throws {
        // Given
        let (sut, networkSpy) = buildSpiedSUT(with: StubbedRandomGenerator())

        // When
        sut.randomCharacters() { _ in }

        // Verify
        let resultingURL = try XCTUnwrap(networkSpy.invokedRequestURL, "No URL assembled on this request")
        XCTAssertEqual(resultingURL.url?.absoluteString,
                       "https://rickandmortyapi.com/api/character?page=3",
                       "Malformed URL for random characters request")
        XCTAssertEqual(networkSpy.invokedRequestCount, 1, "No request for random characters hit")
    }

    func test_guaranteeRandomPagesForCharacters_onEachOccasion() throws {
        // Given
        let (sut, networkSpy) = buildSpiedSUT()

        // When
        sut.randomCharacters() { _ in }
        let resultingURL1 = try XCTUnwrap(networkSpy.invokedRequestURL, "No URL assembled on this request")
        sut.randomCharacters() { _ in }
        let resultingURL2 = try XCTUnwrap(networkSpy.invokedRequestURL, "No URL assembled on this request")

        // Verify
        XCTAssertNotEqual(resultingURL1.url,
                          resultingURL2.url,
                          "Random characters are always producing the same set")
    }
}
