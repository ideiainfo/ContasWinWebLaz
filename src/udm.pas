unit udm;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ZConnection;

type

  { TDM }

  TDM = class(TDataModule)
    ZConnection1: TZConnection;
  private

  public
      class procedure CreateInstance;
  end;
function DM: TDM;

implementation

uses D2Bridge.Instance, ContasWinWebLazWebApp;
{$R *.lfm}

class procedure TDM.CreateInstance;
begin
  D2BridgeInstance.CreateInstance(self);
end;

function DM: TDM;
begin
  result:= (D2BridgeInstance.GetInstance(TDM) as TDM);
end;

end.

