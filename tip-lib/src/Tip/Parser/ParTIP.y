-- This Happy file was machine-generated by the BNF converter
{
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module Tip.Parser.ParTIP where
import qualified Tip.Parser.AbsTIP
import Tip.Parser.LexTIP
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
%monad { Either String } { (>>=) } { return }
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
  'check-sat' { PT _ (TS _ 20) }
  'declare-const' { PT _ (TS _ 21) }
  'declare-datatype' { PT _ (TS _ 22) }
  'declare-datatypes' { PT _ (TS _ 23) }
  'declare-fun' { PT _ (TS _ 24) }
  'declare-sort' { PT _ (TS _ 25) }
  'define-fun' { PT _ (TS _ 26) }
  'define-fun-rec' { PT _ (TS _ 27) }
  'define-funs-rec' { PT _ (TS _ 28) }
  'distinct' { PT _ (TS _ 29) }
  'div' { PT _ (TS _ 30) }
  'exists' { PT _ (TS _ 31) }
  'false' { PT _ (TS _ 32) }
  'forall' { PT _ (TS _ 33) }
  'ite' { PT _ (TS _ 34) }
  'lambda' { PT _ (TS _ 35) }
  'let' { PT _ (TS _ 36) }
  'match' { PT _ (TS _ 37) }
  'mod' { PT _ (TS _ 38) }
  'not' { PT _ (TS _ 39) }
  'or' { PT _ (TS _ 40) }
  'par' { PT _ (TS _ 41) }
  'prove' { PT _ (TS _ 42) }
  'set-logic' { PT _ (TS _ 43) }
  'to_real' { PT _ (TS _ 44) }
  'true' { PT _ (TS _ 45) }
  L_integ  { PT _ (TI $$) }
  L_UnquotedSymbol { PT _ (T_UnquotedSymbol _) }
  L_QuotedSymbol { PT _ (T_QuotedSymbol _) }
  L_Keyword { PT _ (T_Keyword $$) }

%%

Integer :: { Integer }
Integer  : L_integ  { (read ($1)) :: Integer }

UnquotedSymbol :: { Tip.Parser.AbsTIP.UnquotedSymbol}
UnquotedSymbol  : L_UnquotedSymbol { Tip.Parser.AbsTIP.UnquotedSymbol (mkPosToken $1) }

QuotedSymbol :: { Tip.Parser.AbsTIP.QuotedSymbol}
QuotedSymbol  : L_QuotedSymbol { Tip.Parser.AbsTIP.QuotedSymbol (mkPosToken $1) }

Keyword :: { Tip.Parser.AbsTIP.Keyword}
Keyword  : L_Keyword { Tip.Parser.AbsTIP.Keyword $1 }

Start :: { Tip.Parser.AbsTIP.Start }
Start : ListDecl { Tip.Parser.AbsTIP.Start $1 }

ListDecl :: { [Tip.Parser.AbsTIP.Decl] }
ListDecl : {- empty -} { [] } | '(' Decl ')' ListDecl { (:) $2 $4 }

Decl :: { Tip.Parser.AbsTIP.Decl }
Decl : 'declare-datatype' AttrSymbol Datatype { Tip.Parser.AbsTIP.DeclareDatatype $2 $3 }
     | 'declare-datatypes' '(' ListDatatypeName ')' '(' ListDatatype ')' { Tip.Parser.AbsTIP.DeclareDatatypes $3 $6 }
     | 'declare-sort' AttrSymbol Integer { Tip.Parser.AbsTIP.DeclareSort $2 $3 }
     | 'declare-const' AttrSymbol ConstType { Tip.Parser.AbsTIP.DeclareConst $2 $3 }
     | 'declare-fun' AttrSymbol FunType { Tip.Parser.AbsTIP.DeclareFun $2 $3 }
     | 'define-fun' FunDec Expr { Tip.Parser.AbsTIP.DefineFun $2 $3 }
     | 'define-fun-rec' FunDec Expr { Tip.Parser.AbsTIP.DefineFunRec $2 $3 }
     | 'define-funs-rec' '(' ListBracketedFunDec ')' '(' ListExpr ')' { Tip.Parser.AbsTIP.DefineFunsRec $3 $6 }
     | Assertion ListAttr Expr { Tip.Parser.AbsTIP.Formula $1 $2 $3 }
     | Assertion ListAttr '(' Par Expr ')' { Tip.Parser.AbsTIP.FormulaPar $1 $2 $4 $5 }
     | 'set-logic' Symbol { Tip.Parser.AbsTIP.SetLogic $2 }
     | 'check-sat' { Tip.Parser.AbsTIP.CheckSat }

Assertion :: { Tip.Parser.AbsTIP.Assertion }
Assertion : 'assert' { Tip.Parser.AbsTIP.Assert }
          | 'prove' { Tip.Parser.AbsTIP.Prove }

Par :: { Tip.Parser.AbsTIP.Par }
Par : 'par' '(' ListSymbol ')' { Tip.Parser.AbsTIP.Par $3 }

ConstType :: { Tip.Parser.AbsTIP.ConstType }
ConstType : Type { Tip.Parser.AbsTIP.ConstTypeMono $1 }
          | '(' Par Type ')' { Tip.Parser.AbsTIP.ConstTypePoly $2 $3 }

InnerFunType :: { Tip.Parser.AbsTIP.InnerFunType }
InnerFunType : '(' ListType ')' Type { Tip.Parser.AbsTIP.InnerFunType $2 $4 }

FunType :: { Tip.Parser.AbsTIP.FunType }
FunType : InnerFunType { Tip.Parser.AbsTIP.FunTypeMono $1 }
        | '(' Par '(' InnerFunType ')' ')' { Tip.Parser.AbsTIP.FunTypePoly $2 $4 }

InnerFunDec :: { Tip.Parser.AbsTIP.InnerFunDec }
InnerFunDec : '(' ListBinding ')' Type { Tip.Parser.AbsTIP.InnerFunDec $2 $4 }

FunDec :: { Tip.Parser.AbsTIP.FunDec }
FunDec : AttrSymbol InnerFunDec { Tip.Parser.AbsTIP.FunDecMono $1 $2 }
       | AttrSymbol '(' Par '(' InnerFunDec ')' ')' { Tip.Parser.AbsTIP.FunDecPoly $1 $3 $5 }

BracketedFunDec :: { Tip.Parser.AbsTIP.BracketedFunDec }
BracketedFunDec : '(' FunDec ')' { Tip.Parser.AbsTIP.BracketedFunDec $2 }

DatatypeName :: { Tip.Parser.AbsTIP.DatatypeName }
DatatypeName : '(' AttrSymbol Integer ')' { Tip.Parser.AbsTIP.DatatypeName $2 $3 }

InnerDatatype :: { Tip.Parser.AbsTIP.InnerDatatype }
InnerDatatype : '(' ListConstructor ')' { Tip.Parser.AbsTIP.InnerDatatype $2 }

Datatype :: { Tip.Parser.AbsTIP.Datatype }
Datatype : InnerDatatype { Tip.Parser.AbsTIP.DatatypeMono $1 }
         | '(' Par InnerDatatype ')' { Tip.Parser.AbsTIP.DatatypePoly $2 $3 }

Constructor :: { Tip.Parser.AbsTIP.Constructor }
Constructor : '(' AttrSymbol ListBinding ')' { Tip.Parser.AbsTIP.Constructor $2 $3 }

Binding :: { Tip.Parser.AbsTIP.Binding }
Binding : '(' Symbol Type ')' { Tip.Parser.AbsTIP.Binding $2 $3 }

LetDecl :: { Tip.Parser.AbsTIP.LetDecl }
LetDecl : '(' Symbol Expr ')' { Tip.Parser.AbsTIP.LetDecl $2 $3 }

Type :: { Tip.Parser.AbsTIP.Type }
Type : Symbol { Tip.Parser.AbsTIP.TyVar $1 }
     | '(' Symbol ListType ')' { Tip.Parser.AbsTIP.TyApp $2 $3 }
     | '(' '=>' ListType ')' { Tip.Parser.AbsTIP.ArrowTy $3 }
     | 'Int' { Tip.Parser.AbsTIP.IntTy }
     | 'Real' { Tip.Parser.AbsTIP.RealTy }
     | 'Bool' { Tip.Parser.AbsTIP.BoolTy }

Expr :: { Tip.Parser.AbsTIP.Expr }
Expr : PolySymbol { Tip.Parser.AbsTIP.Var $1 }
     | '(' Head ListExpr ')' { Tip.Parser.AbsTIP.App $2 $3 }
     | '(' 'match' Expr '(' ListCase ')' ')' { Tip.Parser.AbsTIP.Match $3 $5 }
     | '(' 'let' '(' ListLetDecl ')' Expr ')' { Tip.Parser.AbsTIP.Let $4 $6 }
     | '(' Binder '(' ListBinding ')' Expr ')' { Tip.Parser.AbsTIP.Binder $2 $4 $6 }
     | Lit { Tip.Parser.AbsTIP.Lit $1 }

Lit :: { Tip.Parser.AbsTIP.Lit }
Lit : Integer { Tip.Parser.AbsTIP.LitInt $1 }
    | '-' Integer { Tip.Parser.AbsTIP.LitNegInt $2 }
    | 'true' { Tip.Parser.AbsTIP.LitTrue }
    | 'false' { Tip.Parser.AbsTIP.LitFalse }

Binder :: { Tip.Parser.AbsTIP.Binder }
Binder : 'lambda' { Tip.Parser.AbsTIP.Lambda }
       | 'forall' { Tip.Parser.AbsTIP.Forall }
       | 'exists' { Tip.Parser.AbsTIP.Exists }

Case :: { Tip.Parser.AbsTIP.Case }
Case : '(' Pattern Expr ')' { Tip.Parser.AbsTIP.Case $2 $3 }

Pattern :: { Tip.Parser.AbsTIP.Pattern }
Pattern : '_' { Tip.Parser.AbsTIP.Default }
        | '(' Symbol ListSymbol ')' { Tip.Parser.AbsTIP.ConPat $2 $3 }
        | Symbol { Tip.Parser.AbsTIP.SimplePat $1 }
        | Lit { Tip.Parser.AbsTIP.LitPat $1 }

Head :: { Tip.Parser.AbsTIP.Head }
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

PolySymbol :: { Tip.Parser.AbsTIP.PolySymbol }
PolySymbol : Symbol { Tip.Parser.AbsTIP.NoAs $1 }
           | '(' '_' Symbol ListType ')' { Tip.Parser.AbsTIP.As $3 $4 }

AttrSymbol :: { Tip.Parser.AbsTIP.AttrSymbol }
AttrSymbol : Symbol ListAttr { Tip.Parser.AbsTIP.AttrSymbol $1 $2 }

Attr :: { Tip.Parser.AbsTIP.Attr }
Attr : Keyword { Tip.Parser.AbsTIP.NoValue $1 }
     | Keyword Symbol { Tip.Parser.AbsTIP.Value $1 $2 }

ListLetDecl :: { [Tip.Parser.AbsTIP.LetDecl] }
ListLetDecl : {- empty -} { [] }
            | LetDecl ListLetDecl { (:) $1 $2 }

ListCase :: { [Tip.Parser.AbsTIP.Case] }
ListCase : {- empty -} { [] } | Case ListCase { (:) $1 $2 }

ListExpr :: { [Tip.Parser.AbsTIP.Expr] }
ListExpr : {- empty -} { [] } | Expr ListExpr { (:) $1 $2 }

ListDatatype :: { [Tip.Parser.AbsTIP.Datatype] }
ListDatatype : {- empty -} { [] }
             | Datatype ListDatatype { (:) $1 $2 }

ListConstructor :: { [Tip.Parser.AbsTIP.Constructor] }
ListConstructor : {- empty -} { [] }
                | Constructor ListConstructor { (:) $1 $2 }

ListBinding :: { [Tip.Parser.AbsTIP.Binding] }
ListBinding : {- empty -} { [] }
            | Binding ListBinding { (:) $1 $2 }

ListSymbol :: { [Tip.Parser.AbsTIP.Symbol] }
ListSymbol : {- empty -} { [] } | Symbol ListSymbol { (:) $1 $2 }

ListType :: { [Tip.Parser.AbsTIP.Type] }
ListType : {- empty -} { [] } | Type ListType { (:) $1 $2 }

ListFunDec :: { [Tip.Parser.AbsTIP.FunDec] }
ListFunDec : {- empty -} { [] } | FunDec ListFunDec { (:) $1 $2 }

ListBracketedFunDec :: { [Tip.Parser.AbsTIP.BracketedFunDec] }
ListBracketedFunDec : {- empty -} { [] }
                    | BracketedFunDec ListBracketedFunDec { (:) $1 $2 }

ListAttr :: { [Tip.Parser.AbsTIP.Attr] }
ListAttr : {- empty -} { [] } | Attr ListAttr { (:) $1 $2 }

ListDatatypeName :: { [Tip.Parser.AbsTIP.DatatypeName] }
ListDatatypeName : {- empty -} { [] }
                 | DatatypeName ListDatatypeName { (:) $1 $2 }

Symbol :: { Tip.Parser.AbsTIP.Symbol }
Symbol : UnquotedSymbol { Tip.Parser.AbsTIP.Unquoted $1 }
       | QuotedSymbol { Tip.Parser.AbsTIP.Quoted $1 }
{

happyError :: [Token] -> Either String a
happyError ts = Left $
  "syntax error at " ++ tokenPos ts ++
  case ts of
    []      -> []
    [Err _] -> " due to lexer error"
    t:_     -> " before `" ++ (prToken t) ++ "'"

myLexer = tokens
}

