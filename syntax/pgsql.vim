" Vim syntax file
" Language:     pgsql
" Maintainer:   Gregory Higley <code at revolucent dot net>
" License: MIT
" Last Change:  $Date: 2014/09/10 20:40:00 $
" Filenames:    *.psql *.pgsql *.plpgsql
" URL:		http://www.revolucent.net
" Note:   This file began with work done by Devrim Gunduz (devrim@postgresql.org).
"         Very little of his original work remains,
"         but I consider it proper to give him credit where credit is due. I
"         ask that if you create a derivative work, you credit both Gregory
"         Higley and Devrim Gunduz.
"
" Copyright (c) 2014 Gregory Higley
"
" Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
" files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,
" modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software
" is furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
" OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
" LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
" CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


if exists("b:current_syntax") | finish | endif

syn case ignore

syn region pgComment start="/\*" end="\*/"
syn match pgComment "#.*"
syn match pgComment	"--.*"
syn sync ccomment pgComment

syn region pgString start=+\$\$+ end=+\$\$+
syn region pgString	start=+'+  skip=+\\\\\|\\'+ end=+'+
syn region pgMultilineString start=+\$\z(\w*\)\$+ end=+\$\z1\$+

syn region pgQuotedIdentifier start=+"+ skip=+\\\\\|\\"+ end=+"+

syn match pgNumber "-\=\<[0-9]*\>"
syn match pgNumber "-\=\<[0-9]*\.[0-9]*\>"
syn match pgNumber "-\=\<[0-9]*e[+-]\=[0-9]*\>"
syn match pgNumber "-\=\<[0-9]*\.[0-9]*e[+-]\=[0-9]*\>"
syn match pgNumber "\<0x[abcdefABCDEF0-9]*\>"

syn match pgCommand "\\[A-Za-z][A-Za-z0-9]*"

syn keyword pgConstant both btree current_date current_timestamp false found gin gist null plpgsql sql tg_table_name true

syn match pgLabel "<<\w\+>>"

syn keyword pgKeyword abort alter after aggregate all analyze and any alias add array
syn keyword pgKeyword begin by before between
syn keyword pgKeyword commit continue conversion cascade class close constant
syn keyword pgKeyword cluster checkpoint comment
syn keyword pgKeyword case cast cascade character check column columns constraint copy cross
syn keyword pgKeyword database domain databases default delete distinct drop declare deallocate desc
syn keyword pgKeyword deferrable deferred defaults do diagnostics
syn keyword pgKeyword else exception explain elsif encrypted end enum exists execute exclusion exception except exit
syn keyword pgKeyword function functions foreach foreign from full fetch force for
syn keyword pgKeyword group grant global get
syn keyword pgKeyword having 
syn keyword pgKeyword ilike including index into immutable inner initially immediate inherits instead insert in inout if is interval
syn keyword pgKeyword join
syn keyword pgKeyword language last lock local like limit left load login loop
syn keyword pgKeyword max maxvalue min minvalue move match
syn keyword pgKeyword not notice notify no next nulls
syn keyword pgKeyword offset or operator outer order on out open over
syn keyword pgKeyword prepare primary password primary privilege procedure partial prepared
syn keyword pgKeyword partition preserve perform privileges
syn keyword pgKeyword query
syn keyword pgKeyword raise recursive role replace reindex release reset revoke rollback references row rows rowtype rule restrict
syn keyword pgKeyword return returning
syn keyword pgKeyword select sequences set strict schema sequence savepoint simple some system stable setof
syn keyword pgKeyword truncate to transaction table tables temp temporary tablespace then trigger
syn keyword pgKeyword update union unique unlisten usage using
syn keyword pgKeyword variadic verbose view values varying vacuum volatile
syn keyword pgKeyword when where

syn region pgCheck start="(" end=")" contained contains=TOP
syn keyword pgKeyword check nextgroup=pgCheck skipwhite skipempty
syn keyword pgVariable value contained containedin=pgCheck

syn region pgCode matchgroup=pgDelimiter start=+\$\z(\w*\)\$+ end=+\$\z1\$+ contained contains=TOP
syn keyword pgKeyword as nextgroup=pgCode skipwhite skipempty
syn keyword pgKeyword do nextgroup=pgCode skipwhite skipempty

syn match pgExtensionName "[A-Za-z_][A-Za-z0-9_]*" contained
syn keyword pgExtension extension contained nextgroup=pgExtensionName skipwhite skipempty;
syn keyword pgCreated type contained
syn keyword pgKeyword create nextgroup=pgCreated,pgExtension skipwhite skipempty
syn keyword pgKeyword drop nextgroup=pgCreated skipwhite skipempty

syn keyword pgTrigger trigger contained
syn keyword pgKeyword returns nextgroup=pgTrigger skipwhite skipempty

syn keyword pgRow row contained
syn keyword pgKeyword each nextgroup=pgRow skipwhite skipempty

syn keyword pgWithKeyword header format quote contained
syn keyword pgWithConstant csv contained
syn region pgWith start="(" end=")" contained contains=pgWithKeyword,pgWithConstant,pgKeyword,pgConstant,pgString
syn keyword pgKeyword with nextgroup=pgWith skipwhite skipempty

syn match pgVariable "\<_[A-Za-z0-9][A-Za-z0-9_]*\>" 
syn match pgVariable "\$[0-9]\+" 
syn keyword pgvariable new old tg_op tg_when

syn keyword pgType anyarray anyelement bigint bigserial boolean bytea date geography geometry hstore int integer numeric point record serial text timestamp uuid void

syn keyword pgKey key contained
syn keyword pgKeyword primary nextgroup=pgKey skipwhite skipempty foreign nextgroup=pgKey skipwhite skipempty 

function! s:MatchFunction(...)
  for name in a:000
    " Note that I'm using an ampersand as the delimiter and that everything
    " has to be double-escaped with \\
    exec "syn match pgFunction &\\<" . name . "\\(\\s*\\|\\n\\)\\+(&he=e-1"
  endfor
endfunction
com! -nargs=+ PGMatchFunction call <SID>MatchFunction(<f-args>)

PGMatchFunction akeys array_agg array_length array_remove array_to_string array_upper
PGMatchFunction ceil char_length coalesce count
PGMatchFunction each extract
PGMatchFunction floor
PGMatchFunction hstore
PGMatchFunction lower
PGMatchFunction md5
PGMatchFunction nextval
PGMatchFunction octet_length
PGMatchFunction position pg_typeof
PGMatchFunction quote_ident quote_literal
PGMatchFunction regexp_matches regexp_replace replace round row_number
PGMatchFunction skeys
PGMatchFunction st_distance st_setsrid st_makepoint
PGMatchFunction string_to_array substring sum svals
PGMatchFunction plainto_tsquery to_tsvector trim
PGMatchFunction upper uuid_generate_v4 unnest
PGMatchFunction year

delc PGMatchFunction

com! -nargs=+ PGHi hi def link <args>

PGHi pgCommand Special
PGHi pgComment Comment
PGHi pgConstant Constant
PGHi pgCreated Keyword
PGHi pgDelimiter Delimiter
PGHi pgExtension Keyword
PGHi pgExtensionName Normal
PGHi pgFunction Function
PGHi pgKey Keyword
PGHi pgKeyword Keyword
PGHi pgLabel Special
PGHi pgNumber Number
PGHi pgKeyword Keyword
PGHi pgString String
PGHi pgMultilineString String
PGHi pgRow Keyword
PGHi pgTrigger Type
PGHi pgType Type
PGHi pgVariable Identifier
PGHi pgWithConstant Constant
PGHi pgWithKeyword Keyword

delc PGHi
