module Home.Messages exposing (..)

type HomeMsgType
    = HandlePollInput String
    | HandleUsernameInput String
    | HandlePollSubmit