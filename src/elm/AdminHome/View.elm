module AdminHome.View exposing (indexView)

-- import Common.View exposing (warningMessage)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
-- import Html.Keyed exposing (..)
import Messages exposing (..)
import AdminHome.Messages exposing (..)
import Model exposing (..)

import Routing exposing (..)

indexView : Model -> Html Msg
indexView model =
    div
        [ id "admin_index" ]
        (viewContent model)


viewContent : Model -> List (Html Msg)
viewContent model =
    [ div []
        [ text "New Poll Description JSON : "
        , textarea [ cols 40
                   , rows 10
                   , placeholder "..."
                   , onInput <| raiseLocalInputMsg HandlePollDescriptionInput
                   ]
            []
        ]
    , input [ type_ "button", value "Create Poll", onClick <| AdminHomeMsg HandleCreatePollSubmit ]
        []
    , input [ type_ "button", value "Return to Home", onClick <| NavigateTo HomeIndexRoute ]
        []
    ]

raiseLocalInputMsg: (String -> AdminHomeMsgType) -> (String -> Msg)
raiseLocalInputMsg msg =
    \x -> AdminHomeMsg (msg x)
