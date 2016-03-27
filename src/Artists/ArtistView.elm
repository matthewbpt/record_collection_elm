module Artists.ArtistView (..) where

import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Artists.Models exposing (..)
import Artists.Actions exposing (..)
import Html.Events exposing (onClick, on, targetValue)


type alias ViewModel =
  { artist : Artist
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
    , onClick address ListArtists
    ]
    [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]


artistView : Signal.Address Action -> ViewModel -> Html.Html
artistView address model =
  div
    []
    [ nav address model
    , div
        [ class "clearfix mb2 border" ]
        [ div [ class "left p2 mr1 border" ] [ text "Image" ]
        , div [ class "overflow-hidden" ] [ p [] [ text model.artist.name ], p [] [ text model.artist.bio ] ]
        ]
    ]
