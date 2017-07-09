module Main exposing (..)

import Html exposing (Html, text, div, img)
import Html.Attributes exposing (src)
import Dict exposing (..)


-- Quest dialog


type alias TextData =
    { speaker : String
    , text : String
    }


type alias SingleChoice =
    { text : String
    , nextId : String
    }


type alias ChoiceData =
    { speaker : String
    , choices : List SingleChoice
    }


type DialogType
    = Text TextData
    | Choice ChoiceData


dialogDb : Dict.Dict String DialogType
dialogDb =
    let
        someChoices =
            [ SingleChoice "ok" "key2"
            , SingleChoice "no" "key0"
            ]
    in
        Dict.fromList
            [ ( "key0", Text (TextData "QuestGiver" "I said this") )
            , ( "key1", Choice (ChoiceData "QuestReceiver" someChoices) )
            ]


test : Maybe DialogType
test =
    Debug.log "yea" (Dict.get "key0" dialogDb)


questDialog : List String
questDialog =
    [ "Q:Help"
    , "P:yes"
    , "-Q: cool thanks, go find it"
    , "P:no"
    , "-Q: another time then"
    ]



-- not working. Dialog needs to be conditional for accepting och declining Quest
-- also response from questGiver when accepted


fetchQuest : Quest
fetchQuest =
    let
        prologText =
            "Can you get me [*item*]. I will give you a [*reward*] if you do."

        prolog =
            DialogMessage "QuestGiver" prologText

        activeText =
            "Have you found [*item*]"

        active =
            DialogMessage "QuestGiver" activeText

        successText =
            "Thank you. Here is a [*reward*] for you troubles."

        success =
            DialogMessage "QuestGiver" successText

        failureText =
            "Thanks for nothing."

        failure =
            DialogMessage "QuestGiver" failureText

        event =
            Event "QuestGiver" "QuestReceiver" "[*reward*]" "giveAction"

        rewardActions =
            [ event ]
    in
        Quest [ prolog ] [ active ] [ success ] [ failure ] rewardActions


type alias DialogMessage =
    { speaker : String
    , text : String
    }


type alias Quest =
    { prolog : List DialogMessage
    , active : List DialogMessage
    , success : List DialogMessage
    , failure : List DialogMessage
    , rewardActions : List Event
    }



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
