function item_price () {
  const printInput = document.getElementById("item-price")
  printInput.addEventListener('input', () => {
    const inputValue = printInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");
    addTaxDom.innerHTML = (Math.floor(inputValue / 10)).toLocaleString();
    profitDom.innerHTML = (inputValue - Math.floor(inputValue / 10)).toLocaleString();
  });
}

window.addEventListener('load', item_price)