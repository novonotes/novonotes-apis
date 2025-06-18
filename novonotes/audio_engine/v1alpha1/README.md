# audio_engine

Protocol for messages to control AudioEngine.

See [audio-engine-api.md](https://github.com/novonotes/audio-engine/blob/release/v0.1.0/doc/ja/audio-engine-api.md).

## Naming Conventions

### 1. Request / Response

Requests are sent from the server application to the audio engine client. This creates what could be called a Server-Sent Request or Reverse Request relationship.

When the audio engine successfully processes a request, it returns a Nam message composed of a Context with the same request-id and a Body containing the corresponding response data. On failure, it returns a Nam message composed of a Context with the same request-id and a Body containing an ErrorMessage.

### 2. Subscribe

Requests beginning with Subscribe represent event subscription requests.
Once a subscription is started, the audio engine continues to send responses until cancelled. (Similar to Streaming in gRPC)

### 3. Rt

Messages beginning with Rt represent Realtime data. They typically use dedicated transport methods such as UDP.
These messages are transferred using [RtSession](./rt_session.proto).

## Design

To enable state persistence and restoration on the App side, ID generation is the responsibility of the App. The Engine uses IDs received from the App as-is.