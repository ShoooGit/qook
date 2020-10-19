class Ingredient < ActiveHash::Base
  # 末尾1ケタが食材の単位を表すコード
  #  0: 個
  #  1: 枚
  #  2: 本
  #  3: 袋(パック)
  #  4: g(ml)
  #  5: 丁
  #  6: 杯
  #  7: 尾(切れ)
  #  8: 束
  #  9: 片
  self.data = [
    { id: 0, name: '---' }, { id: 14, name: '鶏もも肉' }, { id: 24, name: '鶏むね肉' },
    { id: 34, name: '鶏ささみ' }, { id: 44, name: '牛バラ肉' }, { id: 54, name: '豚バラ肉' },
    { id: 64, name: '豚ロース' }, { id: 72, name: 'アスパラガス' }, { id: 80, name: 'かぼちゃ' },
    { id: 90, name: 'キャベツ' }, { id: 102, name: 'きゅうり' }, { id: 112, name: 'ごぼう' },
    { id: 128, name: '小松菜' }, { id: 132, name: 'さやいんげん' }, { id: 142, name: '大根' },
    { id: 150, name: 'たけのこ' }, { id: 160, name: '玉ねぎ' }, { id: 172, name: 'とうもろこし' },
    { id: 180, name: 'トマト' }, { id: 190, name: 'なす' }, { id: 208, name: 'にら' },
    { id: 212, name: 'にんじん' }, { id: 229, name: 'にんにく' }, { id: 232, name: 'ねぎ' },
    { id: 240, name: '白菜' }, { id: 250, name: 'パプリカ' }, { id: 260, name: 'ピーマン' },
    { id: 270, name: 'ブロッコリー' }, { id: 288, name: 'ほうれん草' }, { id: 298, name: '水菜' },
    { id: 302, name: 'さつまいも' }, { id: 310, name: '里芋' }, { id: 320, name: 'じゃがいも' },
    { id: 332, name: '長芋' }, { id: 343, name: 'えのき' }, { id: 352, name: 'エリンギ' },
    { id: 363, name: 'しめじ' }, { id: 370, name: 'しいたけ' }, { id: 383, name: 'まいたけ' },
    { id: 393, name: 'マッシュルーム' }, { id: 401, name: '油揚げ' }, { id: 415, name: '豆腐' },
    { id: 423, name: '納豆' }, { id: 437, name: 'あじ' }, { id: 447, name: 'いわし' },
    { id: 457, name: 'かれい' }, { id: 467, name: 'さけ' }, { id: 477, name: 'さば' },
    { id: 487, name: 'さんま' }, { id: 496, name: 'いか' }, { id: 507, name: 'えび' },
    { id: 512, name: 'たこ(足)' }, { id: 520, name: 'あさり' }, { id: 536, name: 'かに' },
    { id: 544, name: '砂糖' }, { id: 554, name: '塩' }, { id: 564, name: '胡椒' },
    { id: 574, name: '醤油' }, { id: 584, name: 'みりん' }, { id: 594, name: '料理酒' },
    { id: 604, name: '酢' }, { id: 614, name: '味噌' }, { id: 629, name: 'カレールウ' }
  ]
end
