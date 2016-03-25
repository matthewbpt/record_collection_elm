module Artists.Update (..) where

import Effects exposing (Effects)
import Artists.Actions exposing (..)
import Artists.Models exposing (..)
import Artists.Effects exposing (..)
import Hop
import Task


--import Artists.Effects exposing (..)


type alias UpdateModel =
  { artists : List Artist
  }


update : Action -> UpdateModel -> ( List Artist, Effects Action )
update action model =
  case action of
    ListArtists ->
      let
        path =
          "/artists/"
      in
        ( model.artists, Effects.map HopAction (Hop.navigateTo path) )

    CreateOrUpdateArtist artist ->
      ( model.artists, createArtist artist )

    CreateOrUpdateArtistDone result ->
      case result of
        Ok artist ->
          let
            filteredArtists =
              List.filter (\a -> a.id /= artist.id) model.artists

            updatedArtists =
              artist :: filteredArtists

            fx =
              Task.succeed (EditArtist artist.id)
                |> Effects.task
          in
            ( updatedArtists, fx )

        Err error ->
          ( model.artists, Effects.none )

    EditArtist id ->
      let
        path =
          "/artist/" ++ (toString id) ++ "/edit"
      in
        ( model.artists, Effects.map HopAction (Hop.navigateTo path) )

    ArtistsFetched result ->
      case result of
        Ok artists ->
          ( artists, Effects.none )

        Err _ ->
          ( model.artists, Effects.none )

    HopAction _ ->
      ( model.artists, Effects.none )

    NoOp ->
      ( model.artists, Effects.none )
