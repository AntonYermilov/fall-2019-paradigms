import Prelude hiding (String, lookup)
import Debug.Trace

-- Бесконечные структуры данных и ленивость

data Nat = Zero | Suc Nat deriving (Show, Eq, Ord)

-- Скомпилируются ли эти функции?
infinite' :: Nat
infinite' = Suc $ infinite'

repeat' :: a -> [a]
repeat' x = x : repeat' x

-- Определим сложение для натуральных чисел
(@+) :: Nat -> Nat -> Nat
a @+ Zero = a
a @+ (Suc b) = (Suc a) @+ b

-- Выполнится ли следующий код?
two = Suc $ Suc Zero
h1 = infinite' @+ two
h2 = two @+ infinite'

-- Эта функция выполнится, хотя repeat генерирует бесконечный список
threeSameElements x = take 3 $ repeat x

-- Внезапный вопрос: в чём разница между foldl и foldr?
-- f x1 (f x2 (f x3 (f x4 ...)))
-- f (f (f (f ( ... f x1) x2) x3) ...)
f1 = take 10 $ foldr (\ x ini -> x^2 : ini) [] (iterate (+ 1) 0)
f2 = take 10 $ foldl (\ ini x -> ini ++ [x^2]) [] (iterate (+ 1) 0)

-- Упражнение: вычислить первые N простых чисел
isPrime :: Int -> Bool
isPrime n = (length $ filter (== 0) $ take n $ map (n `mod`) [1..]) == 2

getPrimes :: Int -> [Int]
getPrimes n = take n $ filter isPrime [1..]

-- type - просто синоним для типа
type String = [Char]
type File = (String, [String])

filename :: File -> String
filename (name, lines) = name

file1 :: File
file1 = ("abc", ["line 1", "line 2"])

file2 :: (String, [String])
file2 = ("def", ["line 1", "line 2"])

-- filename file1 и filename file2 - валидные выражения



-- Trees

data Tree a = Empty | Leaf a | Node a [Tree a] deriving Show

--       5
--     / | \
--    2  1  3
--  /  \     \
-- 4    8     9

simpleTree :: Tree Int
simpleTree = Node 5 [Node 2 [Leaf 4, Leaf 8], Leaf 1, Node 3 [Leaf 9]]

-- treeMap: применить функцию ко всем элементам дерева и вернуть дерево с той же структурой
-- Exercise

treeMap :: (a -> b) -> Tree a -> Tree b
treeMap _ Empty = Empty
treeMap f (Leaf x) = Leaf (f x)
treeMap f (Node x ys) = Node (f x) (map (treeMap f) ys)

instance Functor Tree where
    fmap = treeMap

-- down: [5, 2, 4, 8, 1, 3, 9]
-- Exercise
down :: Tree a -> [a]
down Empty = []
down (Leaf x) = [x]
down (Node x ys) = x : concat (map down ys)

-- up: [4, 8, 2, 1, 9, 3, 5]
-- Exercise
up :: Tree a -> [a]
up Empty = []
up (Leaf x) = [x]
up (Node x ys) = concat (map up ys) ++ [x]
up (Node x ys) = foldr (++) [x] (map up ys)

-- foldr :: (a -> b -> b) -> b -> t a -> b
-- [x1, x2, x3] -> f x1 (f x2 (f x3 ini))
-- Exercise
-- (a -> b -> c) -> (b -> a -> c)
--
-- foldr f :: b -> Tree a -> b
-- flip $ foldr f :: Tree a -> b -> b
-- ini :: b
-- ys :: [Tree a]

instance Foldable Tree where
    foldr f ini Empty = ini
    foldr f ini (Leaf x) = f x ini
    foldr f ini (Node x ys) = f x (foldr (flip $ foldr f) ini ys)

-- foldr (++) [] simpleTree == [5, 2, 4, 8, 1, 3, 9]



-- Debugging

weird = foldr (-) 0 [1,2,3,4,5]

-- trace :: String -> a -> a
debug :: (Show a, Show b, Show c) => (a -> b -> c) -> a -> b -> c
debug op a b = trace (show a ++ " `op` " ++ show b ++ " = " ++ show (op a b)) (op a b)
weird' = foldr (debug (-)) 0 [1,2,3,4,5]



-- AST

-- Определим типы данных для переменных и контекста

data Variable = Variable {name :: String, value :: Int} deriving Show

type Context = [Variable]

-- Реализуйте функцию, которая по контексту и названию переменной возвращает её значение
lookup :: Context -> String -> Int
lookup [] _ = undefined
lookup (x : xs) var | name x == var = value x
                    | otherwise     = lookup xs var

-- Реализуйте функцию, которая добавляет переменную в контекст (или обновляет существующую, если переменная уже в контексте)
update :: Context -> Variable -> Context
update [] var = [var]
update (x : xs) var | name x == name var = var : xs
                    | otherwise          = x : update xs var

-- Введём теперь ещё несколько определений.
-- Начёнм с определения бинарной операции. В текущем варианте обойдёмся лишь тремя следующими операциями:

data Binop = Mul | Sub | Add

toBinaryFunction :: Binop -> (Int -> Int -> Int)
toBinaryFunction Mul = (*)
toBinaryFunction Sub = (-)
toBinaryFunction Add = (+)

instance Show Binop where
    show Mul = "*"
    show Sub = "-"
    show Add = "+"

-- Ещё нам потребуется определить тип для выражения, которое мы в дальнейшем будем пытаться вычислять.
-- Кроме того будем считать, что все наши операции левоассоциативные, т.е. вычисление выражения будет происходить строго слева направо

data Expression = Number Int
                | Reference String
                | BinaryOperation Binop Expression Expression

instance Show Expression where
    show (Number x) = show x
    show (Reference r) = r
    show (BinaryOperation op e1 e2) = "(" ++ show e1 ++ " " ++ show op ++ " " ++ show e2 ++ ")"

-- a * 2 + b - 3
simpleExpression = BinaryOperation Sub (BinaryOperation Add (BinaryOperation Mul (Reference "a") (Number 2)) (Reference "b")) (Number 3)

-- Теперь мы можем перейти к реализации вычисления наших выражений :)
-- Exercise

evaluate :: Context -> Expression -> Int
evaluate ctx (Number x) = x
evaluate ctx (Reference r) = lookup ctx r
evaluate ctx (BinaryOperation op e1 e2) = toBinaryFunction op (evaluate ctx e1) (evaluate ctx e2)

-- А что, если мы теперь хотим добавить операции присваивания, меняющие контекст?

data Expression' = Number' Int
                 | Reference' String
                 | BinaryOperation' Binop Expression' Expression'
                 | Assignment' String Expression'

instance Show Expression' where
    show (Number' x) = show x
    show (Reference' r) = r
    show (BinaryOperation' op e1 e2) = "(" ++ show e1 ++ " " ++ show op ++ " " ++ show e2 ++ ")"
    show (Assignment' var e) = "`" ++ show var ++ " = " ++ show e ++ "`"

-- a = 1 + 4
-- b = 2
-- a * 2 + b - 3
setA = Assignment' "a" (BinaryOperation' Add (Number' 1) (Number' 4))
setB = Assignment' "b" (Number' 2)
simpleExpression' = Assignment' "c" (BinaryOperation' Sub (BinaryOperation' Add (BinaryOperation' Mul (Reference' "a") (Number' 2)) (Reference' "b")) (Number' 3))

-- Теперь мы можем перейти к реализации вычисления наших выражений :)
-- Exercise (2)

evaluate' :: Context -> Expression' -> (Int, Context)
evaluate' ctx (Number' x) = (x, ctx)
evaluate' ctx (Reference' r) = (lookup ctx r, ctx)
evaluate' ctx (BinaryOperation' op e1 e2) =
    let (lvalue, ctx')  = evaluate' ctx e1
        (rvalue, ctx'') = evaluate' ctx' e2
    in (toBinaryFunction op lvalue rvalue, ctx'')
evaluate' ctx (Assignment' var e) =
    let (value, ctx') = evaluate' ctx e
        ctx'' = update ctx' (Variable var value)
    in (value, ctx'')

evaluateProgram :: Context -> [Expression'] -> (Int, Context)
evaluateProgram ctx es = foldl (\ ini e -> evaluate' (snd ini) e) (0, ctx) es
