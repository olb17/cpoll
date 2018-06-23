module AdminHome.Update exposing (update)

import Messages exposing (..)
import AdminHome.Messages exposing (..)
import Model exposing (..)
import Server

update : AdminHomeMsgType -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HandlePollDescriptionInput value ->
            { model | jsonDescription = value } ! []

        HandleCreatePollSubmit ->
            Server.handleCreatePoll model
