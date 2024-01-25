-- This Happy file was machine-generated by the BNF converter
{
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module Tip.Parser.ParTIP where
import Tip.Parser.AbsTIP
import Tip.Parser.LexTIP
import Tip.Parser.ErrM

}

%name pStart Start
%name pListDecl ListDecl
%name pDecl Decl
%name pAssertion Assertion
%name pPar Par
%name pConstType ConstType
%name pInnerFunType InnerFunType
%name pFunType FunType
%name pInnerFunDec InnerFunDec
%name pFunDec FunDec
%name pBracketedFunDec BracketedFunDec
%name pDatatypeName DatatypeName
%name pInnerDatatype InnerDatatype
%name pDatatype Datatype
%name pConstructor Constructor
%name pBinding Binding
%name pLetDecl LetDecl
%name pType Type
%name pExpr Expr
%name pLit Lit
%name pBinder Binder
%name pCase Case
%name pPattern Pattern
%name pHead Head
%name pPolySymbol PolySymbol
%name pAttrSymbol AttrSymbol
%name pAttr Attr
%name pListLetDecl ListLetDecl
%name pListCase ListCase
%name pListExpr ListExpr
%name pListDatatype ListDatatype
%name pListConstructor ListConstructor
%name pListBinding ListBinding
%name pListSymbol ListSymbol
%name pListType ListType
%name pListFunDec ListFunDec
%name pListBracketedFunDec ListBracketedFunDec
%name pListAttr ListAttr
%name pListDatatypeName ListDatatypeName
%name pSymbol Symbol
-- no lexer declaration
%monad { Err } { thenM } { returnM }
%tokentype {Token}
%token
  '(' { PT _ (TS _ 1) }
  ')' { PT _ (TS _ 2) }
  '*' { PT _ (TS _ 3) }
  '+' { PT _ (TS _ 4) }
  '-' { PT _ (TS _ 5) }
  '/' { PT _ (TS _ 6) }
  '<' { PT _ (TS _ 7) }
  '<=' { PT _ (TS _ 8) }
  '=' { PT _ (TS _ 9) }
  '=>' { PT _ (TS _ 10) }
  '>' { PT _ (TS _ 11) }
  '>=' { PT _ (TS _ 12) }
  '@' { PT _ (TS _ 13) }
  'Bool' { PT _ (TS _ 14) }
  'Int' { PT _ (TS _ 15) }
  'Real' { PT _ (TS _ 16) }
  '_' { PT _ (TS _ 17) }
  'and' { PT _ (TS _ 18) }
  'assert' { PT _ (TS _ 19) }
  'assert-claim' { PT _ (TS _ 20) }
  'check-sat' { PT _ (TS _ 21) }
  'declare-const' { PT _ (TS _ 22) }
  'declare-datatype' { PT _ (TS _ 23) }
  'declare-datatypes' { PT _ (TS _ 24) }
  'declare-fun' { PT _ (TS _ 25) }
  'declare-sort' { PT _ (TS _ 26) }
  'define-fun' { PT _ (TS _ 27) }
  'define-fun-rec' { PT _ (TS _ 28) }
  'define-funs-rec' { PT _ (TS _ 29) }
  'distinct' { PT _ (TS _ 30) }
  'div' { PT _ (TS _ 31) }
  'exists' { PT _ (TS _ 32) }
  'false' { PT _ (TS _ 33) }
  'forall' { PT _ (TS _ 34) }
  'ite' { PT _ (TS _ 35) }
  'lambda' { PT _ (TS _ 36) }
  'let' { PT _ (TS _ 37) }
  'match' { PT _ (TS _ 38) }
  'mod' { PT _ (TS _ 39) }
  'not' { PT _ (TS _ 40) }
  'or' { PT _ (TS _ 41) }
  'par' { PT _ (TS _ 42) }
  'prove' { PT _ (TS _ 43) }
  'set-logic' { PT _ (TS _ 44) }
  'to_real' { PT _ (TS _ 45) }
  'true' { PT _ (TS _ 46) }
  L_integ  { PT _ (TI $$) }
  L_UnquotedSymbol { PT _ (T_UnquotedSymbol _) }
  L_QuotedSymbol { PT _ (T_QuotedSymbol _) }
  L_Keyword { PT _ (T_Keyword $$) }

%%

Integer :: { Integer }
Integer  : L_integ  { (read ( $1)) :: Integer }

UnquotedSymbol :: { UnquotedSymbol}
UnquotedSymbol  : L_UnquotedSymbol { UnquotedSymbol (mkPosToken $1)}

QuotedSymbol :: { QuotedSymbol}
QuotedSymbol  : L_QuotedSymbol { QuotedSymbol (mkPosToken $1)}

Keyword :: { Keyword}
Keyword  : L_Keyword { Keyword ($1)}

Start :: { Start }
Start : ListDecl { Tip.Parser.AbsTIP.Start $1 }
ListDecl :: { [Decl] }
ListDecl : {- empty -} { [] } | '(' Decl ')' ListDecl { (:) $2 $4 }
Decl :: { Decl }
Decl : 'declare-datatype' AttrSymbol Datatype { Tip.Parser.AbsTIP.DeclareDatatype $2 $3 }
     | 'declare-datatypes' '(' ListDatatypeName ')' '(' ListDatatype ')' { Tip.Parser.AbsTIP.DeclareDatatypes (reverse $3) (reverse $6) }
     | 'declare-sort' AttrSymbol Integer { Tip.Parser.AbsTIP.DeclareSort $2 $3 }
     | 'declare-const' AttrSymbol ConstType { Tip.Parser.AbsTIP.DeclareConst $2 $3 }
     | 'declare-fun' AttrSymbol FunType { Tip.Parser.AbsTIP.DeclareFun $2 $3 }
     | 'define-fun' FunDec Expr { Tip.Parser.AbsTIP.DefineFun $2 $3 }
     | 'define-fun-rec' FunDec Expr { Tip.Parser.AbsTIP.DefineFunRec $2 $3 }
     | 'define-funs-rec' '(' ListBracketedFunDec ')' '(' ListExpr ')' { Tip.Parser.AbsTIP.DefineFunsRec (reverse $3) (reverse $6) }
     | Assertion ListAttr Expr { Tip.Parser.AbsTIP.Formula $1 (reverse $2) $3 }
     | Assertion ListAttr '(' Par Expr ')' { Tip.Parser.AbsTIP.FormulaPar $1 (reverse $2) $4 $5 }
     | 'set-logic' Symbol { Tip.Parser.AbsTIP.SetLogic $2 }
     | 'check-sat' { Tip.Parser.AbsTIP.CheckSat }
Assertion :: { Assertion }
Assertion : 'assert' { Tip.Parser.AbsTIP.Assert }
          | 'prove' { Tip.Parser.AbsTIP.Prove }
          | 'assert-claim' { Tip.Parser.AbsTIP.Claim }
Par :: { Par }
Par : 'par' '(' ListSymbol ')' { Tip.Parser.AbsTIP.Par (reverse $3) }
ConstType :: { ConstType }
ConstType : Type { Tip.Parser.AbsTIP.ConstTypeMono $1 }
          | '(' Par Type ')' { Tip.Parser.AbsTIP.ConstTypePoly $2 $3 }
InnerFunType :: { InnerFunType }
InnerFunType : '(' ListType ')' Type { Tip.Parser.AbsTIP.InnerFunType (reverse $2) $4 }
FunType :: { FunType }
FunType : InnerFunType { Tip.Parser.AbsTIP.FunTypeMono $1 }
        | '(' Par '(' InnerFunType ')' ')' { Tip.Parser.AbsTIP.FunTypePoly $2 $4 }
InnerFunDec :: { InnerFunDec }
InnerFunDec : '(' ListBinding ')' Type { Tip.Parser.AbsTIP.InnerFunDec (reverse $2) $4 }
FunDec :: { FunDec }
FunDec : AttrSymbol InnerFunDec { Tip.Parser.AbsTIP.FunDecMono $1 $2 }
       | AttrSymbol '(' Par '(' InnerFunDec ')' ')' { Tip.Parser.AbsTIP.FunDecPoly $1 $3 $5 }
BracketedFunDec :: { BracketedFunDec }
BracketedFunDec : '(' FunDec ')' { Tip.Parser.AbsTIP.BracketedFunDec $2 }
DatatypeName :: { DatatypeName }
DatatypeName : '(' AttrSymbol Integer ')' { Tip.Parser.AbsTIP.DatatypeName $2 $3 }
InnerDatatype :: { InnerDatatype }
InnerDatatype : '(' ListConstructor ')' { Tip.Parser.AbsTIP.InnerDatatype (reverse $2) }
Datatype :: { Datatype }
Datatype : InnerDatatype { Tip.Parser.AbsTIP.DatatypeMono $1 }
         | '(' Par InnerDatatype ')' { Tip.Parser.AbsTIP.DatatypePoly $2 $3 }
Constructor :: { Constructor }
Constructor : '(' AttrSymbol ListBinding ')' { Tip.Parser.AbsTIP.Constructor $2 (reverse $3) }
Binding :: { Binding }
Binding : '(' Symbol Type ')' { Tip.Parser.AbsTIP.Binding $2 $3 }
LetDecl :: { LetDecl }
LetDecl : '(' Symbol Expr ')' { Tip.Parser.AbsTIP.LetDecl $2 $3 }
Type :: { Type }
Type : Symbol { Tip.Parser.AbsTIP.TyVar $1 }
     | '(' Symbol ListType ')' { Tip.Parser.AbsTIP.TyApp $2 (reverse $3) }
     | '(' '=>' ListType ')' { Tip.Parser.AbsTIP.ArrowTy (reverse $3) }
     | 'Int' { Tip.Parser.AbsTIP.IntTy }
     | 'Real' { Tip.Parser.AbsTIP.RealTy }
     | 'Bool' { Tip.Parser.AbsTIP.BoolTy }
Expr :: { Expr }
Expr : PolySymbol { Tip.Parser.AbsTIP.Var $1 }
     | '(' Head ListExpr ')' { Tip.Parser.AbsTIP.App $2 (reverse $3) }
     | '(' 'match' Expr '(' ListCase ')' ')' { Tip.Parser.AbsTIP.Match $3 (reverse $5) }
     | '(' 'let' '(' ListLetDecl ')' Expr ')' { Tip.Parser.AbsTIP.Let (reverse $4) $6 }
     | '(' Binder '(' ListBinding ')' Expr ')' { Tip.Parser.AbsTIP.Binder $2 (reverse $4) $6 }
     | Lit { Tip.Parser.AbsTIP.Lit $1 }
Lit :: { Lit }
Lit : Integer { Tip.Parser.AbsTIP.LitInt $1 }
    | '-' Integer { Tip.Parser.AbsTIP.LitNegInt $2 }
    | 'true' { Tip.Parser.AbsTIP.LitTrue }
    | 'false' { Tip.Parser.AbsTIP.LitFalse }
Binder :: { Binder }
Binder : 'lambda' { Tip.Parser.AbsTIP.Lambda }
       | 'forall' { Tip.Parser.AbsTIP.Forall }
       | 'exists' { Tip.Parser.AbsTIP.Exists }
Case :: { Case }
Case : '(' Pattern Expr ')' { Tip.Parser.AbsTIP.Case $2 $3 }
Pattern :: { Pattern }
Pattern : '_' { Tip.Parser.AbsTIP.Default }
        | '(' Symbol ListSymbol ')' { Tip.Parser.AbsTIP.ConPat $2 (reverse $3) }
        | Symbol { Tip.Parser.AbsTIP.SimplePat $1 }
        | Lit { Tip.Parser.AbsTIP.LitPat $1 }
Head :: { Head }
Head : PolySymbol { Tip.Parser.AbsTIP.Const $1 }
     | '@' { Tip.Parser.AbsTIP.At }
     | 'ite' { Tip.Parser.AbsTIP.IfThenElse }
     | 'and' { Tip.Parser.AbsTIP.And }
     | 'or' { Tip.Parser.AbsTIP.Or }
     | 'not' { Tip.Parser.AbsTIP.Not }
     | '=>' { Tip.Parser.AbsTIP.Implies }
     | '=' { Tip.Parser.AbsTIP.Equal }
     | 'distinct' { Tip.Parser.AbsTIP.Distinct }
     | '+' { Tip.Parser.AbsTIP.NumAdd }
     | '-' { Tip.Parser.AbsTIP.NumSub }
     | '*' { Tip.Parser.AbsTIP.NumMul }
     | '/' { Tip.Parser.AbsTIP.NumDiv }
     | 'div' { Tip.Parser.AbsTIP.IntDiv }
     | 'mod' { Tip.Parser.AbsTIP.IntMod }
     | '>' { Tip.Parser.AbsTIP.NumGt }
     | '>=' { Tip.Parser.AbsTIP.NumGe }
     | '<' { Tip.Parser.AbsTIP.NumLt }
     | '<=' { Tip.Parser.AbsTIP.NumLe }
     | 'to_real' { Tip.Parser.AbsTIP.NumWiden }
PolySymbol :: { PolySymbol }
PolySymbol : Symbol { Tip.Parser.AbsTIP.NoAs $1 }
           | '(' '_' Symbol ListType ')' { Tip.Parser.AbsTIP.As $3 (reverse $4) }
AttrSymbol :: { AttrSymbol }
AttrSymbol : Symbol ListAttr { Tip.Parser.AbsTIP.AttrSymbol $1 (reverse $2) }
Attr :: { Attr }
Attr : Keyword { Tip.Parser.AbsTIP.NoValue $1 }
     | Keyword Symbol { Tip.Parser.AbsTIP.Value $1 $2 }
ListLetDecl :: { [LetDecl] }
ListLetDecl : {- empty -} { [] }
            | ListLetDecl LetDecl { flip (:) $1 $2 }
ListCase :: { [Case] }
ListCase : {- empty -} { [] } | ListCase Case { flip (:) $1 $2 }
ListExpr :: { [Expr] }
ListExpr : {- empty -} { [] } | ListExpr Expr { flip (:) $1 $2 }
ListDatatype :: { [Datatype] }
ListDatatype : {- empty -} { [] }
             | ListDatatype Datatype { flip (:) $1 $2 }
ListConstructor :: { [Constructor] }
ListConstructor : {- empty -} { [] }
                | ListConstructor Constructor { flip (:) $1 $2 }
ListBinding :: { [Binding] }
ListBinding : {- empty -} { [] }
            | ListBinding Binding { flip (:) $1 $2 }
ListSymbol :: { [Symbol] }
ListSymbol : {- empty -} { [] }
           | ListSymbol Symbol { flip (:) $1 $2 }
ListType :: { [Type] }
ListType : {- empty -} { [] } | ListType Type { flip (:) $1 $2 }
ListFunDec :: { [FunDec] }
ListFunDec : {- empty -} { [] }
           | ListFunDec FunDec { flip (:) $1 $2 }
ListBracketedFunDec :: { [BracketedFunDec] }
ListBracketedFunDec : {- empty -} { [] }
                    | ListBracketedFunDec BracketedFunDec { flip (:) $1 $2 }
ListAttr :: { [Attr] }
ListAttr : {- empty -} { [] } | ListAttr Attr { flip (:) $1 $2 }
ListDatatypeName :: { [DatatypeName] }
ListDatatypeName : {- empty -} { [] }
                 | ListDatatypeName DatatypeName { flip (:) $1 $2 }
Symbol :: { Symbol }
Symbol : UnquotedSymbol { Tip.Parser.AbsTIP.Unquoted $1 }
       | QuotedSymbol { Tip.Parser.AbsTIP.Quoted $1 }
{

returnM :: a -> Err a
returnM = return

thenM :: Err a -> (a -> Err b) -> Err b
thenM = (>>=)

happyError :: [Token] -> Err a
happyError ts =
  Bad $ "syntax error at " ++ tokenPos ts ++
  case ts of
    []      -> []
    [Err _] -> " due to lexer error"
    t:_     -> " before `" ++ id(prToken t) ++ "'"

myLexer = tokens
}

