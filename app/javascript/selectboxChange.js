const selectboxChange = (e) => {
  if (e.target.type == "select-one"){
    // イベントを発生させたセレクトボックスの親要素を基準に、子要素（単位）を取得
    target = e.target.parentNode.children[2];

    // イベントを発生させたセレクトボックスのidを取得
    selindex = e.target.value;

    // 末尾1ケタが食材の単位を表すコード
    kind = Number(selindex.slice(-1));

    console.log(e.target.type);
    console.log(kind);
    console.log(target);
    
    switch (kind) {
      case 0: 
        target.innerHTML = "個";
        break;
      case 1:
        target.innerHTML = "枚";
        break;
      case 2:
        target.innerHTML = "本";
        break;
      case 3:
        target.innerHTML = "袋(パック)";
        break;
      case 4:
        target.innerHTML = "g( ml )";
        break;
      case 5: 
        target.innerHTML = "丁";
        break;
      case 6:
        target.innerHTML = "杯";
        break;
      case 7:
        target.innerHTML = "尾(切れ)";
        break;
      case 8:
        target.innerHTML = "束";
        break;
      case 9:
        target.innerHTML = "欠片";
        break;
    };
  }
};

window.addEventListener('change',selectboxChange);
