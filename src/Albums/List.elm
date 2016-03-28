module Albums.List (..) where

import Html exposing (..)
import Html.Attributes exposing (class, value, href, style)
import Albums.Models exposing (..)
import Albums.Actions exposing (..)


--import Html.Events exposing (onClick, on, targetValue)
--import String exposing (contains, toLower)


type alias ViewModel =
  { albums : List Album
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
    [ div [ class "left p2" ] [ text "Albums" ]
      --, div [ class "right p1" ] [ addBtn address model ]
    ]


genericAlbumList : ViewModel -> Html.Html
genericAlbumList model =
  div
    []
    [ table
        [ class "table-light" ]
        [ thead
            []
            [ tr
                []
                [ th [] [ text "Title" ]
                , th [] [ text "Artist" ]
                , th [] [ text "Year" ]
                ]
            ]
        , tbody [] (List.map (genericAlbumRow model) model.albums)
        ]
    ]


list : Signal.Address Action -> ViewModel -> Html.Html
list address model =
  genericAlbumList model



--div
--  []
--  [ table
--      [ class "table-light" ]
--      [ thead
--          []
--          [ tr
--              []
--              [ th [] [ text "Title" ]
--              , th [] [ text "Artist" ]
--              , th [] [ text "Year" ]
--              ]
--          ]
--      , tbody [] (List.map (albumRow address model) model.albums)
--      ]
--  ]


genericAlbumRow : ViewModel -> Album -> Html
genericAlbumRow model album =
  tr
    [ style [ ( "cursor", "pointer" ) ] ]
    [ td [] [ text album.title ]
    , td [] [ text "some artist" ]
    , td [] [ text (toString album.year) ]
    ]


albumRow : Signal.Address Action -> ViewModel -> Album -> Html
albumRow address model album =
  tr
    [ style [ ( "cursor", "pointer" ) ] ]
    [ td [] [ text album.title ]
    , td [] [ text "some artist" ]
    , td [] [ text (toString album.year) ]
    ]
