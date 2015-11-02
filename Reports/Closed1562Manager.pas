unit Closed1562Manager;  //09.01.2013 glasha
{Модуль  в котором должно находится весь код по закрытию заявок 1562 }

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
CanselForm,workSql, NumSOBuffDModule,NumSOForm,ViewSent1562Form,VeiwSent1562DModule,QCanselForm;

type
// systems=(ns,vds);

 TManClosed1562=class
 private
   F_CanselForm:Tfrm_cansel1562;
  // F_Dm:Tdm_NumSOBuff;
   Frm_Closed1562:Tfrm_ViewClosed1562;
   F_DmView:Tdm_Closed1562View;  { полученые данные из базы MSSQL}
   typ:systems;
   F_order:integer;
   F_Table:string;
   F_List_1562:TStringList;
   F_List_tel:TStringList;
   F_List_och:TStringList;
   F_Cansel:boolean;
   f_state_close:integer;//запишем результат AddCanselInfo
   F_excav:boolean; //зарывать заявки с раскопками иначе не закр такие заявки
   F_Id_dep:integer;//id выезда для заявок с раскопками
   F_cap_rem:boolean;
    F_DateOpenOrder:TDateTime;
   F_orderNumber:string;
   function AddCanselInfo():integer;


 protected
 public


 str_1562:string;
 excavCloseInfo:string;
 constructor Create(p:integer;Id_order:integer;str_all:string;OrderNumber:String; DateopenOrder:TDateTime;
  _Excav:boolean=false;id_dep:integer=-1 );
 destructor Destroy(); override;
 function QuestionClosed1562(var mess:string):integer; {0-Ошибка -1-Отменено пользователем 1-Закрыть}
 //function Closed1562(var mess:string):integer; {0-Ошибка -1-Отменено пользователем 1-Закрыть}
 function doClosed1562():integer;
 property Cap_Rem:boolean write F_cap_rem;


 end;

implementation

 constructor TManClosed1562.Create(p:integer;Id_order:integer;str_all:string;OrderNumber:String; DateopenOrder:TDateTime;
  _Excav:boolean=false;id_dep:integer=-1 );
begin

F_order:=ID_order;
case p of
  1: begin
       typ:=ns;
       F_table:='numsorders';
      end;
  2: begin
       typ:=vds;
       F_table:='numsorders_vds';
      end;
end;
F_excav:=_Excav;

F_CanselForm:=Tfrm_cansel1562.Create(nil,F_order,F_table,OrderNumber,DateopenOrder);
Frm_Closed1562:=Tfrm_ViewClosed1562.Create(nil); { табличка в оторой отображается вся информация по заявкам 1562-}
F_DmView:=Tdm_Closed1562View.Create(nil);
F_list_tel:=TStringList.Create;
F_list_Och:=TStringList.Create;
F_List_1562:=TStringList.Create;
F_DmView.Typ:=typ;
F_DmView.CapRem:=F_Cap_rem;
F_Id_dep:=id_dep;
F_DmView.OrderID:=Id_order;
F_DmView.Excav:=F_excav;
str_1562:=F_DmView.getClosed_List;
F_ordernumber:=OrderNumber;
F_DateOpenOrder:=DateopenOrder;
end;



{function TManClosed1562.Closed1562(var mess:string):integer;
var
 _062_list,_062_listview,list_1562:String;
 list_tel:TStringList;
 List_Och:TStringList;
 SList_1562:TStringList;
 t_Cansel,i:integer;
 ls:TStringList;
 modalRes:integer;
 t_Close:integer;
 set_p:integer;
begin
   modalRes:=0;
   list_tel:=TStringList.Create;
    list_Och:=TStringList.Create;
    SList_1562:=TStringList.Create;
   try
    try
    Result:=0;


    if str_1562='' then
    begin
     Result:=1;
     exit;
    end;
    F_DmView.F_typForm:=before_closed;
    Frm_Closed1562.f_typForm:=before_closed;

    if  F_DmView.PrepareData(F_order,typ, F_excav)>0 then
    begin
      if F_excav then
       Frm_Closed1562.mem_closed.Lines.Text:= excavCloseInfo
     else
       Frm_Closed1562.mem_closed.Lines.Text:=F_DmView.CloseInfo;
       modalRes:=Frm_Closed1562.ShowModal;
    end;
    if modalRes=mrCancel then
    begin
     Result:=-1;
     mess:='Отменено пользователем';
     exit;
    end;
    set_p:=F_DmView.SetPhone;
    if set_p=-1 then
    begin
     result:=0;
     exit;
    end;
    if set_p=0 then
    begin
     Result:=-1;
     mess:='Нужно обзвонить ВСЕХ абонентов!! Наряд не закрыт!';
     exit;
    end;
    F_DmView.List_1562:=SList_1562;
    F_DmView.List_tel:=list_tel;
    F_DmView.List_Och:=list_och;
    F_DmView.DoSent;
    if (Slist_1562.Count>0) or
        (list_tel.Count>0) or
        (list_och.Count>0)
    then
    begin
     t_Close:=AddCanselInfo();
     case t_Close of
      -2:begin
          REsult:=-1;
          exit;
         end;
      -1:begin
          REsult:=0;
           exit;
         end;
       0:begin
           f_DmView.SetClose(_1562);
           f_DmView.SetClose(tel);
           f_DmView.SetClose(Och);
           Result:=1;
         end;
       1:  if Assigned(F_CanselForm.main_dset) then
           begin
              F_CanselForm.ID1562:=SList_1562;
              F_CanselForm.SaveDate(Import_Denied);
              F_CanselForm.ID1562:=List_och;
              F_CanselForm.SaveDate(Import_Denied);
              f_DmView.SetClose(tel);
           end;
        2: begin
             F_CanselForm.ID1562:=SList_1562;
             F_CanselForm.SaveDate(Import_Denied);
             F_CanselForm.ID1562:=List_och;
             F_CanselForm.SaveDate(RallBack1562);
             F_CanselForm.ID1562:=List_tel;
             F_CanselForm.SaveDate(TelRequestInOch);
           end;

     end;


    end;
    f_DmView.CommitAll;
    Result:=1;
    except on e:exception do
    begin
      e.Message:='Ошибка при закрытии заявок! '+#13+e.Message;
      Result:=0;
      if f_DmView.IBTran.InTransaction then
         f_DmView.IBTran.Rollback;
      //Raise e;
    end;
    end;
   finally
    SList_1562.Free;
    List_tel.Free;
    list_och.Free;

   end;


end; }

function  TManClosed1562.AddCanselInfo():integer;   //30.05.2012 Glasha
var _062_list, _062_list_tel:TstringList;
  frm_QCansel:Tfrm_QCansel;
  Modal:integer;
  m:integer;
begin
//возращ -1-ошибка 0 -закр без отказа 1- закрывем отказом 2-перенаправляем на очиствод   -2 отменено пользователем
Result:=-1;
 F_Cansel:=false;
 {if not F_NumSOBuff.IsDataLoad then
    begin
      F_NumSOBuff.OrderID := F_OrderID;
      F_NumSOBuff.LoadData;
    end;}
frm_QCansel:=Tfrm_QCansel.Create(nil);
try
  Result:=-1;

  frm_QCansel.PreaPare('','Закрыть отказом?','да','нет');
  m:=frm_QCansel.ShowModal;
  if m=mrCancel  then
  begin
   Result:=-2;
   exit;
  end;
  if m=mrno then
  begin
   Result:=0;
   F_Cansel:=false;
  end
  else
  begin
    frm_QCansel.PreaPare('','Направление отказа?','очиствод','не очиствод');
    case  frm_QCansel.ShowModal of
      mryes: begin
              F_Cansel:=true;
              Result:=2;
             end;
      mrNo: begin
             F_Cansel:=true;
             Result:=1;
            end;
    mrCancel:  begin
                 F_Cansel:=false;
                 Result:=-2;
                 exit;
              end;
    end;


    F_CanselForm.Enabled:=true;
    Modal:=F_CanselForm.ShowModal;
    if (Modal<>mrOK) and (Modal<>mrCancel) then
         begin
          Result:=-2;
         end;
    if Modal=mrCancel then
         begin
           F_Cansel:=false;
           Result:=0;
         end ;

  end;
 frm_QCansel.Free;
except on e:exception  do
begin
if assigned (frm_QCansel) then
 frm_QCansel.Free;
raise  e

end;
end;


end;

function TManClosed1562.QuestionClosed1562(var mess:string):integer;
var
 _062_list,_062_listview,list_1562:String;
 t_Cansel,i:integer;
 ls:TStringList;
 modalRes:integer;
 t_Close:integer;
 set_p:integer;
begin
   modalRes:=0;
   Result:=0;
   try
    try
    Result:=0;


    if str_1562='' then
    begin
     Result:=1;
     F_state_close:=-3;
     exit;
    end;
    F_DmView.F_typForm:=before_closed;
    Frm_Closed1562.f_typForm:=before_closed;
    F_DmView.CapRem := F_Cap_Rem;
    if  F_DmView.PrepareData(F_order,typ,F_Excav)>0 then
    begin
       if (F_excav) or (f_cap_rem) then
        Frm_Closed1562.mem_closed.Lines.Text:=excavCloseInfo
       else
        Frm_Closed1562.mem_closed.Lines.Text:=F_DmView.CloseInfo;
       modalRes:=Frm_Closed1562.ShowModal;
    end
    else
     F_state_close:=-3;//нет заявок
    if modalRes=mrCancel then
    begin
     Result:=-1;
     mess:='Отменено пользователем';
     exit;
    end;
    set_p:=F_DmView.SetPhone;
    if set_p=-1 then
    begin
     result:=0;
     exit;
    end;
    if (set_p=0) and( not f_Excav)  then
    begin
     Result:=-1;
     mess:='Нужно обзвонить ВСЕХ абонентов!! Наряд не закрыт!';
     exit;
    end;
    F_DmView.List_1562:=F_List_1562;
    F_DmView.List_tel:=F_list_tel;
    F_DmView.List_Och:=F_list_och;
    F_DmView.DoSent;           //  заполняем F_List_1562; F_list_tel; F_list_och;
    if (F_list_1562.Count>0) or
        (F_list_tel.Count>0) or
        (F_list_och.Count>0)
    then
    begin
     if not (F_Excav or F_cap_rem)  then {заявк с разрытиями в кап ремонт можно только закрыть}
      F_state_close:=AddCanselInfo()
     else
      F_state_close:=0;
      if F_state_close=-2 then
      begin
       Result:=-1;
       mess:='Отменено пользователем';
       exit;
      end
    end
    else
     f_state_close:=-3;// нет заявок
    Result:=1; 
    except
    end;
    except
    end;
end;

function TManClosed1562.doClosed1562():integer;
begin
try
  try
    case F_state_Close of

     -3, -2:begin
          REsult:=-1;
          exit;
         end;
      -1:begin
          REsult:=0;
           exit;
         end;
       0:begin
           f_DmView.SetClose(_1562,F_ID_Dep);
           f_DmView.SetClose(tel, F_ID_Dep);
           f_DmView.SetClose(Och, F_ID_Dep);
           Result:=1;
         end;
       1:  if Assigned(F_CanselForm.main_dset) then
           begin
              F_CanselForm.ID1562:=F_List_1562;
              F_CanselForm.SaveDate(Import_Denied);
              F_CanselForm.ID1562:=F_List_och;
              F_CanselForm.SaveDate(Import_Denied);
              f_DmView.SetClose(tel);
           end;
        2: begin
             F_CanselForm.ID1562:=F_List_1562;
             F_CanselForm.SaveDate(Import_Denied);
             F_CanselForm.ID1562:=F_List_och;
             F_CanselForm.SaveDate(RallBack1562);
             F_CanselForm.ID1562:=F_List_tel;
             F_CanselForm.SaveDate(TelRequestInOch);
           end;

     end;
     f_DmView.CommitAll;
     Result:=1;
  except on e:exception do
    begin
      e.Message:='Ошибка при закрытии заявок! '+#13+e.Message;
      Result:=0;
      if f_DmView.IBTran.InTransaction then
         f_DmView.IBTran.Rollback;
      Raise e;
    end;
  end;
finally

end;


end;

destructor TManClosed1562.Destroy;
begin
F_list_tel.Free;
F_list_Och.Free;
F_List_1562.Free;
F_CanselForm.Free;
Frm_Closed1562.Free;
F_DmView.Free;
  //F_Dm:=nil;
  inherited Destroy;
end;



end.
