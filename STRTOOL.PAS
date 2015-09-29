unit strtool;

interface
uses classes;
CONST
    Floating = 255;
    numsym: set of 0..255 =[48..57,44..46];
type locPars=record {позиция разделителей для слова}
     B_p, {начало пердшествующего разделителя}
     B_w, {начало слова}
     E_w,  {конец слова}
     E_p:smallint; {конец замыкающего разделителя}
end;

{ добавляет в TStrings строку S в отсортированном порядке}
{ Возращает индекс(0 base) в списке добавленной строки,}
{           либо -1 в случае ошибки(пустая строка)}
function SortAddStr(const s:string;Items:TStrings):integer;




{----------------------------------------------------}
 {////////////////////////////////////////////}
{$IFDEF WIN32}
 {вернуть строку длиной  l  заполненную символом  Pad}
 function FillStr(l:integer;pad:char): string;
{$ENDIF WIN32}
{==================================================}
{===================== разбор строк с разделителями =============}
{----------------------------------------------------}
Function LocWordPars(StartAT,Wordno:integer;Str:string;pars:string;RepeatPars:boolean):locPars;
{позиция слова если  wordno<0  то отсчет с конца  }
Function PosWord(Wordno:integer;Str:string):integer;
{то же но с указанием списка разделителей и допустимости пустых слов}
Function PosWordx(Wordno:integer;Str:string;pars:string;emptyword:boolean):integer;

{позиция слова если  wordno<0  то отсчет с конца  }
Function PosWord_(Wordno:integer;Str:string):integer;
{то же но с указанием списка разделителей и допустимости пустых слов}
Function PosWordx_(Wordno:integer;Str:string;pars:string;RepeatPars:boolean):integer;
{----------------------------------------------------}
{извлечь слово WordI <0  то отсчет с конца }
Function ExtractWords(WordI,NoWords:integer;Str:string):string;
{то же но с указанием списка разделителей и допустимости пустых слов}
Function ExtractWordsx(WordI,NoWords:integer;Str:string;pars:string;emptyword:boolean):string;
{----------------------------------------------------}
{----------------------------------------------------}
{извлечь слово WordI <0  то отсчет с конца }
Function ExtractWords_(WordI,NoWords:integer;Str:string):string;
{то же но с указанием списка разделителей и допустимости пустых слов}
Function ExtractWordsx_(WordI,NoWords:integer;Str:string;pars:string;RepeatPars:boolean):string;
{----------------------------------------------------}

{////////////=======================================////////////////////}

{----------------------------------------------------}
{пропорционально разредить строку пробелами между словами}
 function  redstr (s:string;l:integer):string;
{----------------------------------------------------}
 {установить длину строки равной l:усечь или дополнить пробелами}
 function  setlen (s:string;l:integer):string;
{ системная фия  setlength}
{----------------------------------------------------}
{сжимает строку или расширяет до Width
 L='R'-справа 'L' -слева
 если усекает то вставляет символ ->   }

Function Squeeze(L:char;Str:string;Width:integer): string;
{----------------------------------------------------}
  {первая заглавная буква в строке}
Function First_Capital(Str:string): char;
{----------------------------------------------------}
  {расширитьстроку символом PAD  слева}
Function PadLeft(Str:string;Size:integer;Pad:char):string;
{----------------------------------------------------}
{....по центру}
Function PadCenter(Str:string;Size:integer;Pad:char):string;
{----------------------------------------------------}
{......справа}
Function PadRight(Str:string;Size:integer;Pad:char):string;
{----------------------------------------------------}
{последние N символов строки}

Function Last(N:integer;Str:string):string;
{----------------------------------------------------}
{первые .........}
Function First(N:integer;Str:string):string;
{----------------------------------------------------}
{верхний рег}
Function Upper(Str:string):string;
{----------------------------------------------------}
{нижний}
Function Lower(Str:string):string;
{----------------------------------------------------}
{противоположный.....}
Function Proper(Str:string):string;
{----------------------------------------------------}
{переписывает с N позиции в StrT  содержимое StrS ,затирая остаток StrT}
Function OverType(N:integer;StrS,StrT:string):string;
{----------------------------------------------------}
{удаляет символы С из строки;
 L: 'L'- все лидирующие 'R'- все последние 'B' -слева и справа
 и лишние 'A'-все  }
Function Strip(L:char;C:string;Str:string):string;
{----------------------------------------------------}
         {последнее вхождение символа в строку}
Function LastPos(C:Char;Str:string):integer;
{----------------------------------------------------}
Function RepChar (srcChar,RepChar:char;s:string):string;
 {заменить в строке srcChar на RepChar}
{-----------------------------------------------------------------------}
{//////////////}
{извлечь подстроку фикс длины из строки  разрывая строку по  пробелу )}
{использовать для переформатирования  memo}
Function ExtractLineFix(StartLine,LenLine:integer;Str:string):string;
{-------------------------------------}
{счетчик подстрок фикс длины из строки  разрывая строку по пробелу )}
{использовать для переформатирования  memo}
Function LineCntFix(Str:string;LenLine:integer):integer;
{----------------------------------------------------}
Function Str_to_Int(Str:string):integer;
{----------------------------------------------------}
Function Str_to_Long(Str:string):Longint;
{----------------------------------------------------}
Function Str_to_float(Str:string):extended;
{----------------------------------------------------}
Function float_to_str(Number:extended;Decimals:integer):string;
{----------------------------------------------------}
Function Int_to_Str(Number:longint):string;
{----------------------------------------------------}
{строка в общенаучном формате}
Function float_to_SciStr(Number:extended; D:integer):string;
{----------------------------------------------------}
{перекодировка DOS->Windows Cyr}
Function DostoWin(Str:string):string;
{----------------------------------------------------}
{перекодировка Windows->DOS Cyr}
Function WintoDos(Str:string):string;
{----------------------------------------------------}
{сравнение двух строк без учета регистра и разделителей:пробел,запятая,точка}
 function StrCmpI(str1,str2:string):shortint;
{----------------------------------------------------}
{тоже но сравнивается первая строка(короткая) и начало 2(длинной)}
 function StrCmpIf(str1,str2:string):boolean;
{=============================}
function findlist(strlst:tstrings;fndstr:string):integer;

procedure repstrlst(strlst:tstrings;fndstr,newstr:string); {заменить}
            { в stringlst вхождения fndstr ->newstr}
{////////////=======================================////////////////////}
{-------------------------------------}
{счетчик слов в списке с парными ограничителями  ()}
Function WordCntParent(Str:string;parent:string):integer;
{-------------------------------------}
{позиция слова из списка с парными ограничителями  }
Function PosWordParent(WordI:integer;Str:string;parent:string):integer;
{----------------------------------------------------}
{извлечь слово из списка с парными ограничителями  ()}
Function ExtractWordParent(WordI:integer;Str:string;parent:string):string;
{===============================================================}
{удалить слова,начиная с WordI,if WordI <0  то отсчет с конца}
Function DelWordsx(WordI,NoWords:integer;Str:string;const pars:string;const emptyword:boolean):string;
function DelwordS(WordI,NoWords:integer;Str:string):string;
{----------------------------------------------------}
{вставить слово,после WordI,if WordI <0  то отсчет с конца}
{если emptyw=true и слов меньше чем  WordI,вставляем pars[1]}
function InsWordSx(WordI,NoWords:integer;Str,Newword:string;pars:string;emptyword:boolean):string;
function InsWordS(WordI,NoWords:integer;Str,Newword:string):string;
{----------------------------------------------------}
{заменить слово WordI,if WordI <0  то отсчет с конца}
{если emptyw=true и слов меньше чем  WordI ,вставляем pars[1]}
function RepwordSx(WordI:integer;Str,RepWord,pars:string;emptyword:boolean):string;
function RepwordS(WordI:integer;Str,RepWord:string):string;
{----------------------------------------------------}
{вернуть разделитель после требуемого слова }
function parsWordsx(WordI:integer;Str:string;pars:string;emptyword:boolean):string;
{//////////////////}
Function WordCnt(Str:string):integer;
{то же но с указанием списка разделителей и допустимости пустых слов}
Function WordCntx(Str:string;pars:string;emptyword:boolean):integer;
Function WordCntx_(Str:string;pars:string;RepeatPars:boolean):integer;
{-------------------------------------}
{///////////////////////////////////////////////////////////////////}
{///////////////////}
procedure set_sql(sql:tstrings;text:string);
function  Quotes(s:string):string;
function  DQuotes(s:string):string;
function repdecs(Str:string):string ; {заменить точку или зпаятую на разд}
function del_last_slash(Str:string):string ; {delete last  back \ from string}
{///////////////////}

implementation
uses {winprocs, forms,} SysUtils;



{\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\}
function repdecs(Str:string):string ; {заменить точку или зпятую на разд}
var i:integer;
begin
  for i :=1  to length(str) do
    if (str[i]=',') or(str[i]='.') then str[i]:=DecimalSeparator;
  result:=str;
end;

function DQuotes(s:string):string;
 begin     result:='"'+s+'"' ;
 end;
{////////////////////////////////}
function Quotes(s:string):string;
 begin
    result:=#39+s+#39 ;
 end;
{//////////////////////////}


procedure set_sql(sql:tstrings;text:string);
begin
  sql.clear;
  sql.add(text);
end;
{++++++++++++++++++++++++}
procedure  repstrlst(strlst:tstrings;fndstr,newstr:string); {заменить}
 var i,j,l : integer;  s:string;
 begin
    l:=length(fndstr);fndstr:=upper(fndstr);
    with strlst do
    for i:=0 to strlst.count-1  do begin
       s:=upper(strings[i]);
       j:= pos(fndstr,s);
       if j=0 then  continue;
       system.delete (s,j,l);
       system.insert(newstr,s,j);
       strings[i]:=s;
    end;
 end;
{///////////////}


Function DostoWin(Str:string):string;
var i:word;
begin
    for i:=1 to length(str) do
     case ord(str[i]) of
       $80..$9f,$a0..$af: str[i]:=chr(ord(str[i])+$40);
       $e0..$ef         :str[i]:=chr(ord(str[i])+$10);
     end;
     result:=str;
 end;


Function WintoDos(Str:string):string;
var i:word;
begin
    for i:=1 to length(str) do
     case ord(str[i]) of
       $c0..$df,$e0..$ef: str[i]:=chr(ord(str[i])-$40);
       $f0..$ff         :str[i]:=chr(ord(str[i])-$10);
     end;
     result:=str;
 end;


 {=========================redstr===========================}
 function  redstr (s:string;l:integer):string;
 var             {add space result string length l}
    i,nj,np:integer;
    red:string;
        f : boolean;
    begin
        red:=s;
        nj:=0;  np:=0;
       for  i:= 1 to length(red) do begin
          if (red[i]>#20) and (nj=0)  then nj:=i;
          if (red[i]=' ')   then np:=i;
           end;
     f:=False;
     while (length(red)<l) and (np <>0) and (np <(length(red)-3)) Do
        for i:=nj to length(red)  do
         begin
            if f then continue;
            if (length(red)<l) and(red[i-1]=' ')  then
            begin
                insert(' ',red,i);
                if i< length(red)  then   {i:=i+1}
                   f:=True;
            end;
         end;
      redstr:=red;
    end;
 {=========================SETLEN===========================}
 function  setlen (s:string;l:integer):string;
 var
    i:integer;
    begin
     i:=length(s); if i= l then exit;
{$IFDEF WIN32}
     setlength(s,L);
{$ELSE}
    s[0]:=char(l);
{$ENDIF WIN32}
     for i:=i+1 to l do
        s[i]:= ' ';
     setlen:=s;
    end;
{***********************************************}

 Function Squeeze(L:Char; Str:string;Width:integer): string;
 {}
 const more:string[1] = #26;
 var temp : string;
 begin
     If Width = 0 then
     begin
         Squeeze := '';
         exit;
     end;
     Fillchar(Temp[1],Width,' ');
     temp:=SetLen (Temp,width);
     If Length(Str) < Width then
        Move(Str[1],Temp[1],length(Str))
     else
     begin
         If upcase(L) = 'L' then
         begin
             Move(Str[1],Temp[1],pred(width));
             Move(More[1],Temp[Width],1);
         end
         else
         begin
             Move(More[1],Temp[1],1);
             Move(Str[length(Str)-width+2],Temp[2],pred(width));
         end;
     end;
     Squeeze := Temp;
 end; {of func Squeeze}

 Function First_Capital_Pos(Str : string): integer;
 {}
 var StrPos : integer;
 begin
     StrPos := 1;
     While (StrPos <= length(Str))  and ((Str[StrPos] in ['A'..'Z']) = false) do
            StrPos := Succ(StrPos);
     If StrPos > length(Str) then
        First_Capital_Pos  := 0
     else
        First_Capital_Pos := StrPos;
 end; {of func First_Capital_Pos}

 Function First_capital(Str : string): char;
 {}
 var B : integer;
 begin
     B := First_Capital_Pos(Str);
     If B > 0 then
        First_Capital := Str[B]
     else
        First_Capital := #0;
 end; {of func First_capital}
Function PadRight(Str:string;Size:integer;Pad:char):string;
begin
     if size<= length(str)  then begin
       result:=last(size,str);
     exit;
     end;
{$IFDEF WIN32}
    result:=FillStr(size,pad);
    result:=overtype(size-length(str)+1,str,result);
{$ELSE}
    result:=setlen(str,size);
{$ENDIF WIN32}
end;

Function PadLeft(Str:string;Size:integer;Pad:char):string;
begin
     if size<= length(str)  then begin
       result:=first(size,str);
     exit;
     end;
{$IFDEF WIN32}
    result:=FillStr(size,pad);
{$ELSE}
    result:=setlen(' ',size);
{$ENDIF WIN32}
    result:=overtype(1,str,result);
end;

Function PadCenter(Str:string;Size:integer;Pad:char):string;
 begin
     if size<= length(str)  then begin
       result:=first(size,str);
     exit;
     end;
{$IFDEF WIN32}
    result:=FillStr(size,pad);
{$ELSE}
    result:=setlen(' ',size);
{$ENDIF WIN32}
    result:=overtype((size-length(str)) div 2 +1 ,str,result);
end; {center}


Function Last(N:integer;Str:string):string;
var Temp : string;
begin
    If N > length(Str) then
       Temp := Str
    else
       Temp := copy(Str,length(Str) - N+1,N);
    Last := Temp;
end;  {Func Last}

Function First(N:integer;Str:string):string;
var Temp : string;
begin
    If N > length(Str) then
       Temp := Str
    else
       Temp := copy(Str,1,N);
    First := Temp;
end;  {Func First}
Function Upperc(c:char):char;
begin
        If ord(c) in [97..122,224..255] then
           c := chr(ord(c) - 32);
    Upperc := c;
end;  {Func Upper}

Function Upper(Str:string):string;
var
  I : integer;
begin
    For I := 1 to length(Str) do
        If ord(Str[I]) in [97..122,224..255] then
           Str[I] := chr(ord(Str[I]) - 32);
    Upper := Str;
end;  {Func Upper}

Function Lower(Str:string):string;
var
  I : integer;
begin
    For I := 1 to length(Str) do
        If ord(Str[I]) in [65..90,192..223] then
           Str[I] := chr(ord(Str[I]) + 32);
    Lower := Str;
end;  {Func Lower}

Function Proper(Str:string):string;
var
  I : integer;
  SpaceBefore: boolean;
begin
    SpaceBefore := true;
    Str := lower(Str);
    For I := 1 to length(Str) do
        If SpaceBefore and (ord(Str[I]) in [97..122,224..255]) then
        begin
            SpaceBefore := False;
            Str[I] := Upperc(Str[I]);
        end
        else
            If (SpaceBefore = False) and (Str[I] = ' ') then
                SpaceBefore := true;
    Proper := Str;
end;
{$IFDEF WIN32}
function FillStr(l:integer;pad:char):string ;
var i:integer;
begin
  setlength(result,l);
  for i := 1 to l do
    result[i]:=pad;
end;
{$ENDIF WIN32}


Function OverType(N:integer;StrS,StrT:string):string;
{Overlays StrS onto StrT at Pos N}
var
  i:integer;
begin
    result:=strt;
    for i:=n to n+length(strS)-1 do begin
       if i>length(strt) then exit;
       result[i]:=strs[i-n+1];
    end;
end;  {Func OverType}
{//////////////////////////}
Function Strip(L:char;C:string;Str:string):string;
{L is left,center,right,all,ends}
var Ii :  integer;
begin
   if length(str)<>0 then
    Case Upcase(L) of
    'L' : begin       {Left}
              While (length(Str) > 0)  and  (pos(Str[1],C)<>0) and (length(Str) > 0) do
                    Delete(Str,1,1);
          end;
    'R' : begin       {Right}
              While ((length(Str) > 0)  and ( pos(Str[length(Str)],C)<>0)) do
                    Delete(Str,length(Str),1);
          end;
    'B' : begin       {Both left and right}
              While (length(Str) > 0)  and    (pos(Str[1],C)<>0) do
                    Delete(Str,1,1);
              While (length(Str) > 0)  and  (pos(Str[length(Str)],C)<>0)  do
                    Delete(Str,length(Str),1);
             {удаляем лишние символы}
              II := 1;
              Repeat
                   If (length(Str) > 0)  and  (pos(Str[Ii],C)<>0)
                    and (ii<length(Str))and (pos(Str[Ii+1],C)<>0)
                    then
                      Delete(Str,Ii,1)
                   else
                      Ii := succ(Ii);
              Until (Ii > length(Str)) or (Str = '');
          end;
    'A' : begin       {All}
              II := 1;
              Repeat
                   If (length(Str) > 0)  and  (pos(Str[Ii],C)<>0) then
                      Delete(Str,Ii,1)
                   else
                      Ii := succ(Ii);
              Until (Ii > length(Str)) or (Str = '');
          end;
    end;
    Strip := Str;
end;  {Func Strip}

Function LastPos(C:Char;Str:string):integer;
Var I : integer;
begin
    I := succ(Length(Str));
    Repeat
         I := Pred(I);
    Until (I = 0) or (Str[I] = C);
    LastPos := I;
end;  {Func LastPos}



Function Int_to_Str(Number:longint):string;
var Temp : string;
begin
    Str(Number,temp);
    Int_to_Str := temp;
end;

Function Str_to_float(Str:string):extended;
var
  i {,code} : integer;
begin
    result:=0;
    if length(str)=0 then exit;
    Str:=Strip('A',' ',Str);
    for i:=1 to length(str) do
     begin
       if not (ord(str[i]) in numsym )  then exit;
       if (str[i]=',') or(str[i]='.') then str[i]:=DecimalSeparator;
     end;
          Result := StrToFloat(Str);
end;

function float_to_str(Number:extended;Decimals:integer):string;
var Temp : string;i:integer;
begin
    temp:='0.';
    for i:=1 to decimals do
        temp:=temp+'0';
        temp:=FormatFloat(temp,number);
    {    Str(Number:20:Decimals,Temp);}
    repeat
         If copy(Temp,1,1) = ' ' then delete(Temp,1,1);
    until copy(temp,1,1) <> ' ';
    If Decimals = Floating then
    begin
       Temp := Strip('R','0',Temp);
       If Temp[Length(temp)] = DecimalSeparator then
          Delete(temp,Length(temp),1);
    end;
    float_to_Str := Temp;
end;

Function  Str_to_Int(Str:string):integer;
var temp,i : Integer;
begin
    If length(Str) = 0 then
       Str_to_Int := 0
    else
    begin
       Str:=Strip('A',' ',Str);
       for i:=1 to length(str) do
          if not (str[i] in ['0'..'9','+','-']) then begin
            delete (str,i,length(str));
            break;
          end;
       val(Str,temp,i);
{       if code = 0 then}
          Str_to_Int := temp
{       else}
{          Str_to_Int := 0;}
    end;
end;

Function Str_to_Long(Str:string):Longint;
var
  code : Integer;
  Temp : longint;
begin
    If length(Str) = 0 then
       Str_to_Long := 0
    else
    begin
       Str:=Strip('A',' ',Str);
       val(Str,temp,code);
       if code = 0 then
          Str_to_Long := temp
       else
          Str_to_Long := 0;
    end;
end;

Function float_to_SciStr(Number:extended; D:integer):string;
{Credits: Michael Harris, Houston. Thanks!}
Const
    DamnNearUnity = 9.99999999E-01;
Var
    Temp : real;
    Power: integer;
    Value: string;
    Sign : char;
begin
    If Number = 1.0 then
       float_to_SciStr := '1.000'
    else
    begin
        Temp := Number;
        Power := 0;
        If Number > 1.0 then
        begin
           While Temp >= 10.0 do
           begin
               Inc(Power);
               Temp := Temp/10.0;
           end;
           Sign := '+';
        end
        else
        begin
            While Temp < DamnNearUnity do
            begin
                Inc(Power);
                Temp := Temp * 10.0;
            end;
            Sign := '-';
        end;
        Value := float_To_Str(Temp,D);
        float_to_SciStr := Value+' E'+Sign+Padright(Int_to_Str(Power),2,'0');
    end;
end; {func Real_to_SciStr}
{////////////////////////////}
{///////////////////////////////////}
    function StrCmpI(str1,str2:string):shortint;
   {сравнение двух строк на равно/   не равно}
   {IgnoreCase ,IgnoreSpace  и всех знаков < 32h}
   const reg_mask=$DF;{маска для очистки бита различия регистров}
    ignore_sym=',."'' ';
   var l1,l2,i1,i2,res:integer;
   label m1,m2;
   begin
       result:=0;
       l1:=length(str1);
       l2:=length(str2);
         if ((l1=0)or(l2=0))and (l1<>l2)then
         begin
          if l2=0  then  result:=1
           else result:=-1;
            exit;
         end;
         i1:=1;i2:=1;
         While ( i1<=l1 ) or (i2<=l2) Do Begin
          m1:
          If ( i1<l1 )and (pos(str1[i1],ignore_sym)>0) Then Begin
            inc (i1); goto m1;
          End;
          m2:
          If ( i2<l2 )and (pos(str2[i2],ignore_sym)>0) Then Begin
            inc (i2); goto m2;
          End;
         If ( i1<=l1 ) and (i2<=l2) Then Begin
            res:= (byte(str1[i1])and reg_mask)- (byte(str2[i2]) and reg_mask);
            if res<>0 then  Begin
               If ( res<0 ) Then  result:=-1
                else result:=1;
               exit;
            End;
          If ( i1<=l1 )then inc(i1);
          If ( i2<=l2 )then inc(i2);
         End
         else
         Begin
           If ( i1>l1 ) and (i2>l2) Then   exit;{s1=s2}
           If ( i1<=l1 )  Then  result:=1
           else result:=-1;
           exit;
         End;
      End;
   end;
{----------------------------------------------------}
{тоже но сравнивается первая строка(короткая) и начало 2(длинной)}
 function StrCmpIf(str1,str2:string):boolean;
begin
 result:=StrCmpI(str1,first(length(str1),str2))=0;
end;
{----------------------------------}



{ добавляет в TStrings строку S в отсортированном порядке}
{ Возращает индекс(0 base) в списке добавленной строки,}
{           либо -1 в случае ошибки(пустая строка)}
function SortAddStr(const s:string;Items:TStrings):integer;
var i:integer;
begin
  Result:=-1;
  if s<>''
    then begin
      if s[1] in ['0'..'9']
        then begin
          for i:=0 to Items.Count-1 do
            if StrCmpi(s,Items[i])<0
              then begin
                Result:=i;
                break
              end;
        end
        else begin
          for i:=0 to Items.Count-1 do
            if s<Items[i]
              then begin
                Result:=i;
                break
              end;
        end;
      if Result=-1
        then begin
          Result:=Items.Count;
          Items.Insert(Result,s)
        end
        else begin
          Items.Insert(Result,s);
{                 Result:=Items.IndexOf(s)}
        end
    end
end;
Function RepChar (srcChar,RepChar:char;s:string):string;
 {заменить в строке srcChar на RepChar}
 var i:integer;
begin
   result:=s;
   for i :=1  to length(s) do
     if s[i]=srcChar then s[i]:=RepChar;
   result:=s;
end;
{////////////// ////////////////////////////////}
{извлечь подстроку фикс длины из строки не разрывая слово-по пробелу )}
{использовать для переформатирования  memo}
Function ExtractLineFix(StartLine,LenLine:integer;Str:string):string;
var i,j,bp,numw:integer;ss:string;
begin
  numw:=0;
  bp:=1;
  result:='';
  ss:=copy(str,bp,lenline+1);
  while length(ss)=lenline+1 do
  begin
     inc (numw);
     i:=LastPos(' ',ss);
     j:=LastPos('.',ss);
     if (j>0) and (j<i) {and ((i=0) or (i>lenline))} then
        i:=j;
     if (i=lenline+1) then begin
      { str=lenline-1}
      bp:=bp+lenline+1;
      if numw=startline then begin
       result:=copy(ss,1,lenline);
       exit;
      end;
     end
     else  if (i=0) then begin
     { str=lenline}
      bp:=bp+lenline;
      if numw=startline then begin
       result:=copy(ss,1,lenline);
       exit;
      end;
     end
     else begin
     { str=i-1}
      bp:=bp+i;
      if numw=startline then begin
       result:=copy(ss,1,i-1);
       exit;
      end;
     end;
     ss:=copy(str,bp,lenline+1);
  end;
  if ss<>'' then inc(numw);
  if numw=startline then result:=ss;
end;
{-------------------------------------}
{счетчик подстрок фикс длины из строки не разрывая слово-по пробелу )}
{использовать для переформатирования  memo}
Function LineCntFix(Str:string;LenLine:integer):integer;
{-------------------------------------}
var i,bp:integer;ss:string;
begin
  bp:=1;
  result:=0;
  ss:=copy(str,bp,lenline+1);
  while length(ss)=lenline+1 do
  begin
     inc (result);
     i:=LastPos(' ',ss);
     if (i=lenline+1) then begin
      { str=lenline-1}
      bp:=bp+lenline+1;
     end
     else  if (i=0) then begin
     { str=lenline-1}
      bp:=bp+lenline;
     end
     else begin
     { str=i1}
      bp:=bp+i;
     end;
     ss:=copy(str,bp,lenline+1);
  end;
  if ss<>'' then inc(result);
end;
{==========================================================}
{//////////////}
{извлечь слово из списка с парными ограничителями  ()}
Function ExtractWordParent(WordI:integer;Str:string;parent:string):string;
var i,bp,numw:integer;
begin
  result:='';
  if length(parent)<2 then exit;
  bp:=0;
  numw:=0;
  for i:= 1 to length(str) do
  begin
     if  str[i]=parent[2] then begin{ закр скобка}
       if bp>0  then inc(numw);
       if numw=WordI then
       begin
         result:=copy(str,bp+1,i-bp-1);
         exit;
       end;
       bp:=0;
     end ;
     if  str[i]=parent[1] then  bp:=i;{ откр скобка}
  end;
end;
{///////////////}
{позиция слова из списка с парными ограничителями  }
Function PosWordParent(WordI:integer;Str:string;parent:string):integer;
var i,bp,numw:integer;
begin
  result:=0;
  if length(parent)<2 then exit;
  bp:=0;
  numw:=0;
  for i:= 1 to length(str) do
  begin
     if  str[i]=parent[2] then begin{ закр скобка}
       if bp>0  then inc(numw);
       if numw=WordI then
       begin
         result:=bp+1;
         exit;
       end;
       bp:=0;
     end ;
     if  str[i]=parent[1] then bp:=i;{ откр скобка}
  end;
end;

{-------------------------------------}
{счетчик слов в списке с парными ограничителями  ()}
Function WordCntParent(Str:string;parent:string):integer;
{-------------------------------------}
var i,bp:integer;
begin
  result:=0;
  if length(parent)<2 then exit;
  bp:=0;
  for i:= 1 to length(str) do
    begin
     if  str[i]=parent[2] then begin{ закр скобка}
       if bp>0  then inc(result);
       bp:=0;
     end ;
     if  str[i]=parent[1] then bp:=i;{ откр скобка}
  end;
end;
{==================================================}
function DelUnnecessPars(s,pars:string):string ;
{удаляет повторные разделители}
var i:  integer;
  Parsebefore: boolean;
begin
   Parsebefore:=false;
   result:='';
   for i := 1 to length(s)  do
   begin
     if ( pos(s[i], pars)>0) then begin
      if not Parsebefore  then begin
        result:=result+s[i];
        Parsebefore:=true;
      end
     end
     else begin
        Parsebefore:=false;
        result:=result+s[i];
     end;
   end;
end;

{***********************************************}
Function LocWord(StartAT,Wordno:integer;Str:string;pars:string;emptyword:boolean):integer;
{local proc used by PosWord and Extract word}
var
  W{,L}: integer;
  Spacebefore: boolean;
begin
    If (Str = '') or (wordno < 1) or (StartAT > length(Str)) then
    begin
        LocWord := 0;
        exit;
    end;
    SpaceBefore := true;
    if (not emptyword) then     W := 0
    else w:=1;
{    L := length(Str); }
    StartAT := pred(StartAT);
    While (W < Wordno) and (StartAT <= length(Str)) do
    begin
        StartAT := succ(StartAT);
       if (not emptyword) then
         begin
          If SpaceBefore and (Pos(Str[StartAT],pars)=0 ) then
          begin
              W := succ(W);
              SpaceBefore := false;
          end
          else
              If (SpaceBefore = false) and (Pos(Str[StartAT],pars)<>0) then
                  SpaceBefore := true;
         end
         else
         begin
            if (Pos(Str[StartAT],pars)<>0) then
             begin
              W := succ(W);
            end
         end;
    end;
    If W = Wordno then
        if (not emptyword) then   LocWord := StartAT
        else LocWord := StartAT+1
    else
       LocWord := 0;
end;
{***********************************************}
Function PosWord(Wordno:integer;Str:string):integer;
begin
    PosWord := LocWord(1,wordno,Str,' ',false);
end;  {Func Word}
{***********************************************}
Function PosWordx(Wordno:integer;Str:string;pars:string;emptyword:boolean):integer;
begin
     result:=0;
     if wordno<0 then  {с конца}
     begin
       wordno:=wordcntx(str,pars,emptyword)+wordno+1;
       if wordno<=0 then exit;{такого слова нет}
     end;
    PosWordx := LocWord(1,wordno,Str,pars,emptyword);
end;  {Func Word}
{***********************************}
{вернуть разделитель после требуемого слова }
function parsWordsx(WordI:integer;Str:string;pars:string;emptyword:boolean):string;
var i,j,k:integer;
begin
  result:=''; k:=1;
  if wordI<0 then
  begin
    wordI:=wordcntx(str,pars,emptyword)+wordI+1;
    if wordI<=0 then exit;{такого слова нет}
  end;
  i:=LocWord(1,WordI+1,Str,pars,emptyword);
  if i<2 then exit;
  if emptyword then begin
    result:=str[i-1];
    exit;
  end;
  for j := i-1 downto 1 do
  begin
     if pos(str[j],pars)=0 then begin
       k:=j;
       break;
     end;
  end;
   result:=copy(str,k,i-k);
end;
{***********************************************}
Function WordCnt(Str:string):integer;
begin
    result := WordCntx(Str,' ',false);
end;  {Func Word}
{***********************************************}
Function WordCntx(Str:string;pars:string;emptyword:boolean):integer;
var
  W,I: integer;
  SpaceBefore: boolean;
begin
    If Str = '' then
    begin
        result := 0;
        exit;
    end;
    SpaceBefore := true;
    if (not emptyword) then     W := 0
    else w:=1;
    For  I :=  1 to length(Str) do
    begin
       if (emptyword) then
         begin
            If  (Pos(Str[i],pars)>0) then
            begin
                W := succ(W);
            end
         end
       else
        begin
           If SpaceBefore and (Pos(Str[i],pars)=0 ) then
           begin
              W := succ(W);
              SpaceBefore := false;
           end
           else
              If (SpaceBefore = false) and (Pos(Str[i],pars)<>0) then
                  SpaceBefore := true;
        end;
    end;
    result := W;
end;

{***********************************************}
Function ExtractWords(WordI,NoWords:integer;Str:string):string;
begin
    result := ExtractWordsx(WordI,NoWords,Str,' ',false);
end;  {Func Word}
{***********************************************}
Function ExtractWordsx(WordI,NoWords:integer;Str:string;pars:string;emptyword:boolean):string;
var Start, finish : integer;
begin
    result := '';
    If Str = '' then    exit;
    if wordI<0 then
    begin
      wordI:=wordcntx(str,pars,emptyword)+wordI+1;
      if wordI<=0 then exit;{такого слова нет}
    end;
    Start := LocWord(1,WordI,Str,pars,emptyword);
    If Start <> 0 then
       finish := LocWord(Start,succ(NoWords),Str,pars,emptyword)
    else
    begin
        result := '';
        exit;
    end;
    If finish = 0 then {5.02A}
       finish := succ(length(Str));
    Repeat
        finish := pred(finish);
    Until Pos(Str[finish],pars)=0;
    result := copy(Str,Start,succ(finish-Start));
end;  {Func ExtractWords}
{----------------------------------------------------}
{вставить слово,после WordI,if WordI < 0 то отсчет от конца}
{0-в начало строки  -0 за последним словом    }
{если emptyw=true и слов меньше чем  WordI,вставляем pars[1]}
var Start,Npars,LastWord:integer;
function InsWordSx(WordI,NoWords:integer;Str,Newword:string;pars:string;emptyword:boolean):string;
   procedure addpars;  {добавляет нужное число разделителей}
   var i:integer;
   begin
     if Npars<0 then
         for i :=1  to -Npars do
            str:=pars[1]+str
     else
         for i :=1  to Npars do
            str:=str+pars[1];
   end;
begin
  result:=str;
  LastWord:=wordcntx(str,pars,emptyword);
  if wordI<0 then
  begin
    wordI:=LastWord+wordI+1;
    if wordI<=0 then
      if not emptyword  then  exit{такого слова нет}
      else begin  Npars:=WordI;addpars;WordI:=0; end;
  end;
  if LastWord<WordI then
    if not emptyword  then  exit
    else begin  Npars:=WordI-LastWord;addpars;LastWord:=Wordi; end;
    if Wordi=0 then begin
       if lastword=0 then
          result:=newword
       else
          result:=Newword+pars[1]+str;
       exit;
    end;
    if Wordi=lastword then begin
       result:=str+pars[1]+Newword;
       exit;
    end;
    Start := LocWord(1,WordI+1,Str,pars,emptyword);
    insert(newword+pars[1],result,start);
end;
function InsWordS(WordI,NoWords:integer;Str,Newword:string):string;
begin
 result:= InsWordSx(WordI,NoWords,Str,Newword,' ',false);
end;
{***********************************************}
Function DelWords(WordI,NoWords:integer;Str:string):string;
begin
    result := DelWordsx(WordI,NoWords,Str,' ',false);
end;  {Func Word}
{***********************************************}
Function DelWordsx(WordI,NoWords:integer;Str:string;const pars:string;const emptyword:boolean):string;
var Start, finish : integer;
begin
    result := str;
    If Str = '' then exit;
    if wordI<0 then
    begin
      wordI:=wordcntx(str,pars,emptyword)+wordI+1;
      if wordI<=0 then exit;{такого слова нет}
    end;
    Start := LocWord(1,WordI,Str,pars,emptyword);
    If Start <> 0 then
       finish := LocWord(Start,succ(NoWords),Str,pars,emptyword)
    else
    begin
        exit;
    end;
    If finish = 0 then  begin   {last word}
       finish := succ(length(Str));
        if (start>1) and (Pos(Str[start-1],pars)<>0)
          then  dec(start)
    end;
   if not emptyword then
    Repeat
        finish := pred(finish);
    Until Pos(Str[finish],pars)=0;
{    if (start>1) and (Pos(Str[start-1],pars)<>0)
     then  dec(start)
    else if (finish < length(str)) and (Pos(Str[finish+1],pars)<>0)
     then inc(finish);}

 if  not emptyword then inc(finish);
    delete (str,Start,(finish-Start));
    result := Str;
 end;  {Func ExtractWords}

{----------------------------------------------------}
{заменить слово WordI,if WordI < 0 то последнее}
{если emptyw=true и слов меньше чем  WordI ,вставляем pars[1]}
function RepwordSx(WordI:integer;Str,RepWord,pars:string;emptyword:boolean):string;
var LastWord,Npars,Start, finish : integer;
   procedure addpars;  {добавляет нужное число разделителей}
   var i:integer;
   begin
     if Npars<0 then
         for i :=1  to -Npars do
            str:=pars[1]+str
     else
         for i :=1  to Npars do
            str:=str+pars[1];
   end;
begin
  result:=str;
  LastWord:=wordcntx(str,pars,emptyword);
  if wordI<0 then
  begin
    wordI:=LastWord+wordI+1;
    if wordI<=0 then
      if not emptyword  then  exit{такого слова нет}
      else begin  Npars:=WordI;addpars;WordI:=0; end;
  end;
  if LastWord<WordI then
    if not emptyword  then  exit
    else begin  Npars:=WordI-LastWord;addpars; end;
    Start := LocWord(1,WordI,Str,pars,emptyword);
    If Start <> 0 then
       finish := LocWord(Start,2,Str,pars,emptyword)
    else  exit;

    If finish = 0 then  begin   {last word}
       finish := succ(length(Str));
    end
    else
    Repeat
        finish := pred(finish);
    Until Pos(Str[finish],pars)=0;
    delete (str,Start,succ(finish-Start));
    insert(Repword,str,start);
    result := Str;
end;

function RepwordS(WordI:integer;Str,RepWord:string):string;
begin
end;
{----------------------------------------------------}
{\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\}
Function LocWordPars(StartAT,Wordno:integer;Str:string;pars:string;RepeatPars:boolean):locPars;
{local proc used by PosWord and Extract word}
var
  cw,i: integer;
  Parsebefore: boolean;
begin
    LocWordPars.B_w:=0;
    LocWordPars.B_p:=0;
    LocWordPars.E_w :=0;
    LocWordPars.E_p :=0;
    cw:=1;
    If (Str = '') or (wordno < 1) or (StartAT > length(Str)) then
        exit;
    ParseBefore := false;
    for i :=startAt  to length(Str) do
    begin
       if ( pos(str[i],pars)>0) then begin
         if RepeatPars then
         begin
          if ParseBefore   then begin {next pars}
             if (cw=wordno+1)  then
               LocWordPars.E_p :=i
//             else if (cw=wordno)  then
//               LocWordPars.B_e :=i;

          end
          else begin {not ParseBefore } {first pars}
             ParseBefore:= TRUE;
             cw:=cw+1;
             if cw=wordno then begin
               LocWordPars.B_p:=i;
//             LocWordPars.B_e:=i;
             end
             else if cw=wordno+1 then begin
               LocWordPars.E_w:=i-1;
               LocWordPars.E_p:=i;
//              LocWordPars.C_b :=i;
//              LocWordPars.C_e :=i;
             end;
          end
         end
         else begin  {not RepeatPars}
             ParseBefore:= TRUE;
             cw:=cw+1;
             if cw=wordno then begin
               LocWordPars.B_p:=i;
//               LocWordPars.B_e:=i;
             end
             else if cw=wordno+1 then begin
               LocWordPars.E_p :=i;
//               LocWordPars.C_e :=i;
//               LocWordPars.E_w:=i-1;
               exit;
             end;
         end;
       end
       else begin {s[i] not in Pars  }
          if cw>wordno+1 then exit;
          if (cw=wordno)  then  begin
             if parsebefore or (i=1)then
               LocWordPars.B_w:=i;
             LocWordPars.E_w:=i;
          end;
          ParseBefore:=false;
       end;
    end;
end;
{========================================}
Function WordCntx_(Str:string;pars:string;RepeatPars:boolean):integer;
var  cnt,i: integer;   {считаем разделители}
  Parsebefore: boolean;
begin
  Cnt:=1; {мин одно слово}
  Parsebefore:=false;
  for i :=1  to length(str) do
  begin
    if (pos(str[i],pars)>0 )then
     begin
      if RepeatPars then begin
        if  not Parsebefore  then begin
          cnt:=cnt +1;
          Parsebefore:=true;
        end;
      end
      else      cnt:=cnt +1;
     end
     else Parsebefore:=false;
  end;
  wordcntx_:=cnt;
end;
{---------------------------------------------------}
{позиция слова если  wordno<0  то отсчет с конца  }
Function PosWord_(Wordno:integer;Str:string):integer;
begin
   result:=PosWordx_(Wordno,Str,' ',true);
end;
{то же но с указанием списка разделителей и допустимости пустых слов}
Function PosWordx_(Wordno:integer;Str:string;pars:string;RepeatPars:boolean):integer;
var LP:locPars;
begin
  lp:=LocWordPars(1,Wordno,Str,pars,RepeatPars);
  poswordx_:=lp.b_w
end;
{---------------------------------------------------}
{извлечь слово WordI <0  то отсчет с конца }
Function ExtractWords_(WordI,NoWords:integer;Str:string):string;
BEGIN
 ExtractWords_:=ExtractWordsx_(WordI,NoWords,Str,' ',true);
END;
{то же но с указанием списка разделителей и допустимости пустых слов}
Function ExtractWordsx_(WordI,NoWords:integer;Str:string;pars:string;RepeatPars:boolean):string;
var LP1,lp2:locPars;
BEGIN
	ExtractWordsx_:='';
        if wordi<0 then
        begin
          wordi:=wordcntx_(str,pars,repeatpars)+wordi+1;
          if wordi<=0 then exit;
        end;
	IF ( NoWords<1 ) THEN exit;
	lp1:=LocWordPars(1,WordI,Str,pars,RepeatPars);
        if (lp1.b_w=0)and(lp1.b_w<>0 ) then  lp1.b_w:=lp1.b_p+1;
	IF ( NoWords>1) THEN
		lp2:=LocWordPars(1,WordI+NoWords-1,Str,pars,RepeatPars)
	else lp2:=lp1;
        IF ( lp1.b_w >0 ) and (lp2.E_w=0) then
          if (lp2.E_p=0)  then   lp2.E_w:=length(str)
          else lp2.E_w:= lp2.E_p-1;
       if lp1.b_w>0 then
        ExtractWordsx_:=copy(str,lp1.b_w,lp2.e_w-lp1.b_w+1);
END;
function del_last_slash(Str:string):string ; {delete last  back \ from string}
begin
   del_last_slash:=str;
   if (str='') or (str[length(str)]<>'\')  then exit;
   del_last_slash:=copy(str,1,length(str)-1);
end;
function findlist(strlst:tstrings;fndstr:string):integer;
var i:integer; s,ss:string  ;
begin   // find first entry fndstr in any item of strlst
 findlist:=-1;
 ss:=upper(Strip('B',' ', fndstr));
 for i:=0 to strlst.count-1 do begin
    s:=upper(Strip('B',' ', strlst[i]));
    if pos(ss, s)>0 then begin
      findlist:=i;
      exit;
    end;
 end;
end;
{----------------------------------------------------}
{***********************************************}
end.

