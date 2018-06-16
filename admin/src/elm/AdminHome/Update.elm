module AdminHome.Update exposing (update)

import Messages exposing (..)
import AdminHome.Messages exposing (..)
import Model exposing (..)


update : AdminHomeMsgType -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HandlePollDescriptionInput value ->
            let
                pm = model.pollModel
                newPollModel = { pm | jsonDescription = value }
            in
                { model | pollModel = newPollModel } ! []

        HandleCreatePollSubmit ->
            model ! []
