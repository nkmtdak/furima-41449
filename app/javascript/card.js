const initializePayJP = (publicKey) => {
  if (!publicKey) {
    console.error("Public key is not set");
    return null;
  }
  return Payjp(publicKey, { debug: true });
};

const createCardElements = (payjp) => {
  const elements = payjp.elements();
  return {
    number: elements.create('cardNumber'),
    expiry: elements.create('cardExpiry'),
    cvc: elements.create('cardCvc')
  };
};

const mountCardElements = (elements) => {
  ['number', 'expiry', 'cvc'].forEach(type => {
    const element = document.getElementById(`${type}-form`);
    if (element) {
      elements[type].mount(`#${type}-form`);
      console.log(`${type} element mounted successfully`);
    } else {
      console.error(`${type}-form element not found`);
    }
  });
};

const handlePaymentSubmission = (payjp, elements, form) => {
  form.addEventListener("submit", async (e) => {
    e.preventDefault();
    try {
      const response = await payjp.createToken(elements.number);
      if (response.error) {
        throw new Error(response.error.message);
      }
      const tokenInput = `<input value=${response.id} name='token' type="hidden">`;
      form.insertAdjacentHTML("beforeend", tokenInput);
      Object.values(elements).forEach(element => element.clear());
      form.submit();
    } catch (error) {
      console.error("Payment error:", error);
      alert(`カード情報が正しくありません: ${error.message}`);
    }
  });
};

const pay = () => {
  console.log("pay function called");
  const publicKey = gon.public_key;
  console.log("Public Key:", publicKey);

  const payjp = initializePayJP(publicKey);
  if (!payjp) return;

  const elements = createCardElements(payjp);
  mountCardElements(elements);

  const form = document.getElementById('charge-form');
  if (!form) {
    console.error("Charge form not found. Make sure the form has the ID 'charge-form'");
    return;
  }

  handlePaymentSubmission(payjp, elements, form);
};

const initializePay = () => {
  console.log("initializePay called");
  const chargeForm = document.getElementById('charge-form');
  if (chargeForm && !chargeForm.dataset.payInitialized) {
    console.log("charge-form found and initializing");
    pay();
    chargeForm.dataset.payInitialized = 'true';
  } else if (!chargeForm) {
    console.log("charge-form not found");
  } else {
    console.log("charge-form already initialized");
  }
};

document.addEventListener("turbo:load", initializePay);
document.addEventListener("turbo:render", initializePay);