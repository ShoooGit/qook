const { event, Event } = require("jquery");

const selectboxChange = () => {
  target = document.getElementById("unit");

  selindex = document.getElementById("ingredient").selectedIndex;
  console.log(selindex);

  switch (selindex) {
    case 0:
      target.innerHTML = "個";
      break;
    case 1:
      target.innerHTML = "要素1が選択されています。<br/>";
      break;
    case 2:
      target.innerHTML = "要素2が選択されています。<br/>";
      break;
    case 3:
      target.innerHTML = "要素3が選択されています。<br/>";
      break;
    case 4:
      target.innerHTML = "要素4が選択されています。<br/>";
      break;
    case 5:
      target.innerHTML = "要素5が選択されています。<br/>";
      break;
  };
};

window.addEventListener('change',selectboxChange);