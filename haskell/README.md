## The Repl

``` ghci ```

### Showing types

``` :t 5 ```  => ``` 5 :: Num a => a ``` 

### Loading files

``` :load file.hs ```

## Basic Types

### Numbers are as you'd expect (infix)

### Strings

- Can be concatenated together with ``` ++ ```

e.g. 
```haskell 
"hello " ++ "world"
```

### Characters

Represented with single quotes e.g. ``` 'a' ```

A string is just a list of characters

i.e. ``` ['a', 'b'] = "ab" ``` 

### Boolean Logic

example:

```haskell 
if (5 == 5) then "true" else "false"
```


