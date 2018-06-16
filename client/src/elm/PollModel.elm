module PollModel exposing (..)

type alias PollModel =
    { id : String
    , jsonDescription : String
    }

initPollModel: PollModel
initPollModel =
    { id = ""
    , jsonDescription = ""
    }