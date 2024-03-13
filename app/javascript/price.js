window.addEventListener('turbo:load', () => {
const priceInput = document.getElementById('item-price');
const addTaxPrice = document.getElementById('add-tax-price');
const profit = document.getElementById('profit');

// item-price 要素が存在しない場合は処理を中止
if (!priceInput) {
  return;
}

// イベントリスナーを削除
priceInput.removeEventListener('input', listener);

// イベントリスナーを追加
priceInput.addEventListener('input', listener);

// `listener` 関数は必要に応じて修正してください
function listener() {
  const price = priceInput.value.trim(); // 入力の前後の空白をトリム

  // 入力が空の場合は何も表示しない
  if (price === '') {
    addTaxPrice.textContent = '';
    profit.textContent = '';
    return;
  }

  // 入力が半角数字以外の場合はNaNを表示するu89yh978
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
};
});