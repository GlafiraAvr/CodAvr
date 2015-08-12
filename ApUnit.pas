unit ApUnit;

interface 
 
uses Math; 
 
//////////////////////////////////////////////////////////////////////// / 
// константы 
//////////////////////////////////////////////////////////////////////// / 
const 
    MachineEpsilon = 5E-16; 
    MaxRealNumber = 1E300; 
    MinRealNumber = 1E-300; 
 
//////////////////////////////////////////////////////////////////////// / 
// массивы 
//////////////////////////////////////////////////////////////////////// / 
type 
    TInteger1DArray     = array of LongInt; 
    TReal1DArray   = array of Double; 
    TBoolean1DArray     = array of Boolean; 
 
    TInteger2DArray     = array of array of LongInt; 
    TReal2DArray   = array of array of Double; 
    TBoolean2DArray     = array of array of Boolean; 
 
//////////////////////////////////////////////////////////////////////// / 
// Функции/процедуры 
//////////////////////////////////////////////////////////////////////// / 
function AbsReal(X : Extended):Extended; 
function AbsInt (I : Integer):Integer; 
function RandomReal():Extended; 
function RandomInteger(I : Integer):Integer; 
function Sign(X:Extended):Integer; 
 
function DynamicArrayCopy(const A: TInteger1DArray):TInteger1DArray;overload; 
function DynamicArrayCopy(const A: TReal1DArray):TReal1DArray;overload; 
function DynamicArrayCopy(const A: TBoolean1DArray):TBoolean1DArray;overload; 
 
function DynamicArrayCopy(const A: TInteger2DArray):TInteger2DArray;overload; 
function DynamicArrayCopy(const A: TReal2DArray):TReal2DArray;overload; 
function DynamicArrayCopy(const A: TBoolean2DArray):TBoolean2DArray;overload; 
 
 
implementation 
 
//////////////////////////////////////////////////////////////////////// / 
// Функции/процедуры 
//////////////////////////////////////////////////////////////////////// / 
function AbsReal(X : Extended):Extended; 
begin 
    Result := Abs(X); 
end; 
 
function AbsInt (I : Integer):Integer; 
begin 
    Result := Abs(I); 
end; 
 
function RandomReal():Extended; 
begin 
    Result := Random; 
end; 
 
function RandomInteger(I : Integer):Integer; 
begin 
    Result := Random(I); 
end; 
 
function Sign(X:Extended):Integer; 
begin 
    if X>0 then 
   Result := 1 
    else if X<0 then 
   Result := -1 
    else 
   Result := 0; 
end; 
 
//////////////////////////////////////////////////////////////////////// / 
// копирование динамических массивов 
//////////////////////////////////////////////////////////////////////// / 
function DynamicArrayCopy(const A: TInteger1DArray):TInteger1DArray;overload; 
var 
    I:  Integer; 
begin 
    SetLength(Result, High(A)+1); 
    for I:=Low(A) to High(A) do 
   Result[I]:=A[I]; 
end; 
 
function DynamicArrayCopy(const A: TReal1DArray):TReal1DArray;overload; 
var 
    I:  Integer; 
begin 
    SetLength(Result, High(A)+1); 
    for I:=Low(A) to High(A) do 
   Result[I]:=A[I]; 
end; 
 
function DynamicArrayCopy(const A: TBoolean1DArray):TBoolean1DArray;overload; 
var 
    I:  Integer; 
begin 
    SetLength(Result, High(A)+1); 
    for I:=Low(A) to High(A) do 
   Result[I]:=A[I]; 
end; 
 
function DynamicArrayCopy(const A: TInteger2DArray):TInteger2DArray;overload; 
var 
    I,J:    Integer; 
begin 
    SetLength(Result, High(A)+1); 
    for I:=Low(A) to High(A) do 
    begin 
   SetLength(Result[I], High(A[I])+1); 
   for J:=Low(A[I]) to High(A[I]) do 
  Result[I,J]:=A[I,J]; 
    end; 
end; 
 
function DynamicArrayCopy(const A: TReal2DArray):TReal2DArray;overload; 
var 
    I,J:    Integer; 
begin 
    SetLength(Result, High(A)+1); 
    for I:=Low(A) to High(A) do 
    begin 
   SetLength(Result[I], High(A[I])+1); 
   for J:=Low(A[I]) to High(A[I]) do 
  Result[I,J]:=A[I,J]; 
    end; 
end; 
 
function DynamicArrayCopy(const A: TBoolean2DArray):TBoolean2DArray;overload; 
var 
    I,J:    Integer; 
begin 
    SetLength(Result, High(A)+1); 
    for I:=Low(A) to High(A) do 
    begin 
   SetLength(Result[I], High(A[I])+1); 
   for J:=Low(A[I]) to High(A[I]) do 
  Result[I,J]:=A[I,J]; 
    end; 
end; 
 
end. 

