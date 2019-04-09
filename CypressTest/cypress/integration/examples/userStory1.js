describe('my first userstory ', function () {
    it('navigates to main homepage', function (){
        cy.visit('https://iweb2.arnoldclark.com')    
    })
    
    it('checks the special offers section', function (){
        cy.get('.ac-offers > .ch-h3')
        .should('contain', 'Special offers')
    })
    
    it('enters filters on the homepage', function (){
        cy.get('[data-reactroot=""]>:nth-child(1) > .ch-form__control').select('Audi')
        cy.get('[data-reactroot=""]>:nth-child(2) > .ch-form__control').select('A1')
        cy.get('.ac-searchmask__budget-summary').click()
        cy.get('#payment-type-cash').check({force: true})
        cy.get('[name="max_price"]').select('10000')
        cy.get('#search-button').click()
    })
    it('Verifies the filters on serps page', function (){
        cy.get('.ac-searchtags__tag-list > :nth-child(1)')
        .should('contain', 'Audi')
        cy.get('.ac-searchtags__tag-list > :nth-child(2)')
        .should('contain', 'A1')
        cy.get('.ac-searchtags__tag-list > :nth-child(3)')
        .should('contain', '10000')
    })

    it('Tests the hide reserved cars checkbox', function (){
        cy.get('.ac-search__filters-btn').click()
        cy.get(':nth-child(3) > :nth-child(2) > .ch-checkbox > label [type="checkbox"]').not('[disabled]')
        .check({force: true}).should('be.checked')
        cy.get('.ac-filters__footer > .ch-btn').click()
        cy.get('.ac-searchtags__tag-list > :nth-child(1)').should('contain', 'Hide reserved cars')
    })

    it('Tests the product page', function (){
        cy.get(':nth-child(1) > .ac-result__content > .ac-vehicle__title > a').click()
        cy.get('.ac-vehicle__title').should('contain','Audi',)
        cy.get('.ac-vehicle__title').should('contain','A1',)
        cy.get('#content1').should('contain', 'Vehicle summary')
        cy.get('#content1').should('contain', 'Featured specification')
        cy.get('[for="tab2"]').click()
        .should('contain','Standard specification')
       
    })


    it('Verifies success respose from server', function () {
        cy.request('https://www.arnoldclark.com/used-cars/search.json')
        .then(response => {
            expect(response.status).to.eq(200)
            // expect(response.body.searchResults[0].salesInfo.pricing.cashPrice).to.be.lessThan(10000)
            // use a for loop using the above so it loops thorugh every result and it ensures none is over 10000
         })
        
    })})
