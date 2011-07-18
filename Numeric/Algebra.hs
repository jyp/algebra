module Numeric.Algebra
  ( 
  -- * Additive

  -- ** additive semigroups
    Additive(..)
  , sum1
  -- ** additive Abelian semigroups
  , Abelian
  -- ** additive idempotent semigroups
  , Idempotent
  , replicate1pIdempotent
  , replicateIdempotent
  -- ** partitionable additive semigroups
  , Partitionable(..)
  -- ** additive monoids
  , Monoidal(..)
  , sum
  -- ** additive groups
  , Group(..)

  -- * Multiplicative
  
  -- ** multiplicative semigroups
  , Multiplicative(..)
  , product1
  -- ** commutative multiplicative semigroups
  , Commutative
  -- ** multiplicative monoids
  , Unital(..)
  , product
  -- ** idempotent multiplicative semigroups
  , Band
  , pow1pBand
  , powBand
  -- ** multiplicative groups
  , Division(..)
  -- ** factorable multiplicative semigroups
  , Factorable(..)
  -- ** involutive multiplicative semigroups
  , InvolutiveMultiplication(..)
  , TriviallyInvolutive

  -- * Ring-Structures
  -- ** Semirings 
  , Semiring
  , InvolutiveSemiring
  , Dioid
  -- ** Rngs
  , Rng
  -- ** Rigs
  , Rig(..)
  -- * Rings
  , Ring(..)

  -- * Modules
  , LeftModule(..)
  , RightModule(..)
  , Module

  -- * Algebras
  -- ** associative algebras over (non-commutative) semirings 
  , Algebra(..)
  , Coalgebra(..)
  -- ** unital algebras
  , UnitalAlgebra(..)
  , CounitalCoalgebra(..)
  , Bialgebra
  -- ** involutive algebras
  , InvolutiveAlgebra(..)
  , InvolutiveCoalgebra(..)
  , InvolutiveBialgebra
  , TriviallyInvolutiveAlgebra
  , TriviallyInvolutiveCoalgebra
  , TriviallyInvolutiveBialgebra
  -- ** idempotent algebras
  , IdempotentAlgebra
  , IdempotentBialgebra
  -- ** commutative algebras
  , CommutativeAlgebra
  , CommutativeBialgebra
  , CommutativeCoalgebra
  -- ** division algebras
  , DivisionAlgebra(..)
  -- ** Hopf alegebras
  , HopfAlgebra(..)

  -- * Ring Properties
  -- ** Characteristic
  , Characteristic(..)
  , charInt, charWord
  -- ** Order
  , Order(..)
  , OrderedRig
  , AdditiveOrder

  , DecidableZero
  , DecidableUnits
  , DecidableAssociates

  -- * Natural numbers
  , Natural
  , Whole(toNatural)

  -- * Representable Additive
  , addRep, replicate1pRep
  -- * Representable Monoidal
  , zeroRep, replicateRep
  -- * Representable Group
  , negateRep, minusRep, subtractRep, timesRep
  -- * Representable Multiplicative (via Algebra)
  , mulRep
  -- * Representable Unital (via UnitalAlgebra)
  , oneRep
  -- * Representable Rig (via Algebra)
  , fromNaturalRep
  -- * Representable Ring (via Algebra)
  , fromIntegerRep
  ) where

import Prelude ()
import Numeric.Additive.Class
import Numeric.Additive.Group
import Numeric.Algebra.Class
import Numeric.Algebra.Involutive
import Numeric.Algebra.Idempotent
import Numeric.Algebra.Commutative
import Numeric.Algebra.Division
import Numeric.Algebra.Factorable
import Numeric.Algebra.Unital
import Numeric.Algebra.Hopf
import Numeric.Rig.Class
import Numeric.Rig.Characteristic
import Numeric.Rig.Ordered
import Numeric.Order.Class
import Numeric.Order.Additive
import Numeric.Rng.Class
import Numeric.Ring.Class
import Numeric.Dioid.Class
import Numeric.Decidable.Units
import Numeric.Module.Representable
import Numeric.Decidable.Associates
import Numeric.Decidable.Zero
import Numeric.Natural.Internal
-- import Numeric.Covector