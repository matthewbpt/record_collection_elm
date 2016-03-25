module View (..) where

import Html exposing (..)
import Dict
import Actions exposing (..)
import Models exposing (..)
import Routing
import Artists.List
import Artists.Edit
import Html.Attributes exposing (..)
import String


view : Signal.Address Action -> AppModel -> Html
view address model =
  let
    _ =
      Debug.log "model" model
  in
    div
      []
      [ flash address model
      , page address model
      ]


page : Signal.Address Action -> AppModel -> Html.Html
page address model =
  case model.routing.view of
    Routing.ArtistsView ->
      artistsPage address model

    Routing.ArtistEditView ->
      artistEditPage address model

    Routing.NotFoundView ->
      notFoundView


artistsPage : Signal.Address Action -> AppModel -> Html.Html
artistsPage address model =
  let
    viewModel =
      { artists = model.artists
      }
  in
    Artists.List.view (Signal.forwardTo address ArtistsAction) viewModel


artistEditPage : Signal.Address Action -> AppModel -> Html.Html
artistEditPage address model =
  let
    artistId =
      model.routing.routerPayload.params
        |> Dict.get "id"
        |> Maybe.withDefault ""

    maybePlayer =
      model.artists
        |> List.filter (\artist -> (toString artist.id) == artistId)
        |> List.head
  in
    case maybePlayer of
      Just artist ->
        let
          viewModel =
            { artist = artist
            }
        in
          Artists.Edit.view (Signal.forwardTo address ArtistsAction) viewModel

      Nothing ->
        notFoundView


notFoundView : Html.Html
notFoundView =
  div
    []
    [ text "Not found"
    ]


flash : Signal.Address Action -> AppModel -> Html
flash address model =
  if String.isEmpty model.errorMessage then
    span [] []
  else
    div
      [ class "bold center p2 mb2 white bg-red rounded"
      ]
      [ text model.errorMessage ]
