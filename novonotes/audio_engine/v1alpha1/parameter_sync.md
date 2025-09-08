# ParameterSync のシーケンス

以下は ParameterSync の開始から終了までのシーケンス図。
AudioMixer の Volume フェーダーのドラッグフェーダーのによってパラメーターを操作するユースケースの例です。

画像: https://github.com/user-attachments/assets/e838c424-5143-4f1b-9be0-c8160d40bfde

```mermaid
sequenceDiagram
    autonumber
    participant User
    participant App
    participant Engine

    User->>App: AudioMixer を操作するページへ遷移
    App->>Engine: StartParameterSyncRequest（セッション ID を送る）
    Engine->>App: Response
    App->>User: AudioMixer のページを表示

                rect rgba(173, 216, 230, 0.2)
            note over App,Engine: UDP
    User->>App: フェーダーのドラッグ
    App->>Engine: Update コマンド（再送処理なし）
    Engine->>App: RtParameter （UPDATING、変更がない場合も1秒に一回程度定期的に送信）
    App->>User: フェーダーのインディケーター表示位置を更新
    User->>App: フェーダーのドラッグ終了

    App->>Engine: Finalize コマンド（ドラッグ終了時など。FINALIZED の state が帰ってこない場合再送）
    Engine->>App: RtParameter（FINALIZED、変更がない場合も1秒に一回程度定期的に送信）
    App->>User: フェーダーのインディケーター表示位置を更新
            end
    User->>App: AudioMixer のページ外へ遷移
    App->>Engine: StopParameterSyncRequest
    Engine->>App: Response
    App->>User: 別ページを表示
```
