module Home.Update exposing (update)

import Messages exposing (..)
import Home.Messages exposing (..)
import Model exposing (..)
import Ports exposing (..)
import Server

update : HomeMsgType -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HandlePollInput value ->
            if String.isEmpty(value)
            then
                { model | poll = Nothing } ! []
            else
                { model | poll = Just value } ! []

        HandleUsernameInput value ->
            if String.isEmpty(value)
            then
                { model | username = Nothing } ! [setUsername ""]
            else
                { model | username = Just value } ! [setUsername value]

        HandlePollSubmit ->
            Server.handlePollSubmit model
