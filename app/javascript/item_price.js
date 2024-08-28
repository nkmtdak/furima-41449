document.addEventListener('DOMContentLoaded', () => {
  const priceInput = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  const calculatePrice = () => {
    const price = parseInt(priceInput.value);

    if (isNaN(price) || price < 300 || price > 9999999) {
      addTaxPrice.textContent = '---';
      profit.textContent = '---';
      return;
    }

    // 販売手数料（10%）の計算
    const fee = Math.floor(price * 0.1);
    
    // 販売利益の計算
    const salesProfit = price - fee;

    // 販売手数料の表示
    addTaxPrice.textContent = fee.toLocaleString();

    // 販売利益の表示
    profit.textContent = salesProfit.toLocaleString();
  };

  priceInput.addEventListener("input", calculatePrice);
  
  // 初期表示のために一度計算を実行
  calculatePrice();
});