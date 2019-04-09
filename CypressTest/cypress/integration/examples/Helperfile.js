 it('checks the special offers section', function (){
    getOffersH3()
    .should('contain', 'Special offers')
 })

 function getOffersH3() {
    const price = cy.get('.ac-offers>.ch-h3.ac-maoney').innerhtml
    
}

// The above has made a function to go and find the special offers header and then in the IT statement it calls that function . 
//This makes the function reusable

function getPriceOfFirstAsset() {
    const FirstAssetprice = cy.get(':nth-child(1) > .ac-pricing > .ac-pricing__cash > .ac-money').invoke('text')
    
}

console.log(getPriceOfFirstAsset)

cy.get(':nth-child(1) > .ac-pricing > .ac-pricing__cash > .ac-money').invoke('val').then((val1) => {
    // do more work here
  
    // click the button which changes the input's value
    cy.get('.js-off--hide > #sort-order').select('Cash price (high to low)')
  
    // grab the input again and compare its previous value
    // to the current value
    cy.get('input').invoke('val').should((val2) => {
      expect(val1).not.to.eq(val2)
    })