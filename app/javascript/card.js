const pay = () => {
  const publicKey = gon.public_key
  const payjp = Payjp(publicKey) // PAY.JPテスト公開鍵
  const elements = payjp.elements();

  // カード番号入力欄
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  // フォーム送信処理
  const form = document.getElementById('charge-form')
  form.addEventListener('submit', (e) => {
    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
        // エラー処理
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        // トークンオブジェクトをフォームに追加
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        form.insertAdjacentHTML('beforeend', tokenObj);
      }

      // 入力欄をクリア
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
      document.getElementById("charge-form").submit();
    });

    e.preventDefault();
  });
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);