module Artists.Models (..) where


type alias Artist =
  { id : Int
  , name : String
  , bio : String
  , sortName :
      String
  , imageId : Maybe Int
  }


new : Artist
new =
  Artist 0 "" "" "" (Just 0)
