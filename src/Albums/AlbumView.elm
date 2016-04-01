module Albums.AlbumView (..) where

import Html exposing (..)
import Html.Attributes exposing (class)
import Albums.Models exposing (Album)
import Albums.Actions exposing (..)
import Html.Events exposing (onClick)


type alias ViewModel =
  { album : Album
  }


nav : Signal.Address Action -> ViewModel -> Html.Html
nav address model =
  div
    [ class "clearfix mb2 white bg-black p1" ]
    [ listBtn address model ]


listBtn : Signal.Address Action -> ViewModel -> Html.Html
listBtn address model =
  button
    [ class "btn regular"
    , onClick address GoBack
    ]
    [ i [ class "fa fa-chevron-left mr1" ] [], text "Back" ]


albumView : Signal.Address Action -> ViewModel -> Html.Html
albumView address model =
  div
    []
    [ nav address model
    , div
        [ class "clearfix mb2 border" ]
        [ div [ class "left p2 mr1 border" ] [ text "Image" ]
        , div [ class "overflow-hidden" ] [ p [] [ text model.album.title ] ]
        ]
    ]
