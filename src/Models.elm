module Models (..) where

import Artists.Models exposing (Artist)
import Routing


type alias AppModel =
  { artists : List Artist
  , filter : String
  , routing : Routing.Model
  , errorMessage : String
  }


initialModel : AppModel
initialModel =
  { artists = []
  , filter = ""
  , routing = Routing.initialModel
  , errorMessage = ""
  }
