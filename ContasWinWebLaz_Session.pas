unit ContasWinWebLaz_Session;

interface

uses
  SysUtils, Classes,
  Prism.SessionBase, udm;

type
  TContasWinWebLazSession = class(TPrismSessionBase)
  private

  public
   constructor Create(APrismSession: TPrismSession); override;  //OnNewSession
   destructor Destroy; override; //OnCloseSession
  end;


implementation

Uses
  D2Bridge.Instance,
  ContasWinWebLazWebApp;

{$IFNDEF FPC}
{$R *.dfm}
{$ELSE}
{$R *.lfm}
{$ENDIF} 

constructor TContasWinWebLazSession.Create(APrismSession: TPrismSession); //OnNewSession
begin
 inherited;
  if DM = nil then
    TDM.createinstance
 //Your code

end;

destructor TContasWinWebLazSession.Destroy; //OnCloseSession
begin
 //Close ALL DataBase connection
 //Ex: Dm.DBConnection.Close;

 inherited;
end;

end.

