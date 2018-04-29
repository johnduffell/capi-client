module Data.Capi.Types.AtomData where

import GHC.Generics
import Data.Aeson
import Data.Capi.Types.Explainer
import Data.Capi.Types.Interactive
import Data.Capi.Types.Storyquestions
import Data.Capi.Types.Guide
import Data.Capi.Types.Commonsdivision
import Data.Capi.Types.Shared

data AtomData =
  Explainer ExplainerAtom
  | Interactive InteractiveAtom
  | Storyquestions StoryQuestionsAtom
  | Guide GuideAtom
  | Commonsdivision CommonsDivisionAtom
  deriving (Show, Eq, Ord, Generic)

instance ToJSON AtomData where
  toEncoding = genericToEncoding capiOptions { sumEncoding = ObjectWithSingleField
                                              , constructorTagModifier = toLower
                                              }

instance FromJSON AtomData where
  parseJSON = withObject "AtomData" $ \v ->
    Explainer <$> v .: "explainer"
    <|> Interactive <$> v .: "interactive"
    <|> Storyquestions <$> v .: "storyquestions"
    <|> Guide <$> v .: "guide"
    <|> Commonsdivision <$> v .: "commonsdivision"