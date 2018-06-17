module Update exposing (..)

-- import Debug

import Routing exposing (Route(..), parse, toPath)
import Messages exposing (..)
import Model exposing (..)
import Navigation

import AdminHome.Update
import OpeningPoll.Update

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AdminHomeMsg adminHomeMsgType ->
            AdminHome.Update.update adminHomeMsgType model
        
        OpeningPollMsg openingPollMsgType ->
            OpeningPoll.Update.update openingPollMsgType model

        UrlChange location ->
            let
                currentRoute = parse location
            in
                urlUpdate { model | route = currentRoute }

        NavigateTo route ->
            model ! [ Navigation.newUrl <| toPath route ]


urlUpdate : Model -> ( Model, Cmd Msg )
urlUpdate model =
    case model.route of
        AdminHomeRoute ->
            model ! []

        _ ->
            model ! []
