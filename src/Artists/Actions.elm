module Artists.Actions (..) where

import Artists.Models exposing (Artist)
import Albums.Models exposing (Album)
import Hop
import Http


type Action
  = NoOp
  | ListArtists
  | ListAlbums
  | CreateOrUpdateArtist Artist
  | SaveArtist Artist
  | SaveArtistDone (Result Http.Error Artist)
  | EditArtist Artist
  | ArtistsFetched (Result Http.Error (List Artist))
  | HopAction Hop.Action
  | ShowArtist Artist
  | FilterArtists String
  | DeleteArtist Artist
  | DeleteArtistDone (Result Http.Error Artist)
  | ShowAlbum Album
