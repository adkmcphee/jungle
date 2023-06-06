describe("Add to Cart", () => {
  beforeEach(() => {
    cy.visit("http://localhost:3000/");
  });

  it("Adds product to cart", () => {

    cy.get(':nth-child(2) > div > .button_to > .btn').click({force:true});
    cy.get('.end-0 > .nav-link').should("contain", "1");
  });
});