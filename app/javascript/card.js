const pay = () => {
  const payjp = Payjp('pk_test_c0c6e8cccbfdc04df5a8f897')// PAY.JPテスト公開鍵
  const form = document.getElementById('charge-form')
  form.addEventListener("submit", (e) => {
    console.log("フォーム送信時にイベント発火")
    e.preventDefault();
  });
};

window.addEventListener("turbo:load", pay);