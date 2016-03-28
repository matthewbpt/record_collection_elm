module Artists.Models (..) where


type alias Artist =
  { id : Int
  , name : String
  , bio : String
  , sortName :
      String
  , imageId : Maybe Int
  }


newArtist : Artist
newArtist =
  Artist 0 "New Artist" "" "" (Nothing)
