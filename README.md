# New Rivepod & Firestore Example

## 📄 概要

Flutter ＆ Riverpod & Firestore & Freezedを利用した簡易的な書籍メモ管理アプリサンプルになります。

### 1. 想定アーキテクチャ概要

```mermaid
flowchart LR
    id1(View) --> id2
    id2(ViewModel) --> id3
    id3(Repository) --> id4
    id4(Firestore)
```

### 2. 画面スクリーンショット

サンプル的には参考書を登録して、任意の参考書に紐づくコメントを複数件書き込む事ができるだけのシンプルなものになります。

<img src="./images/example_capture1.png" width="320"> <img src="./images/example_capture2.png" width="320">

<img src="./images/example_capture3.png" width="320"> <img src="./images/example_capture4.png" width="320">

### 3.サンプル構築の際に利用したもの

__【サンプルで利用したパッケージ】__

- flutter_riverpod:
    - 状態管理
    - https://pub.dev/packages/flutter_riverpod
- firebase_core:
    - Firebase Flutterに必要なプラグイン
    - https://pub.dev/packages/firebase_core
- cloud_firestore:
    - Cloud Firestoreを利用するために必要なプラグイン
    - https://pub.dev/packages/cloud_firestore
- build_runner:
    - コード自動生成の実行
    - https://pub.dev/packages/build_runner
- riverpod_annotation
    - `@riverpod`アノテーションの利用
    - https://pub.dev/packages/riverpod_annotation
- riverpod_generator:
    - RiverpodのおけるProviderの自動生成
    - https://pub.dev/packages/build_runner
- freezed:
    - コード生成ベースのImmutableなクラス生成
    - https://pub.dev/packages/freezed
- freezed_annotation:
    - freezedパッケージと連携して動作するアノテーションパッケージ
    - https://pub.dev/packages/freezed_annotation
- json_serializable:
    - DartのオブジェクトとJSON間の変換を自動化するコード生成パッケージ
    - https://pub.dev/packages/json_serializable
- fake_cloud_firestore:
    - Firebase Cloud Firestore のモックライブラリ
    - https://pub.dev/packages/fake_cloud_firestore

### 4. Firestoreでのデータ保持

① 参考書を管理するCollection

<img src="./images/firestore_database1.png"> 

② 参考書に紐づくコメントを管理するCollection

<img src="./images/firestore_database2.png">

## ⚠️ 注意

実装する上でのハマったポイントをいくつか列挙します。

### 1. 書籍IDに紐づくコメントを取得する際の処理

```dart
Future<List<Comment>> getComments(String bookId) async {
  final snapshot = await _firestore
    .collection('comments')
    // MEMO: このままだとエラーとなるので、インデックスを追加する必要有
    // 👉 エラーメッセージに表示されているリンクを押下して設定する
    .where('bookId', isEqualTo: bookId)
    .orderBy('createdAt', descending: true)
    .get();
  return snapshot.docs.map((doc) => Comment.fromFirestore(doc)).toList();
}
```

### 2. 書籍削除時に紐づくコメントも同時に削除する際の処理

```dart
Future<void> deleteComment(String bookId) async {
  final snapshot = await _firestore
    .collection('comments')
    .where('bookId', isEqualTo: bookId)
    .get();
  for (var doc in snapshot.docs) {
    doc.reference.delete();
  }
}
```
