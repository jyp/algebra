{-# LANGUAGE MultiParamTypeClasses, FlexibleInstances, UndecidableInstances #-}
module Numeric.Algebra.Involutive
  ( 
  -- * Involution
    InvolutiveMultiplication(..)
  , InvolutiveSemiring
  -- * Involutive Algebras
  , InvolutiveAlgebra(..)
  , InvolutiveCoalgebra(..)
  , InvolutiveBialgebra
  -- * Trivial Involution
  , TriviallyInvolutive
  , TriviallyInvolutiveAlgebra
  , TriviallyInvolutiveCoalgebra
  , TriviallyInvolutiveBialgebra
  ) where

import Numeric.Algebra.Class
import Numeric.Algebra.Commutative
import Numeric.Algebra.Unital
import Data.Int
import Data.Word
import Numeric.Natural.Internal

-- | An semigroup with involution
-- 
-- > adjoint a * adjoint b = adjoint (b * a)
class Multiplicative r => InvolutiveMultiplication r where
  adjoint :: r -> r

instance InvolutiveMultiplication Int where adjoint = id
instance InvolutiveMultiplication Integer where adjoint = id
instance InvolutiveMultiplication Int8 where adjoint = id
instance InvolutiveMultiplication Int16 where adjoint = id
instance InvolutiveMultiplication Int32 where adjoint = id
instance InvolutiveMultiplication Int64 where adjoint = id
instance InvolutiveMultiplication Bool where adjoint = id
instance InvolutiveMultiplication Word where adjoint = id
instance InvolutiveMultiplication Natural where adjoint = id
instance InvolutiveMultiplication Word8 where adjoint = id
instance InvolutiveMultiplication Word16 where adjoint = id
instance InvolutiveMultiplication Word32 where adjoint = id
instance InvolutiveMultiplication Word64 where adjoint = id
instance InvolutiveMultiplication () where adjoint = id
instance (InvolutiveMultiplication a, InvolutiveMultiplication b) => InvolutiveMultiplication (a,b) where
  adjoint (a,b) = (adjoint a, adjoint b)
instance (InvolutiveMultiplication a, InvolutiveMultiplication b, InvolutiveMultiplication c) => InvolutiveMultiplication (a,b,c) where
  adjoint (a,b,c) = (adjoint a, adjoint b, adjoint c)
instance (InvolutiveMultiplication a, InvolutiveMultiplication b, InvolutiveMultiplication c, InvolutiveMultiplication d) => InvolutiveMultiplication (a,b,c,d) where
  adjoint (a,b,c,d) = (adjoint a, adjoint b, adjoint c, adjoint d)
instance (InvolutiveMultiplication a, InvolutiveMultiplication b, InvolutiveMultiplication c, InvolutiveMultiplication d, InvolutiveMultiplication e) => InvolutiveMultiplication (a,b,c,d,e) where
  adjoint (a,b,c,d,e) = (adjoint a, adjoint b, adjoint c, adjoint d, adjoint e)


-- | adjoint (x + y) = adjoint x + adjoint y
class (Semiring r, InvolutiveMultiplication r) => InvolutiveSemiring r

instance InvolutiveSemiring Integer
instance InvolutiveSemiring Int
instance InvolutiveSemiring Int8
instance InvolutiveSemiring Int16
instance InvolutiveSemiring Int32
instance InvolutiveSemiring Int64

instance InvolutiveSemiring Natural
instance InvolutiveSemiring Word
instance InvolutiveSemiring Word8
instance InvolutiveSemiring Word16
instance InvolutiveSemiring Word32
instance InvolutiveSemiring Word64

instance InvolutiveSemiring ()
instance (InvolutiveSemiring a, InvolutiveSemiring b) => InvolutiveSemiring (a, b)
instance (InvolutiveSemiring a, InvolutiveSemiring b, InvolutiveSemiring c) => InvolutiveSemiring (a, b, c)
instance (InvolutiveSemiring a, InvolutiveSemiring b, InvolutiveSemiring c, InvolutiveSemiring d) => InvolutiveSemiring (a, b, c, d)
instance (InvolutiveSemiring a, InvolutiveSemiring b, InvolutiveSemiring c, InvolutiveSemiring d, InvolutiveSemiring e) => InvolutiveSemiring (a, b, c, d, e)

-- adjoint = id
class (Commutative r, InvolutiveMultiplication r) => TriviallyInvolutive r
instance TriviallyInvolutive Int
instance TriviallyInvolutive Integer
instance TriviallyInvolutive Int8
instance TriviallyInvolutive Int16
instance TriviallyInvolutive Int32
instance TriviallyInvolutive Int64
instance TriviallyInvolutive Bool
instance TriviallyInvolutive Word
instance TriviallyInvolutive Natural
instance TriviallyInvolutive Word8
instance TriviallyInvolutive Word16
instance TriviallyInvolutive Word32
instance TriviallyInvolutive Word64
instance TriviallyInvolutive ()
instance (TriviallyInvolutive a, TriviallyInvolutive b) => TriviallyInvolutive (a,b)
instance (TriviallyInvolutive a, TriviallyInvolutive b, TriviallyInvolutive c) => TriviallyInvolutive (a,b,c)
instance (TriviallyInvolutive a, TriviallyInvolutive b, TriviallyInvolutive c, TriviallyInvolutive d) => TriviallyInvolutive (a,b,c,d)
instance (TriviallyInvolutive a, TriviallyInvolutive b, TriviallyInvolutive c, TriviallyInvolutive d, TriviallyInvolutive e) => TriviallyInvolutive (a,b,c,d,e)

-- inv is an associative algebra homomorphism
class Algebra r a => InvolutiveAlgebra r a where
  inv :: (a -> r) -> a -> r

instance InvolutiveAlgebra () a where
  inv _ _ = ()
instance (Algebra r b, InvolutiveAlgebra r a) => InvolutiveAlgebra (b -> r) a where
  inv f c a = inv (`f` a) c
instance (InvolutiveAlgebra r a, InvolutiveAlgebra r b) => InvolutiveAlgebra r (a, b) where
  inv f (a,b) = inv (\a' -> inv (\b' -> f (a',b')) b) a
instance (InvolutiveAlgebra r a, InvolutiveAlgebra r b, InvolutiveAlgebra r c) => InvolutiveAlgebra r (a, b, c) where
  inv f (a,b,c) = inv (\a' -> inv (\b' -> inv (\c' -> f (a',b',c')) c) b) a
instance (InvolutiveAlgebra r a, InvolutiveAlgebra r b, InvolutiveAlgebra r c, InvolutiveAlgebra r d) => InvolutiveAlgebra r (a, b, c, d) where
  inv f (a,b,c,d) = inv (\a' -> inv (\b' -> inv (\c' -> inv (\d' -> f (a',b',c',d')) d) c) b) a
instance (InvolutiveAlgebra r a, InvolutiveAlgebra r b, InvolutiveAlgebra r c, InvolutiveAlgebra r d, InvolutiveAlgebra r e) => InvolutiveAlgebra r (a, b, c, d, e) where
  inv f (a,b,c,d,e) = inv (\a' -> inv (\b' -> inv (\c' -> inv (\d' -> inv (\e' -> f (a',b',c',d',e')) e) d) c) b) a
instance InvolutiveAlgebra r h => InvolutiveMultiplication (h -> r) where
  adjoint = inv

class (CommutativeAlgebra r a, InvolutiveAlgebra r a) => TriviallyInvolutiveAlgebra r a

instance TriviallyInvolutiveAlgebra () a 
instance (Algebra r b, TriviallyInvolutiveAlgebra r a) => TriviallyInvolutiveAlgebra (b -> r) a
instance (TriviallyInvolutiveAlgebra r a, TriviallyInvolutiveAlgebra r b) => TriviallyInvolutiveAlgebra r (a, b) where
instance (TriviallyInvolutiveAlgebra r a, TriviallyInvolutiveAlgebra r b, TriviallyInvolutiveAlgebra r c) => TriviallyInvolutiveAlgebra r (a, b, c) where
instance (TriviallyInvolutiveAlgebra r a, TriviallyInvolutiveAlgebra r b, TriviallyInvolutiveAlgebra r c, TriviallyInvolutiveAlgebra r d) => TriviallyInvolutiveAlgebra r (a, b, c, d)
instance (TriviallyInvolutiveAlgebra r a, TriviallyInvolutiveAlgebra r b, TriviallyInvolutiveAlgebra r c, TriviallyInvolutiveAlgebra r d, TriviallyInvolutiveAlgebra r e) => TriviallyInvolutiveAlgebra r (a, b, c, d, e)
instance TriviallyInvolutiveAlgebra r h => TriviallyInvolutive (h -> r)

class Coalgebra r c => InvolutiveCoalgebra r c where
  coinv :: (c -> r) -> c -> r
instance InvolutiveCoalgebra () c where
  coinv _ _ = ()
instance (Algebra r b, InvolutiveCoalgebra r c) => InvolutiveCoalgebra (b -> r) c where
  coinv f c a = coinv (`f` a) c
instance (InvolutiveCoalgebra r a, InvolutiveCoalgebra r b) => InvolutiveCoalgebra r (a, b) where
  coinv f (a,b) = coinv (\a' -> coinv (\b' -> f (a',b')) b) a
instance (InvolutiveCoalgebra r a, InvolutiveCoalgebra r b, InvolutiveCoalgebra r c) => InvolutiveCoalgebra r (a, b, c) where
  coinv f (a,b,c) = coinv (\a' -> coinv (\b' -> coinv (\c' -> f (a',b',c')) c) b) a
instance (InvolutiveCoalgebra r a, InvolutiveCoalgebra r b, InvolutiveCoalgebra r c, InvolutiveCoalgebra r d) => InvolutiveCoalgebra r (a, b, c, d) where
  coinv f (a,b,c,d) = coinv (\a' -> coinv (\b' -> coinv (\c' -> coinv (\d' -> f (a',b',c',d')) d) c) b) a
instance (InvolutiveCoalgebra r a, InvolutiveCoalgebra r b, InvolutiveCoalgebra r c, InvolutiveCoalgebra r d, InvolutiveCoalgebra r e) => InvolutiveCoalgebra r (a, b, c, d, e) where
  coinv f (a,b,c,d,e) = coinv (\a' -> coinv (\b' -> coinv (\c' -> coinv (\d' -> coinv (\e' -> f (a',b',c',d',e')) e) d) c) b) a
-- instance InvolutiveCoalgebra r h => Involutive (Covector r h)

class (CommutativeCoalgebra r a, InvolutiveCoalgebra r a) => TriviallyInvolutiveCoalgebra r a

instance TriviallyInvolutiveCoalgebra () a 
instance (Algebra r b, TriviallyInvolutiveCoalgebra r a) => TriviallyInvolutiveCoalgebra (b -> r) a
instance (TriviallyInvolutiveCoalgebra r a, TriviallyInvolutiveCoalgebra r b) => TriviallyInvolutiveCoalgebra r (a, b) where
instance (TriviallyInvolutiveCoalgebra r a, TriviallyInvolutiveCoalgebra r b, TriviallyInvolutiveCoalgebra r c) => TriviallyInvolutiveCoalgebra r (a, b, c) where
instance (TriviallyInvolutiveCoalgebra r a, TriviallyInvolutiveCoalgebra r b, TriviallyInvolutiveCoalgebra r c, TriviallyInvolutiveCoalgebra r d) => TriviallyInvolutiveCoalgebra r (a, b, c, d)
instance (TriviallyInvolutiveCoalgebra r a, TriviallyInvolutiveCoalgebra r b, TriviallyInvolutiveCoalgebra r c, TriviallyInvolutiveCoalgebra r d, TriviallyInvolutiveCoalgebra r e) => TriviallyInvolutiveCoalgebra r (a, b, c, d, e)

-- inv = coinv
class (Bialgebra r h, InvolutiveAlgebra r h, InvolutiveCoalgebra r h) => InvolutiveBialgebra r h
instance (Bialgebra r h, InvolutiveAlgebra r h, InvolutiveCoalgebra r h) => InvolutiveBialgebra r h

class (InvolutiveBialgebra r h, TriviallyInvolutiveAlgebra r h, TriviallyInvolutiveCoalgebra r h) => TriviallyInvolutiveBialgebra r h
instance (InvolutiveBialgebra r h, TriviallyInvolutiveAlgebra r h, TriviallyInvolutiveCoalgebra r h) => TriviallyInvolutiveBialgebra r h