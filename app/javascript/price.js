const priceInput = document.getElementById('item-price');
const addTaxPrice = document.getElementById('add-tax-price');
const profit = document.getElementById('profit');

priceInput.addEventListener('input', () => {
  const price = priceInput.value.trim(); // 入力の前後の空白をトリム

  // 入力が空の場合は何も表示しない
  if (price === '') {
    addTaxPrice.textContent = '';
    profit.textContent = '';
    return;
  }

  // 入力が半角数字以外の場合はNaNを表示する
  if (!/^\d+$/.test(price)) {
    addTaxPrice.textContent = 'NaN';
    profit.textContent = 'NaN';
    return;
  }

  const validPrice = parseInt(price, 10); // 価格を整数に変換
  const tax = Math.floor(validPrice * 0.1);
  const profitAmount = Math.floor(validPrice - tax);

  addTaxPrice.textContent = tax.toLocaleString();
  profit.textContent = profitAmount.toLocaleString();
});