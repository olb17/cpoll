module OpeningPoll.View exposing (indexView)

-- import Common.View exposing (warningMessage)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
-- import Html.Keyed exposing (..)
import Messages exposing (..)
import OpeningPoll.Messages exposing (..)
import Model exposing (..)

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
    ]

raiseLocalInputMsg: (String -> OpeningPollMsgType) -> (String -> Msg)
raiseLocalInputMsg msg =
    \x -> OpeningPollMsg (msg x)
