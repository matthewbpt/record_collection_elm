module Artists.List (..) where

import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Artists.Models exposing (..)
import Artists.Actions exposing (..)
import Html.Events exposing (onClick, on, targetValue)
import String exposing (contains, toLower)


type alias ViewModel =
  { artists : List Artist
  , filter : String
  }


view : Signal.Address Action -> ViewModel -> Html.Html
view address model =
  div
    []
    [ nav address model
    , list address model
    ]


nav : Signal.Address Action -> ViewModel -> Html.Html
nav address model =
  div
    [ class "clearfix mb2 white bg-black" ]
    [ div [ class "left p2" ] [ text "Artists" ]
    , div [ class "right p1" ] [ addBtn address model ]
    ]


list : Signal.Address Action -> ViewModel -> Html.Html
list address model =
  let
    filteredArtists =
      if model.filter == "" then
        model.artists
      else
        List.filter (\artist -> contains (toLower model.filter) (toLower artist.name)) model.artists

    sortedArtists =
      List.sortBy .sortName filteredArtists
  in
    div
      []
      [ formFilter address model
      , table
          [ class "table-light" ]
          [ thead
              []
              [ tr
                  []
                  [ th [] [ text "Id" ]
                  , th [] [ text "Name" ]
                  , th [] [ text "Actions" ]
                  ]
              ]
          , tbody [] (List.map (artistRow address model) sortedArtists)
          ]
      ]


artistRow : Signal.Address Action -> ViewModel -> Artist -> Html.Html
artistRow address model artist =
  tr
    []
    [ td [] [ text (toString artist.id) ]
    , td [ onClick address (ShowArtist artist) ] [ text artist.name ]
    , td
        []
        [ editBtn address artist
        , deleteBtn address artist
        ]
    ]


editBtn : Signal.Address Action -> Artist -> Html.Html
editBtn address artist =
  button
    [ class "btn regular"
    , onClick address (EditArtist artist.id)
    ]
    [ i [ class "fa fa-pencil mr1" ] [], text "Edit" ]



--viewBtn : Signal.Address Action -> Artist -> Html.Html
--viewBtn address artist =
--  [ class "btm regular"
--  , onClick address (NoOp)
--  ]
--    [ i [ class "fa " ] ]


addBtn : Signal.Address Action -> ViewModel -> Html.Html
addBtn address model =
  button
    [ class "btn", onClick address (CreateOrUpdateArtist new) ]
    [ i [ class "fa fa-user-plus mr1" ] []
    , text "Add artist"
    ]


deleteBtn : Signal.Address Action -> Artist -> Html.Html
deleteBtn address artist =
  button
    [ class "btn regular mr1"
    , onClick address (NoOp)
    ]
    [ i [ class "fa fa-trash mr1" ] [], text "Delete" ]


formFilter : Signal.Address Action -> ViewModel -> Html.Html
formFilter address model =
  div
    [ class "clearfix py1" ]
    [ div [ class "col col-2" ] [ text "Filter" ]
    , div
        [ class "col col-2" ]
        [ inputFilter address model ]
    ]


inputFilter : Signal.Address Action -> ViewModel -> Html.Html
inputFilter address model =
  let
    filter =
      model.filter
  in
    input
      [ class "field-light"
      , value filter
      , on "keyup" targetValue (\str -> Signal.message address (FilterArtists str))
      ]
      []
