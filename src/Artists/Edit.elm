module Artists.Edit (..) where

import Html exposing (..)
import Html.Attributes exposing (class, value, href, rows, cols)
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
    , formSortName address model
    , formBio address model
    , saveBtn address model
    ]


formName : Signal.Address Action -> ViewModel -> Html.Html
formName address model =
  div
    [ class "clearfix py1"
    ]
    [ div [ class "col col-2" ] [ text "Name" ]
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
      , on "keyup" targetValue (\str -> Signal.message address (CreateOrUpdateArtist { artist | name = str }))
      ]
      []


formSortName : Signal.Address Action -> ViewModel -> Html.Html
formSortName address model =
  div
    [ class "clearfix py1"
    ]
    [ div [ class "col col-2" ] [ text "Sort Name" ]
    , div
        [ class "col col-7" ]
        [ inputSortName address model
        ]
    ]


inputSortName : Signal.Address Action -> ViewModel -> Html.Html
inputSortName address model =
  let
    artist =
      model.artist
  in
    input
      [ class "field-light"
      , value artist.sortName
      , on "keyup" targetValue (\str -> Signal.message address (CreateOrUpdateArtist { artist | sortName = str }))
      ]
      []


formBio : Signal.Address Action -> ViewModel -> Html.Html
formBio address model =
  div
    [ class "clearfix py1" ]
    [ div [ class "col col-2" ] [ text "Bio" ]
    , div
        [ class "col col-7" ]
        [ textAreaBio address model ]
    ]


textAreaBio : Signal.Address Action -> ViewModel -> Html.Html
textAreaBio address model =
  let
    artist =
      model.artist
  in
    textarea
      [ class "clearfix py1"
      , cols 50
      , rows 5
      , value artist.bio
      , on "change" targetValue (\str -> Signal.message address (CreateOrUpdateArtist { artist | bio = str }))
      ]
      []


listBtn : Signal.Address Action -> ViewModel -> Html.Html
listBtn address model =
  button
    [ class "btn regular"
    , onClick address ListArtists
    ]
    [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]


saveBtn : Signal.Address Action -> ViewModel -> Html.Html
saveBtn address model =
  button
    [ class "btn mr1 h1 regular center"
    , onClick address (SaveArtist model.artist)
    ]
    [ i [ class "fa fa-floppy-o mr1" ] [], text "Save" ]
