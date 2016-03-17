module Models (..) where

import Artists.Models exposing (Artist)
import Routing


type alias AppModel =
  { artists : List Artist
  , routing : Routing.Model
  , errorMessage : String
  }


initialModel : AppModel
initialModel =
  { artists = []
  , routing = Routing.initialModel
  , errorMessage = ""
  }
