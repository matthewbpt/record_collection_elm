module Albums.Actions (..) where

import Albums.Models exposing (Album)
import Http
import Hop


type Action
  = NoOp
  | ListArtists
  | ListAlbums
  | AlbumsFetched (Result Http.Error (List Album))
  | ShowAlbum Album
  | HopAction Hop.Action
  | GoBack
