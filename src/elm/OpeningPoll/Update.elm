module OpeningPoll.Update exposing (update)

import Messages exposing (..)
import OpeningPoll.Messages exposing (..)
import Model exposing (..)


update : OpeningPollMsgType -> Model -> ( Model, Cmd Msg )
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
