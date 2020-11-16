function changeUnit(selectBox) {
  // イベントを発生させたセレクトボックスの親要素を基準に、子要素（単位）を取得
  unit = selectBox.parentNode.children[2];

  // イベントを発生させたセレクトボックスのidを取得
  selindex = selectBox.value;

  // idの末尾1ケタが食材の単位を表すコード
  kind = Number(selindex.slice(-1));

  // 単位を変更
  switch (kind) {
    case 0: 
      unit.innerHTML = "個";
      break;
    case 1:
      unit.innerHTML = "枚";
      break;
    case 2:
      unit.innerHTML = "本";
      break;
    case 3:
      unit.innerHTML = "袋(パック)";
      break;
    case 4:
      unit.innerHTML = "g( ml )";
      break;
    case 5: 
      unit.innerHTML = "丁";
      break;
    case 6:
      unit.innerHTML = "杯";
      break;
    case 7:
      unit.innerHTML = "尾(切れ)";
      break;
    case 8:
      unit.innerHTML = "束";
      break;
    case 9:
      unit.innerHTML = "欠片";
      break;
  };
};

function defaultUnit() {
  // 単位を全て取得
  const ingredientList = document.querySelectorAll(".select-box");

  // 取得した単位分ループ
  ingredientList.forEach( ingredient => changeUnit(ingredient) );
};

function selectUnit(e) {
  if (e.target.type == "select-one"){
    changeUnit(e.target);
  }
};


// 初期表示のタイミングで、セレクトボックスで選択した値に応じた単位を表示する
window.addEventListener('turbolinks:load',defaultUnit);

// セレクトボックスが選択されたタイミングで、選択した値に応じた単位を表示する
window.addEventListener('change',selectUnit);