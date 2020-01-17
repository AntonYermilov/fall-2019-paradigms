import Prelude hiding (gcd, head, tail)
import Data.Char (digitToInt, ord)

-- Самая элементарная функция (не принимает ничего, возвращает 5)
five = 5

-- Можно явно указать тип функции
-- А ещё её значение будет вычисляться каждый раз при вызове ten, по сути это просто функция вида def ten(): return five() * 2
ten :: Int
ten = five * 2

-- Самую чуточку менее элементарные функции, уже принимают значение типа Int и возвращают значение типа Int
sqr :: Int -> Int
sqr x = x * x

cube :: Int -> Int
cube x = x ^ 3

-- Та же функция через лямбду:
sqr' :: Int -> Int
sqr' = \ x -> x * x

-- Все последующие функции эквивалентны:
add :: Int -> Int -> Int
add a b = a + b
add' a = \ b -> a + b 
add'' = \ a b -> a + b
add''' = \ a b -> (+) a b

-- Функция, которая принимает функцию :)
-- А ещё абстрагируемся от конкретных типов, потому что они нам не важны
simpleMap :: (a -> b) -> a -> b
simpleMap f x = f x

-- Пример функции со сложными вычислениями, с помощью let можно её представить как набор из нескольких вычислений
foo x y z = let a = x + y
                b = a - z
                c = a * b
                d = a * sqr x + b * y + c
            in print d

-- Вещественное и целочисленное деление:
floatDiv = 5 / 2
intDiv = div 5 2

-- Способ записать оператор деления в более привычном виде (работает и для других 2-арных операторов)
intDiv' = 5 `div` 2

-- Унарный минус - синтаксический сахар для negate, (-) является функцией двух аргументов
negFive = -5
negFive' = negate 5

-- error!!!
-- printEight = print add 3 5

printEight = print (add 3 5)
printEight' = print $ add 3 5
printEight'' = print (sqr (sqr 2))
printEight''' = print $ sqr $ sqr $ 2
printEight'''' = (print . sqr . sqr) 2

-- error!!!
-- printThree''''' = (print . add) 3 5

-- Есть тип tuple
addTuple :: (Int, Int) -> Int
addTuple (x, y) = x + y

-- Каррирование и (де-|ан-)каррирование
-- curry :: ((a, b) -> c) -> a -> b -> c
-- uncurry :: (a -> b -> c) -> (a, b) -> c
add'''' x y = curry addTuple x y
addTuple' t = uncurry add t
printEight''''' = (print . uncurry add) (3, 5)

-- 1000 и 1 способ написать рекурсию:

-- Pattern matching
factorial 0 = 1
factorial n = n * factorial (n - 1)

-- if
factorial' n = if n /= 0 
               then n * factorial (n - 1)
               else 1 

-- helper (версия с where)
factorial'' n = helper 1 n
    where helper acc n = if n /= 0
                         then helper (acc * n) (n - 1)
                         else acc

-- helper
factorial''' n = 
    let helper acc n = if n /= 0
                       then helper (acc * n) (n - 1)
                       else 0
    in helper 1 n

-- guard
factorial'''' n | n /= 0 = n * factorial (n - 1)
                | otherwise = 1

-- Ленивость

-- Значение factorialRes вычисляется только при использовании
factorialRes = factorial 30000

-- Функция не падает, потому что второй аргумент не вычисляется
first = \ x y -> x
lazyWow = print $ first 42 undefined


-- Упражнения :)

-- def gcd(a, b): return a if b == 0 else gcd(b, a % b)
-- Для взятия по модулю есть функция mod :)

gcd :: Integral a => a -> a -> a
gcd a b = undefined

-- def cond_sum(cond, n): return sum(i for i in range(1, n + 1) if cond(i)
-- Пояснение: надо посчитать сумму чисел из [1, n], удовлетворяющих условию. 
-- cond - функция-предикат, n - натуральное число

condSum :: Integral a => (a -> Bool) -> a -> a
condSum cond n = undefined

-- def digits_count(n): return len(str(n))
-- Должно работать и для положительных, и для отрицательных чисел :)

digitsCount :: Integral a => a -> Int
digitsCount n = undefined


-- Расставьте скобочки и обратные кавычки в выражении test, чтобы оно сошлось по типам :)
-- Возможно, вам поможет картинка дерева вызова функций

data Nat = Z | Suc Nat deriving Show
f1 :: Nat -> Nat -> Nat
f2 :: Nat
f3 :: (Nat -> Nat) -> Nat -> Nat

f1 = undefined
f2 = undefined
f3 = undefined
-- test = f1 f2 f3 f2 f1 f2


-- В последнем упражнении мы определили тип натуральных чисел (он же Nat)
-- Это рекурсивный тип, изоморфный множеству натуральных чисел, поскольку населён значениями {Z, Suc Z, Suc Suc Z, ...} ~ {0, 1, 2, ...}
-- deriving Show - наследование свойства, позволяющего переводить значения типа Nat в строку (в т.ч. печатать на экран)

zero :: Nat
zero = Z

one :: Nat
one = Suc Z

two :: Nat
two = Suc $ Suc Z
two' = Suc one

-- Определим операции сложения и вычитания для натуральных чисел
-- Самый простой способ - воспользоватсья pattern matching'ом

(@+) :: Nat -> Nat -> Nat
a @+ Z = a
a @+ Suc b = Suc a @+ b

(@-) :: Nat -> Nat -> Nat
Z @- _ = Z
a @- Z = a
Suc a @- Suc b = a @- b

-- И снова упражнения :)

-- Реализуйте умножение натуральных чисел через сложение
-- Hint: может понадобиться функция-helper с аккумулятором
(@*) :: Nat -> Nat -> Nat
(@*) = undefined

-- Аналогично реализуйте деление через вычитание
-- Что будет при попытке делить на ноль? :)
(@/) :: Nat -> Nat -> Nat
(@/) = undefined

-- Реализуйте возведение в степень через умножение
(@^) :: Nat -> Nat -> Nat
(@^) = undefined


-- Определим тип данных "список" аналогично тому, как мы определяли натуральные числа

data List a = Nil | Cons a (List a) deriving Show

simpleList :: List Int 
simpleList = Cons 1 $ Cons 2 $ Cons 3 Nil

-- С такими списками можно работать так же, как и с числами, т.е. используя pattern matching
-- К примеру, можем реализовать функции head и tail, которые будут возвращать первый элемент списка и хвост списка сответственно
-- А чтобы "правильно" обработать случай пустого списка, воспользуемся типом Maybe
-- Maybe a - тип данных, который может принимать или значение Just a, или значение Nothing

head :: List a -> Maybe a
head Nil = Nothing
head (Cons x t) = Just x

tail :: List a -> Maybe (List a)
tail Nil = Nothing
tail (Cons x t) = Just t

-- На самом деле, в хаскелле есть синтаксический сахар, который позволяет работать со списками в более привычном виде
-- Но реализованы эти списки внутри примерно таким же образом :)

-- Эквивалентные определения списка
simpleList' :: [Int]
simpleList' = [1,2,3]

simpleList'' :: [Int]
simpleList'' = 1:2:3:[]

simpleList''' = (1::Int):2:3:[]

-- head и tail (есть уже встроенные, но реализуем свои)
head' :: [a] -> Maybe a
head' [] = Nothing
head' (x : xs) = Just x

tail' :: [a] -> Maybe [a]
tail' [] = Nothing
tail' (x : xs) = Just xs

-- Что делает эта функция?
whoami :: [a] -> [a]
whoami [] = []
whoami [x] = [x]
whoami (x : _ : xs) = x : (whoami xs)

-- take - взять первые <= n элементов (тоже есть встроенный, но...)
take' :: Int -> [a] -> [a]
take' _ [] = []
take' 0 xs = xs
take' n (x : xs) = x : take (n - 1) xs

-- Несколько полезных функций для работы со списками

-- map - применение функции ко всем элементам списка
-- map :: (a -> b) -> [a] -> [b]
sqrList :: [Int] -> [Int]
sqrList l = map sqr l

-- filter - фильтрация элементов списка по предикату
-- filter :: (a -> Bool) -> [a] -> [a]
selectOdd :: [Int] -> [Int]
selectOdd l = filter (\ x -> x `mod` 2 == 1) l

-- foldl - левая свертка
-- foldl :: Foldable t => (b -> a -> b) -> b -> t a -> b
-- Foldable - тип, элементы которого можно обойти (к примеру, список, потому что можно обойти все его элементы)
sumUp :: [Int] -> Int
sumUp xs = foldl (\ x y -> x + y) 0 xs

weirdSumUp :: [Int] -> Int
weirdSumUp xs = foldl (\ x y -> x - y) 0 xs

-- foldr - правая свёртка
-- Foldable t => (a -> b -> b) -> b -> t a -> b
-- Почти как левая свёртка, только сворачивает справа налево
sumUp' :: [Int] -> Int
sumUp' xs = foldr (\ x y -> x + y) 0 xs

weirdSumUp' :: [Int] -> Int
weirdSumUp' xs = foldr (\ x y -> x - y) 0 xs

-- ++ - оператор объединения массивов
-- concat - объединение массива массивов
merge :: [a] -> [a] -> [a]
merge xs ys = xs ++ ys
merge' xs ys = concat [xs, ys]

-- !! - оператор получения элемента массива по индексу. Работает за линию, как можно догадаться :)
-- length - длина списка
diagonal :: [[a]] -> [a]
diagonal xs = helper 0 (length xs) xs
    where helper i n xs | i < n = (xs !! i !! i) : helper (i + 1) n xs
                        | otherwise = []

-- Строки

-- Следующие определения эквивалентны:
simpleStr = "abc"
simpleStr' = 'a' : 'b' : 'c' : []
simpleStr'' = ['a', 'b', 'c']

-- Перевод элемента произвольного типа в строку
-- Но! этот произвольный тип должен наследовать Show
fiveStr = show 5
listStr = show [1,2,3]

-- Упражнения на списки

-- Реализуйте функцию, переводящую число в список цифр
-- Hint: могут помочь функции show и digitToInt
toDigits :: Int -> [Int]
toDigits = undefined

-- Реализуйте функцию, вычисляющую количество цифр в числе
numberOfDigits :: Int -> Int
numberOfDigits = undefined

-- Реализуйте функцию, вычисляющую сумму цифр числа
sumOfDigits :: Int -> Int
sumOfDigits = undefined

-- Реализуйте функцию drop, которая  выбросывает из списка первые <= n элементов
drop' :: Int -> [a] -> [a]
drop' = undefined

-- Реализуйте функцию, проверяющую список на палиндромность
isPalindrome :: [a] -> Bool
isPalindrome = undefined

-- Реализуйте функцию, разделяющую список на две части из k и n - k элементов (n - длина списка)
splitAtIndex :: Int -> [a] -> ([a], [a])
splitAtIndex = undefined

-- Реализуйте функцию, делающую циклический сдвиг массива влево на k позиций
-- К примеру, rotate 2 [1,2,3,4,5] == [3,4,5,1,2]
rotate :: Int -> [a] -> [a]
rotate = undefined

-- Реализуйте функцию, которая выводит элементы списка через разделитель " | "
prettyPrintList :: Show a => [a] -> String
prettyPrintList xs = undefined


-- И ещё чуть-чуть про data

-- В домашке вам потребуется работать с типом File, который определён следующим образом:
data File = File {name :: String, content :: String}

-- name и content - это не поля объекта, а ффункции, которым на вход можно передать элемент типа File, а на выходе получить соответствующее поле
-- Но есть и другой способ получить эти значения - pattern matching

file = File "hello.txt" "Hello World"
fileName = name file  -- "hello.txt"
fileContent = content file  -- "Hello World"

showFile f = (name f) ++ ", " ++ (content f)
showFile' (File n c) = n ++ ", " ++ c

