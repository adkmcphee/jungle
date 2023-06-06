describe("Product Details Page", () => {
  beforeEach(() => {
    cy.visit("http://localhost:3000/");
  });

  it("Navigates to product detail page", () => {
    cy.get(".products article").first().find("a").click();

    cy.get(".product-detail").should("be.visible");
  });
});