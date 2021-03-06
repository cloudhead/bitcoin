module Crypto.Blockchain.Hash
    ( maxHash
    , module Crypto.Hash
    ) where

import           Crypto.Hash (Digest, SHA256(..), digestFromByteString, hashDigestSize, HashAlgorithm, hash)
import           Data.Binary (Binary, get, put)
import           Data.ByteString hiding (putStrLn)
import           Data.ByteArray (convert)
import qualified Data.ByteArray as ByteArray
import           Data.Maybe (fromJust)

instance Binary (Digest SHA256) where
    put digest =
        put (convert digest :: ByteString)
    get =
        fromJust . digestFromByteString <$> get @ByteString

maxHash :: HashAlgorithm a => Digest a
maxHash = fromJust $
    digestFromByteString (ByteArray.replicate (hashDigestSize SHA256) maxBound :: ByteString)

