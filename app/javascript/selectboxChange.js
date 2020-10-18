const { event, Event } = require("jquery");

const selectboxChange = (e) => {
  // イベントを発生させたセレクトボックスの親要素を基準に、子要素（単位）を取得
  target = e.target.parentNode.children[2];

  // イベントを発生させたセレクトボックスのidを取得
  selindex = e.target.selectedIndex;

  switch (selindex) {
    case 0: 
      target.innerHTML = "個";
      break;
    case 1:
      target.innerHTML = "g";
      break;
    case 2:
      target.innerHTML = "要素2が選択されています。<br/>";
      break;
  };
};

window.addEventListener('change',selectboxChange);
