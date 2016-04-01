module Albums.List (..) where

import Html exposing (..)
import Html.Attributes exposing (class, value, href, style)
import Albums.Models exposing (..)
import Albums.Actions exposing (..)
import Html.Events exposing (onClick, on, targetValue)


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
    , list address ShowAlbum model
    ]


pointerStyle : Attribute
pointerStyle =
  style [ ( "cursor", "pointer" ) ]


nav : Signal.Address Action -> ViewModel -> Html.Html
nav address model =
  div
    [ class "clearfix mb2 white bg-black" ]
    [ div [ class "left p2", pointerStyle, onClick address ListArtists ] [ text "Artists" ]
    , div [ class "left p2", pointerStyle, onClick address ListAlbums ] [ text "Albums" ]
    ]


list : Signal.Address a -> ({ c | title : String, year : b } -> a) -> { d | albums : List { c | title : String, year : b } } -> Html
list address clickAction model =
  div
    []
    [ table
        [ class "table-light" ]
        [ thead
            []
            [ tr
                []
                [ th [] [ text "Titles" ]
                , th [] [ text "Artist" ]
                , th [] [ text "Year" ]
                ]
            ]
        , tbody [] (List.map (albumRow address clickAction model) model.albums)
        ]
    ]


albumRow : Signal.Address a -> ({ c | title : String, year : b } -> a) -> d -> { c | title : String, year : b } -> Html
albumRow address clickAction model album =
  tr
    [ style [ ( "cursor", "pointer" ) ]
    , onClick address (clickAction album)
    ]
    [ td [] [ text album.title ]
    , td [] [ text "some artist" ]
    , td [] [ text (toString album.year) ]
    ]
