module Albums.Update (..) where

import Effects exposing (Effects)
import Albums.Actions exposing (..)
import Albums.Models exposing (..)
import Hop
import History
import Task


--import Albums.Effects exposing (..)
--import Hop
--import Task


type alias UpdateModel =
  { albums : List Album }


update : Action -> UpdateModel -> ( UpdateModel, Effects Action )
update action model =
  case action of
    ListArtists ->
      let
        path =
          "/artists/"
      in
        ( model, Effects.map HopAction (Hop.navigateTo path) )

    ListAlbums ->
      let
        path =
          "/albums/"
      in
        ( model, Effects.map HopAction (Hop.navigateTo path) )

    AlbumsFetched result ->
      case result of
        Ok albums ->
          ( { model | albums = albums }, Effects.none )

        Err error ->
          ( model, Effects.none )

    ShowAlbum album ->
      let
        path =
          "/album/" ++ album.title
      in
        ( model, Effects.map HopAction (Hop.navigateTo path) )

    HopAction _ ->
      ( model, Effects.none )

    GoBack ->
      let
        fx =
          Task.andThen History.back (\_ -> Task.succeed NoOp)
            |> Effects.task
      in
        ( model, fx )

    NoOp ->
      ( model, Effects.none )
