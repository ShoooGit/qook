# README

## アプリケーション名
・Qook

## アプリケーション概要
・冷蔵庫にある食材で調理することが可能な料理のレシピ一覧を表示する
・冷蔵庫にある食材の管理をする

## URL
・https://www.qook.site

## 利用方法(調理可能なレシピの確認)
①ユーザー登録を実施orログイン（ゲストユーザーがあります）

②調理可能な料理のレシピ一覧が表示される  
③調理したいレシピをクリック  
④調理に必要となる食材が表示される  

## 利用方法(冷蔵庫にある食材の管理)
①ユーザー登録を実施orログイン（ゲストユーザーがあります）
②右下の冷ボタンをクリック  
③冷蔵庫内の食材一覧が表示される  
④追加ボタンをクリックすると食材の入力フォームが追加される  
⑤食材の追加・削除、個数の入力をする  
⑥確定ボタンをクリックすると冷蔵庫の中身が保存される  

## 利用方法(レシピの登録)
①ユーザー登録を実施orログイン（ゲストユーザーがあります）
②ヘッダー内のレシピ登録をクリック  
③レシピ名,カロリー(任意),調理時間(任意)を入力
④料理の画像を選択する
⑤追加ボタンをクリックすると食材の入力フォームが追加される  
⑥食材の追加・削除、個数の入力をする  
⑦登録ボタンをクリックするとレシピの内容が登録される  

## 目指した課題解決
主婦や、一人暮らしで自炊をしている人たちの、  
「今日は何をつくろうかな？」、「冷蔵庫には何があったかな？」  
といった考える時間や煩わしさの解決

## 要件
・ユーザー管理機能（ゲストユーザ有）  
・レシピ一覧表示機能
　冷蔵庫にある食材で作成可能なレシピを一覧表示
・レシピ詳細表示機能
　登録済みレシピの詳細を表示。
　表示したレシピが調理可能な場合、調理実行ボタンを押下することが出来る。
・レシピ編集機能  
　登録済みレシピの内容を編集
・レシピ削除機能  
　登録済みレシピを削除
・レシピ登録機能  
　レシピを登録する
・食材管理機能  
　冷蔵庫の役割。食材の追加・削除を行う
・レスポンシブ対応（未実施）  
・AWSの使用(EC2,S3,Route53,ELB)    
・CircleCIでテスト・デプロイを自動化

## データベース設計
[![Image from Gyazo](https://i.gyazo.com/5d9e32b105523f7f593d8c59ee8f1afd.png)](https://gyazo.com/5d9e32b105523f7f593d8c59ee8f1afd)

## 画面遷移図
[![Image from Gyazo](https://i.gyazo.com/2f50937e9574a344aed93de32b74c22a.png)](https://gyazo.com/2f50937e9574a344aed93de32b74c22a)
