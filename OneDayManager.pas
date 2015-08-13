unit OneDayManager;
interface

uses save_Rasr,SaveSTDISP,BaseBefor,save_ost1562;

type   rnBefor=(rnSaveSTDisp,rnSave_Ras,rnSaveOst1562);

type
 TOneDayManagerTime=class
 private
    procedure ExcuteOne(P:rnBefor);
 public
   procedure ExcuteAll;
 end;

 var OneDayManagerTime:TOneDayManagerTime;

implementation


procedure  TOneDayManagerTime.ExcuteOne(P:rnBefor);
var BasePrepared:tBasePrepared_Time;
 begin
  BasePrepared:=nil;
  case P of
     rnSaveSTDisp: BasePrepared:=TSaveSTDisp.Create;
     rnSave_Ras:   BasePrepared:=TSave_Ras.Create;
     rnSaveOst1562:BasePrepared:=TSaveOst1562.Create;

  end;
  try
   if  assigned(BasePrepared) then
   BasePrepared.Excute;
   finally
    if  assigned(BasePrepared) then
    BasePrepared.Free;
   end;
 end;

procedure TOneDayManagerTime.ExcuteAll();
var P:rnBefor;
begin
for P:=rnSaveSTDisp to  rnSaveOst1562 do
  begin
    ExcuteOne(P);
  end
end;

end.
