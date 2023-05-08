# Data Model

## Entities

### Tweet

A tweet shall be represented in the JSON format as a map:

```json
{
    "username": STRING,
    "timestamp": EPIC
}
```

### Timeline

A timeline shall be represented in the JSON as a `list` of tweets:

```json
[
    TWEET-NEWEST,
    TWEET-OLDER,
    TWEET-OLDEST
]
```