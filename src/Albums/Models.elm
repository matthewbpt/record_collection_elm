module Albums.Models (..) where


type alias Album =
  { id : Int
  , title : String
  , year : Int
  , artists : List Int
  , albumCoverId : Maybe Int
  }


newAlbum : Album
newAlbum =
  Album 0 "" 2016 [] Nothing
