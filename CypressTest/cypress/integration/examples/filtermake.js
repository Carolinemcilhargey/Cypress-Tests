//The below checks every asset on the serps page for the specified filter. 
// Do this on cash prices , make and modelm, 

describe("Filters", function () {
  beforeEach(function () {
    cy.visit("/");
  })

  it("will only returns makes that you have applied to your search", function () {
    cy.get('[data-reactroot=""]>:nth-child(1) > .ch-form__control').select('Audi')
    cy.get('#search-button').click()
    cy.get('h2.ac-vehicle__title').each((make) => {
      expect(make).to.contain('Audi'); // instead of to.contain we can put in less than / more than etc see cypress assert documentation 
    })
  });
})