###  Activities:
  *  authorization
  *  initialization; default params
  *  get List of ALL playlists
  *  get Count of ALL playlists
  *  get Videos for ONE playlist
  *  get Comments for ONE playlist 
#### HELPERS (internal)
  *  get_batch
  *  process_batch


## initialize

### Functions
#### get_api_codes()
#### get_typical_values

### Params
auth.code:  once set, does not change
api:        once set, does not change

base_url:  changes with TYPE
query:  
Relatively fixed: auth.code, key, channelId, maxResults,  playlistId
Change withs activity type:  part, fields, 
Change every batch:    pageToken


