document.addEventListener("turbo:load", () => {
  initializePriceCalculator();
  initializePayJPForm();
});

document.addEventListener("turbo:render", () => {
  initializePriceCalculator();
  initializePayJPForm();
});

function initializePayJPForm() {
  const form = document.getElementById('charge-form');
  if (!form) return;

  // PAY.JPの公開キーを設定
  Payjp.setPublicKey("your_payjp_public_key");

  // カード情報入力フォームの生成
  const numberElement = Payjp.elements().create('cardNumber');
  const expiryElement = Payjp.elements().create('cardExpiry');
  const cvcElement = Payjp.elements().create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  // フォーム送信時の処理
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    Payjp.createToken(numberElement).then((response) => {
      if (response.error) {
        // エラー処理
      } else {
        // トークンをフォームに追加して送信
        const tokenField = document.createElement('input');
        tokenField.setAttribute('type', 'hidden');
        tokenField.setAttribute('name', 'payjp_token');
        tokenField.setAttribute('value', response.id);
        form.appendChild(tokenField);
        form.submit();
      }
    });
  });
}

function initializePriceCalculator() {
  // 既存のinitializePriceCalculator関数の内容
}

function resetFormFields() {
  const form = document.getElementById('charge-form');
  if (form) {
    form.reset();
  }
}