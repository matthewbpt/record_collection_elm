module Albums.Update (..) where

import Effects exposing (Effects)
import Albums.Actions exposing (..)
import Albums.Models exposing (..)


--import Albums.Effects exposing (..)
--import Hop
--import Task


type alias UpdateModel =
  { albums : List Album }


update : Action -> UpdateModel -> ( UpdateModel, Effects Action )
update action model =
  case action of
    AlbumsFetched result ->
      case result of
        Ok albums ->
          ( { model | albums = albums }, Effects.none )

        Err error ->
          ( model, Effects.none )

    NoOp ->
      ( model, Effects.none )
