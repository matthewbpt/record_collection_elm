module Models (..) where

import Artists.Models exposing (Artist)
import Albums.Models exposing (Album)
import Routing


type alias AppModel =
  { artists : List Artist
  , albums : List Album
  , filter : String
  , routing : Routing.Model
  , errorMessage : String
  }


initialModel : AppModel
initialModel =
  { artists = []
  , albums = []
  , filter = ""
  , routing = Routing.initialModel
  , errorMessage = ""
  }
