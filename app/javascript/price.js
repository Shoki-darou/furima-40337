  // 価格の入力フィールド
  const priceInput = document.getElementById('item-price');
  // 販売手数料の表示要素
  const addTaxPrice = document.getElementById('add-tax-price');
  // 販売利益の表示要素
  const profit = document.getElementById('profit');

  // 入力フィールドにinputイベントリスナーを追加
  priceInput.addEventListener('input', () => {
    // 入力された価格を取得
    const price = priceInput.value;
    // 販売手数料を計算（価格の10%）
    const tax = Math.floor(price * 0.1);
    // 販売利益を計算（価格から販売手数料を引いた金額）
    const profitAmount = price - tax;

    // 販売手数料と販売利益をHTMLに反映
    addTaxPrice.textContent = tax.toLocaleString();
    profit.textContent = profitAmount.toLocaleString();
  });