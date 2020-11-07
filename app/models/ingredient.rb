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

  # 最終振り出しは75

  self.data = [
    { id: 0, name: '---', unit: '個' }, { id: 660, name: '卵', unit: '個' }, { id: 14, name: '鶏もも肉', unit: 'g(ml)' },
    { id: 24, name: '鶏むね肉', unit: 'g(ml)' }, { id: 34, name: '鶏ささみ', unit: 'g(ml)' }, { id: 44, name: '牛バラ肉', unit: 'g(ml)' },
    { id: 54, name: '豚バラ肉', unit: 'g(ml)' }, { id: 64, name: '豚ロース', unit: 'g(ml)' }, { id: 711, name: '豚ロース(とんかつ用)', unit: '枚' },
    { id: 724, name: '合挽き肉', unit: 'g(ml)' },{ id: 750, name: 'こんにゃく', unit: '個' },
    { id: 72, name: 'アスパラガス', unit: '本' }, { id: 80, name: 'かぼちゃ', unit: '個' }, { id: 90, name: 'キャベツ', unit: '個' },
    { id: 102, name: 'きゅうり', unit: '本' }, { id: 112, name: 'ごぼう', unit: '本' }, { id: 128, name: '小松菜', unit: '束' },
    { id: 132, name: 'さやいんげん', unit: '本' }, { id: 142, name: '大根', unit: '本' }, { id: 150, name: 'たけのこ', unit: '個' },
    { id: 160, name: '玉ねぎ', unit: '個' }, { id: 172, name: 'とうもろこし', unit: '本' }, { id: 180, name: 'トマト', unit: '個' },
    { id: 190, name: 'なす', unit: '個' }, { id: 208, name: 'にら', unit: '束' }, { id: 212, name: 'にんじん', unit: '本' },
    { id: 229, name: 'にんにく', unit: '片' }, { id: 232, name: 'ねぎ', unit: '本' }, { id: 240, name: '白菜', unit: '個' },
    { id: 250, name: 'パプリカ', unit: '個' }, { id: 260, name: 'ピーマン', unit: '個' }, { id: 673, name: 'もやし', unit: '袋(パック)' },
    { id: 270, name: 'ブロッコリー', unit: '個' }, { id: 288, name: 'ほうれん草', unit: '束' }, { id: 298, name: '水菜', unit: '束' },
    { id: 302, name: 'さつまいも', unit: '本' }, { id: 310, name: '里芋', unit: '個' }, { id: 320, name: 'じゃがいも', unit: '個' },
    { id: 332, name: '長芋', unit: '本' }, { id: 343, name: 'えのき', unit: '袋(パック)' }, { id: 352, name: 'エリンギ', unit: '本' },
    { id: 363, name: 'しめじ', unit: '袋(パック)' }, { id: 370, name: 'しいたけ', unit: '個' }, { id: 383, name: 'まいたけ', unit: '袋(パック)' },
    { id: 393, name: 'マッシュルーム', unit: '袋(パック)' }, { id: 401, name: '油揚げ', unit: '枚' }, { id: 415, name: '豆腐', unit: '丁' },
    { id: 423, name: '納豆', unit: '袋(パック)' }, { id: 437, name: 'あじ', unit: '尾(切れ)' }, { id: 447, name: 'いわし', unit: '尾(切れ)' },
    { id: 457, name: 'かれい', unit: '尾(切れ)' }, { id: 467, name: 'さけ', unit: '尾(切れ)' }, { id: 477, name: 'さば', unit: '尾(切れ)' },
    { id: 657, name: 'ぶり', unit: '尾(切れ)' }, { id: 487, name: 'さんま', unit: '尾(切れ)' }, { id: 496, name: 'いか', unit: '杯' },
    { id: 507, name: 'えび', unit: '尾(切れ)' }, { id: 512, name: 'たこ(足)', unit: '本' }, { id: 520, name: 'あさり', unit: '個' },
    { id: 536, name: 'かに', unit: '杯' }, { id: 544, name: '砂糖', unit: 'g(ml)' }, { id: 554, name: '塩', unit: 'g(ml)' },
    { id: 564, name: '胡椒', unit: 'g(ml)' }, { id: 574, name: '醤油', unit: 'g(ml)' }, { id: 704, name: 'コンソメ', unit: 'g(ml)' },
    { id: 684, name: 'ウスターソース', unit: 'g(ml)' }, { id: 694, name: 'ケチャップ', unit: 'g(ml)' },
    { id: 584, name: 'みりん', unit: 'g(ml)' }, { id: 594, name: '料理酒', unit: 'g(ml)' }, { id: 604, name: '酢', unit: 'g(ml)' },
    { id: 614, name: '味噌', unit: 'g(ml)' }, { id: 629, name: 'カレールウ', unit: '片' }, { id: 634, name: '水', unit: 'g(ml)' },
    { id: 644, name: 'ほんだし', unit: 'g(ml)' }, { id: 734, name: 'パン粉', unit: 'g(ml)' }, { id: 744, name: '牛乳', unit: 'g(ml)' }
  ]
end
