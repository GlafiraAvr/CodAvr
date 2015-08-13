unit MNKUnit;

interface

uses Math,ApUnit,Classes;

{

y = a + bx 

}

type

  TXY=class
    x,y:double;
  end;

  TMNK=class
    private
      FXYList:TList;
      FOutX1,FOutY1,FOutX2,FOutY2:double;
      FXArr,FYArr:TReal1DArray;
      procedure BuildLinearLeastSquares(const X : TReal1DArray;
         const Y : TReal1DArray;  N : Integer; var a : Double; var b : Double);
    protected
    public
      constructor Create;
      destructor Destroy; override;
      //
      procedure Execute;
      //
      procedure Clear;
      procedure AddXY(_x,_y:double);
      property OutX1:double read FOutX1;
      property OutY1:double read FOutY1;
      property OutX2:double read FOutX2;
      property OutY2:double read FOutY2;
  end;

implementation

procedure TMNK.Execute;
var k,i:integer;
  a,b:double;
begin
  k:=FXYList.Count;
  SetLength(FXArr,k);
  SetLength(FYArr,k);
  try
    for i:=0 to k-1 do
      begin
        FXArr[i]:=TXY(FXYList.Items[i]).x;
        FYArr[i]:=TXY(FXYList.Items[i]).y;
      end;
    BuildLinearLeastSquares(FXArr,FYArr,k,a,b); //y=b*x+a;
    FOutX1:=FXArr[0];
    FOutX2:=FXArr[k-1];
    FOutY1:=b*OutX1+a;
    FOutY2:=b*OutX2+a;
  finally
    Finalize(FYArr);
    Finalize(FXArr);
  end;
end;

constructor TMNK.Create;
begin
  FXYList:=TList.Create;
end;

destructor TMNK.Destroy;
begin
  Clear;
  FXYList.Free;
  inherited;
end;

procedure TMNK.Clear;
begin
  FXYList.Clear;
end;

procedure TMNK.AddXY(_x,_y:double);
var _txy:TXY;
begin
  _txy:=TXY.Create;
  _txy.x:=_x;
  _txy.y:=_y;
  FXYList.Add(_txy);
end;

(*************************************************************************
Аппроксимация прямой по МНК

Подпрограмма  вычисляет  коэффициенты  прямой,  аппроксимирующей   по  МНК
указанную функцию.

Входные параметры:
    X   -   массив  вещественных  чисел с нумерацией элементов от 0 до N-1.
            Содержит набор абсцисс, в которых известны значения функции.
    Y   -   массив  вещественных  чисел с нумерацией элементов от 0 до N-1.
            Содержит набор значений функции.
    N   -   число точек.
            N>=1

Выходные параметры:
    a,b -   коэффициенты аппроксимирующей прямой a+b*t
*************************************************************************)

procedure TMNK.BuildLinearLeastSquares(const X : TReal1DArray;
     const Y : TReal1DArray;
     N : Integer;
     var a : Double;
     var b : Double);
var
    PP : Double;
    QQ : Double;
    PQ : Double;
    b1 : Double;
    b2 : Double;
    d1 : Double;
    d2 : Double;
    t1 : Double;
    t2 : Double;
    Phi : Double;
    c : Double;
    s : Double;
    m : Double;
    I : Integer;
begin
    PP := N;
    QQ := 0;
    PQ := 0;
    b1 := 0;
    b2 := 0;
    I:=0;
    while I<=N-1 do
    begin
        PQ := PQ+X[I];
        QQ := QQ+Sqr(X[I]);
        b1 := B1+Y[I];
        b2 := B2+X[I]*Y[I];
        Inc(I);
    end;
    Phi := ArcTan2(2*PQ, QQ-PP)/2;
    c := Cos(Phi);
    s := Sin(Phi);
    d1 := Sqr(c)*pp+Sqr(s)*qq-2*s*c*pq;
    d2 := Sqr(s)*pp+Sqr(c)*qq+2*s*c*pq;
    if AbsReal(d1)>AbsReal(d2) then
    begin
        m := AbsReal(d1);
    end
    else
    begin
        m := AbsReal(d2);
    end;
    t1 := c*b1-s*b2;
    t2 := s*b1+c*b2;
    if AbsReal(d1)>m*MachineEpsilon*1000 then
    begin
        t1 := t1/d1;
    end
    else
    begin
        t1 := 0;
    end;
    if AbsReal(d2)>m*MachineEpsilon*1000 then
    begin
        t2 := t2/d2;
    end
    else
    begin
        t2 := 0;
    end;
    a := c*t1+s*t2;
    b := -s*t1+c*t2;
end;


end.
