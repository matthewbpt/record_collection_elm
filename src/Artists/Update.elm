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
  , filter : String
  }


update : Action -> UpdateModel -> ( UpdateModel, Effects Action )
update action model =
  case action of
    ListArtists ->
      let
        path =
          "/artists/"
      in
        ( model, Effects.map HopAction (Hop.navigateTo path) )

    CreateOrUpdateArtist artist ->
      ( model, createArtist artist )

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

            updatedModel =
              { artists = updatedArtists, filter = model.filter }
          in
            ( updatedModel, fx )

        Err error ->
          ( model, Effects.none )

    EditArtist id ->
      let
        path =
          "/artist/" ++ (toString id) ++ "/edit"
      in
        ( model, Effects.map HopAction (Hop.navigateTo path) )

    ShowArtist artist ->
      let
        path =
          "/artist/" ++ artist.name
      in
        ( model, Effects.map HopAction (Hop.navigateTo path) )

    ArtistsFetched result ->
      case result of
        Ok artists ->
          ( { artists = artists, filter = model.filter }, Effects.none )

        Err _ ->
          ( model, Effects.none )

    FilterArtists filter ->
      ( { artists = model.artists, filter = filter }, Effects.none )

    HopAction _ ->
      ( model, Effects.none )

    NoOp ->
      ( model, Effects.none )
