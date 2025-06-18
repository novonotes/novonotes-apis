# audio_engine

AudioEngine をコントロールするための message のプロトコル。

[audio-engine-api.md](https://github.com/novonotes/audio-engine/blob/release/v0.1.0/doc/ja/audio-engine-api.md) 参照。

## 命名規則

### 1. Request / Response

サーバーアプリケーションからオーディオエンジンクライアントに向けてリクエストをなげる。つまり、Server-Sent Request や Reverse Request と呼びうるような関係になっている。

オーディオエンジンはリクエストの処理に成功すると、同一の request-id を持った Context と、対応するレスポンスデータの Body によって構成される Nam メッセージを返す。失敗すると、同一の request-id を持った Context と、 ErrorMessage の Body によって構成される Nam メッセージを返す。

### 2. Subscribe

Subscribe で始まるリクエストはイベント購読リクエストを表す。
購読が開始されると、キャンセルされるまで、オーディオエンジンはレスポンスを送りつづける。（GRPC で言う Streaming のような形）

### 3. Rt

Rt で始まるメッセージは Realtime データを表す。基本的には UDP などの専用の転送方式を用いる。
これらのメッセージ転送には [RtSession](./rt_session.proto) を使う。

## デザイン

App 側での状態の永続化・復元を可能にするため、ID 生成の責務は App 側。Engine 側は App 側からうけとった ID をそのまま用いる。
