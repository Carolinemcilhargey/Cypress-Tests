describe("Checks the vehicles API", function () {
  beforeEach(function () {
    cy.request('https://www.arnoldclark.com/used-cars/search.json?payment_type=cash&min_price=1000&max_price=3000').as('vehiclesBetween3000And10000');
    cy.request('https://www.arnoldclark.com/used-cars/search.json?photos_only=true').as('vehiclesWithPhotos');

  })
  it("Returns vehicles within specified budget", function () {
    cy.get('@vehiclesBetween3000And10000').then(response => {
      expect(response.body.searchResults).to.have.lengthOf(24)
      response.body.searchResults.forEach(function (result) {
        expect(result.salesInfo.pricing.cashPrice).to.be.greaterThan(3000);
        expect(result.salesInfo.pricing.cashPrice).to.be.lessThan(10000);
      })
    })
  })

  it("Returns vehicles with photos of photos_only is true", function () {
    cy.get('@vehiclesWithPhotos').then(response => {
      expect(response.body.searchResults).to.have.lengthOf(24)
      response.body.searchResults.forEach(function (result) {
        expect(result.photos.length).to.be.greaterThan(0);
      })
    })
  })
});