module Albums.Effects (..) where

import Effects exposing (Effects)
import Http
import Task
import Albums.Models exposing (Album)
import Albums.Actions exposing (..)
import Json.Decode as Decode exposing ((:=))
import Json.Decode.Extra exposing ((|:))
import Json.Encode as Encode


fetchAllUrl : String
fetchAllUrl =
  "/api/albums"


fetchAll : Effects Action
fetchAll =
  Http.get albumCollectionDecoder fetchAllUrl
    |> Task.toResult
    |> Task.map AlbumsFetched
    |> Effects.task



-- DECODERS


albumCollectionDecoder : Decode.Decoder (List Album)
albumCollectionDecoder =
  Decode.list albumDecoder


albumDecoder : Decode.Decoder Album
albumDecoder =
  Decode.succeed Album
    |: ("id" := Decode.int)
    |: ("title" := Decode.string)
    |: ("year" := Decode.int)
    |: ("artists" := Decode.list Decode.int)
    |: (Decode.maybe ("album-cover-id" := Decode.int))
