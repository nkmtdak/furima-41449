// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");  // 利益を表示する要素

  priceInput.addEventListener("input", () => {
    const inputValue = parseInt(priceInput.value);
    
    // 販売手数料（10%）の計算
    const tax = Math.floor(inputValue * 0.1);
    
    // 販売利益の計算
    const salesProfit = inputValue - tax;

    // 販売手数料の表示
    addTaxPrice.innerHTML = tax;

    // 販売利益の表示
    profit.innerHTML = salesProfit;
  });
});
