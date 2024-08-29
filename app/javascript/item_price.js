function initializePriceCalculator() {
  const priceInput = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  if (!priceInput || !addTaxPrice || !profit) return;

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

  // イベントリスナーが既に追加されていないことを確認してから追加
  if (!priceInput.dataset.listenerAdded) {
    priceInput.addEventListener("input", calculatePrice);
    priceInput.dataset.listenerAdded = "true";
  }
  
  // 初期表示のために一度計算を実行
  calculatePrice();
}

document.addEventListener("turbo:load", initializePriceCalculator);
document.addEventListener("turbo:render", initializePriceCalculator);