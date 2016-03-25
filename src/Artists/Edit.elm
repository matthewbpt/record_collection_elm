module Artists.Edit (..) where

import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Artists.Models exposing (..)
import Artists.Actions exposing (..)
import Html.Events exposing (onClick, on, targetValue)


type alias ViewModel =
  { artist : Artist
  }


view : Signal.Address Action -> ViewModel -> Html.Html
view address model =
  div
    []
    [ nav address model
    , form address model
    ]


nav : Signal.Address Action -> ViewModel -> Html.Html
nav address model =
  div
    [ class "clearfix mb2 white bg-black p1" ]
    [ listBtn address model ]


form : Signal.Address Action -> ViewModel -> Html.Html
form address model =
  div
    [ class "m3" ]
    [ h1 [] [ text model.artist.name ]
    , formName address model
    ]



--btnLevelDecrease : Signal.Address Action -> ViewModel -> Html.Html
--btnLevelDecrease address model =
--  a
--    [ class "btn ml1 h1" ]
--    [ i
--        [ class "fa fa-minus-circle"
--        , onClick address (ChangeLevel model.artist.id -1)
--        ]
--        []
--    ]
--btnLevelIncrease : Signal.Address Action -> ViewModel -> Html.Html
--btnLevelIncrease address model =
--  a
--    [ class "btn ml1 h1" ]
--    [ i
--        [ class "fa fa-plus-circle"
--        , onClick address (ChangeLevel model.artist.id 1)
--        ]
--        []
--    ]


formName : Signal.Address Action -> ViewModel -> Html.Html
formName address model =
  div
    [ class "clearfix py1"
    ]
    [ div [ class "col col-5" ] [ text "Name" ]
    , div
        [ class "col col-7" ]
        [ inputName address model
        ]
    ]


inputName : Signal.Address Action -> ViewModel -> Html.Html
inputName address model =
  let
    artist =
      model.artist
  in
    input
      [ class "field-light"
      , value artist.name
      , on "change" targetValue (\str -> Signal.message address (CreateOrUpdate { artist | name = str }))
      ]
      []


listBtn : Signal.Address Action -> ViewModel -> Html.Html
listBtn address model =
  button
    [ class "btn regular"
    , onClick address ListArtists
    ]
    [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]
