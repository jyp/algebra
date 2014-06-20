{-# LANGUAGE MultiParamTypeClasses, NoImplicitPrelude, RebindableSyntax #-}
module Numeric.Field.Fraction (Fraction, numerator, denominator, Ratio, (%)) where
import Numeric.Additive.Class
import Numeric.Additive.Group
import Numeric.Algebra.Class
import Numeric.Algebra.Division
import Numeric.Algebra.Unital
import Numeric.Decidable.Units
import Numeric.Decidable.Zero
import Numeric.Domain.Euclidean
import Numeric.Natural
import Numeric.Rig.Class
import Numeric.Ring.Class
import Prelude                  hiding (Integral (..), Num (..), gcd)

-- | Fraction field @k(D)@ of 'Euclidean' domain @D@.
data Fraction d = Fraction !d !d

-- | Convenient synonym for 'Fraction'.
type Ratio = Fraction

instance (Eq d, Show d, Unital d) => Show (Fraction d) where
  showsPrec d (Fraction p q)
   | q == one    = showsPrec d p
   | otherwise = showParen (d > 5) $ showsPrec 6 p . showString " / " . showsPrec 6 q

infixl 7 %
(%) :: Euclidean d => d -> d -> Fraction d
a % b = let r = gcd a b
        in Fraction (a `quot` r) (b `quot` r)

numerator :: Fraction t -> t
numerator (Fraction q _) = q
{-# INLINE numerator #-}

denominator :: Fraction t -> t
denominator (Fraction _ p) = p
{-# INLINE denominator #-}

instance (Eq d, Multiplicative d) => Eq (Fraction d) where
  Fraction p q == Fraction s t = p*t == q*s
  {-# INLINE (==) #-}

instance (Ord d, Multiplicative d) => Ord (Fraction d)  where
  compare (Fraction p q) (Fraction p' q') = compare (p*q') (p'*q)
  {-# INLINE compare #-}

instance Euclidean d => Division (Fraction d) where
  recip (Fraction p q) | isZero q  = error "Ratio has zero denominator!"
                       | otherwise = Fraction q p
  Fraction p q / Fraction s t = (p*t) % (q*s)
  {-# INLINE recip #-}
  {-# INLINE (/) #-}


instance Euclidean d => DecidableZero (Fraction d) where
  isZero (Fraction p _) = isZero p
  {-# INLINE isZero #-}

instance Euclidean d => DecidableUnits (Fraction d) where
  isUnit (Fraction p _) = not $ isZero p
  {-# INLINE isUnit #-}
  recipUnit (Fraction p q) | isZero p  = Nothing
                           | otherwise = Just (Fraction q p)
  {-# INLINE recipUnit #-}
instance Euclidean d => Ring (Fraction d)
instance Euclidean d => Abelian (Fraction d)
instance Euclidean d => Semiring (Fraction d)
instance Euclidean d => Group (Fraction d)
instance Euclidean d => Monoidal (Fraction d) where
  zero = Fraction zero one
  {-# INLINE zero #-}
instance Euclidean d => LeftModule Integer (Fraction d) where
  n .* Fraction p r = (n .* p) % r
  {-# INLINE (.*) #-}
instance Euclidean d => RightModule Integer (Fraction d) where
  Fraction p r *. n = (p *. n) % r
  {-# INLINE (*.) #-}
instance Euclidean d => LeftModule Natural (Fraction d) where
  n .* Fraction p r = (n .* p) % r
  {-# INLINE (.*) #-}
instance Euclidean d => RightModule Natural (Fraction d) where
  Fraction p r *. n = (p *. n) % r
  {-# INLINE (*.) #-}
instance Euclidean d => Additive (Fraction d) where
  Fraction p q + Fraction s t = (p*t + q*s) % (q*t)
  {-# INLINE (+) #-}
instance Euclidean d => Unital (Fraction d) where
  one = Fraction one one
  {-# INLINE one #-}
instance Euclidean d => Multiplicative (Fraction d) where
  Fraction p q * Fraction s t = (p*s) % (q*t)
instance Euclidean d => Rig (Fraction d)
