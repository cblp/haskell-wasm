# Haskell WebAssembly Toolkit

## Goals
  * Provide tool WebAssembly code generation for Haskell
  * Create infrastructure for Cmm to WebAssembly code generator
  * Have Fun :)

## Status
  * Lexer: supports nested block comments and all lexemes from Spec
  * Parser: parses all examples from WebAssembly Core TestsSuit(including folded instructions parsing)
  * Renaming Phase: substitute identifiers with correct indexes, expand all implicit type declarations)
  * Binary format parser/serializer

## ToDo
  * Improve error messages for text representation parsing
  * Verification Phase: execute verification procedure from Spec
  * Text Representation pretty-printer
  * Execution Phase: implement simple interpreter for running WebAssembly Core TestsSuit assertions
