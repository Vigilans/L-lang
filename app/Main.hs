{-# OPTIONS_GHC -fno-warn-name-shadowing #-}
{-# OPTIONS_GHC -fno-warn-unused-do-bind #-}

import Program
import Function

-- f(x) = | 1, x = 0
--        | x, x > 0

idProg = unary $ \(y, [x]) -> do
    -- declearation
    [z]    <- freeVars 1
    [a, b] <- freeLabels 2
    -- main program
    _label_ a
    gnz x b
    goto exit
    _label_ b
    dec x
    inc y
    gnz x a
    -- return statement
    return y

id' x = invoke idProg [x] 

addProg = binary $ \(y, [x1, x2]) -> do
    [z] <- freeVars 1
    [a, b] <- freeLabels 2
    mov x1 y
    mov x2 z
    _label_ b
    gnz z a
    goto exit
    _label_ a
    dec z
    inc y
    goto b
    return y

(>+<) x1 x2 = invoke addProg [x1, x2]

main :: IO ()
main = print "Hello"