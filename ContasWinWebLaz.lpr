program D2BridgeWebAppWithLCL;

{$mode delphi}{$H+}

{$IFDEF D2BRIDGE}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  {$IFDEF UNIX}
  cthreads, clocale,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,   
	D2Bridge.Instance,
  D2Bridge.ServerControllerBase,
  Prism.SessionBase,
  D2BridgeFormTemplate,	
  ContasWinWebLaz_Session,
  ContasWinWebLazWebApp,
  Unit_Login in 'Unit_Login.pas' {Form_Login},
Unit_D2Bridge_Server_Console in 'Unit_D2Bridge_Server_Console.pas', zcomponent,

  
  ucadtipo, ucontipo, udm, uFormPrincipal
  { you can add units after this };

{$R *.res}

{$IFNDEF D2BRIDGE}
var
  Unit_Login: TForm_Login;
{$ENDIF}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  {$IFNDEF D2BRIDGE}
  Application.CreateForm(TForm_Login, Unit_Login);
  D2BridgeInstance.AddInstace(Unit_Login);
  Application.Run;
  {$ELSE}	
  TD2BridgeServerConsole.Run
  
  {$ENDIF}	
end.

