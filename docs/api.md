# API/Endpoints/Routes

## Services

### Meta

#### `/timeline/<USER>`

This endpoint is the main entry-point into the app.

It should:

1. Find the least-loaded Web service
2. Redirect the user's brower to it

### Web

#### `/timeline/<USER>`

This is the UI/UX for the app.

It should allow the user to:

1. Post a new tweet
2. Display the user's previous tweets.

### Storage

#### `/timeline/<USER>`

This is the endpoint used by the browser app to `get` and `post` tweets.

##### `get`

It should return the user's tweets, in reverse chronological order (ie: most recent first).

##### `post`

It should accept and store a user's new tweet.
