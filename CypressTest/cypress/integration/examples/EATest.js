describe('my first test', function () {
    it('makes an assertion', function (){
        cy.visit('https://example.cypress.io')
        cy.contains('type').click()
 

        cy.url()
        .should('include', '/commands/actions')

        cy.get('#email1')
        .type('fake@email.com')
        .should('have.value', 'fake@email.com')

        cy.get('.action-select').select('apples')

        
    })
    cy.get('[data-reactroot=""]>:nth-child(1) > .ch-form__control').select('Audi')
    cy.get('h2.ac-vehicle__title').each(($make, i, $makes) => {
   expect($makes).to.contain('Audi');
} ) 