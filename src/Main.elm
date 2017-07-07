module Main exposing (..)

import Html exposing (Html, text, div, img)
import Html.Attributes exposing (src)


-- Quest dialog


type alias DialogMessage =
    { speakerId : String
    , text : String
    }


type alias Quest =
    { prolog : List DialogMessage
    , active : List DialogMessage
    , success : List DialogMessage
    , failure : List DialogMessage
    , rewardAction : RewardAction
    }


type alias RewardAction =
    { events : List Event }



-- QuestGiver : does something : with/using : to someone
-- QuestGiver_gives_reward_player


type alias Event =
    { from : String
    , to : String
    , what : String
    , action : String
    }


type alias Npc =
    { name : String
    , quests : List Quest
    }


type ItemType
    = Weapon
    | Gadget
    | Armour
    | Resource
    | Nothing


type alias Item =
    { name : String
    , itemType : ItemType
    }



---- MODEL ----


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , div [] [ text "Your Elm App is working!" ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
