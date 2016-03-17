module Artists.Actions (..) where

import Artists.Models exposing (Artist)
import Hop
import Http


type Action
  = NoOp
  | ListArtists
  | CreateArtist
  | CreateArtistDone (Result Http.Error Artist)
  | EditArtist Int
  | ArtistsFetched (Result Http.Error (List Artist))
  | HopAction Hop.Action
