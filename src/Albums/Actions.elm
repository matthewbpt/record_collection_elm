module Albums.Actions (..) where

import Albums.Models exposing (Album)
import Http


type Action
  = NoOp
  | AlbumsFetched (Result Http.Error (List Album))
