module Artists.List (..) where

import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Artists.Models exposing (..)
import Artists.Actions exposing (..)
import Html.Events exposing (onClick, on, targetValue)


type alias ViewModel =
  { artists : List Artist
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
  div
    []
    [ table
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
        , tbody [] (List.map (artistRow address model) model.artists)
        ]
    ]


artistRow : Signal.Address Action -> ViewModel -> Artist -> Html.Html
artistRow address model artist =
  tr
    []
    [ td [] [ text (toString artist.id) ]
    , td [] [ text artist.name ]
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
