unit D2BridgeFormTemplate;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

Uses
 Classes, SysUtils,
 D2Bridge.Prism.Form, uFormPrincipal;


type

 { TD2BridgeFormTemplate }

 TD2BridgeFormTemplate = class(TD2BridgePrismForm)
  private
   procedure ProcessHTML(Sender: TObject; var AHTMLText: string);
   procedure ProcessTagHTML(const TagString: string; var ReplaceTag: string);
   procedure CallBack(const CallBackName:string; EventParams: TStrings); override;

   //function OpenMenuPrincipal(EventParams: TStrings): String;
   //function OpenMenuConTipo(EventParams: TStrings): String;
   //function OpenMenuItem(EventParams: TStrings): String;
  public
   constructor Create(AOwner: TComponent; D2BridgePrismFramework: TObject); override;

 end;


implementation

Uses
 ContasWinWebLazWebApp,ucontipo;


{ TD2BridgeFormTemplate }

constructor TD2BridgeFormTemplate.Create(AOwner: TComponent;
  D2BridgePrismFramework: TObject);
begin
 inherited;

 //Events
 OnProcessHTML:= ProcessHTML;
 OnTagHTML:= ProcessTagHTML;

 //CallBacks.Register('MenuPrincipal', OpenMenuPrincipal);
 //CallBacks.Register('MenuConTipo', OpenMenuConTipo);

 //with D2Bridge.Items.add do
 //   SideMenu(Formprincipal.MainMenu1);

 //Yours CallBacks Ex:
 //Session.CallBacks.Register('OpenMenuItem', OpenMenuItem);


 //Other Example CallBack embed
 {
 Session.CallBacks.Register('OpenMenuItem',
   function(EventParams: TStrings): string
   begin
    if MyForm = nil then
     TMyForm.CreateInstance;
    MyForm.Show;
   end);
  }
end;


procedure TD2BridgeFormTemplate.CallBack(const CallBackName: string;   EventParams: TStrings);
begin
  inherited;
 if SameText(CallBackName, 'MenuConTipo') then
 begin
  if FormConTipo = nil then
     TFormConTipo.CreateInstance;
  FormConTipo.Show;
 end;

  if SameText(CallBackName, 'MenuPrincipal') then
 begin
   if FormPrincipal = nil then
     TFormPrincipal.CreateInstance;
   FormPrincipal.Show;
 end;


end;

//function TD2BridgeFormTemplate.OpenMenuPrincipal(EventParams: TStrings): String;
//begin
//   if FormPrincipal = nil then
//     TFormPrincipal.CreateInstance;
//  FormPrincipal.Show;
//end;
//
//function TD2BridgeFormTemplate.OpenMenuConTipo(EventParams: TStrings): String;
//begin
//    if FormConTipo = nil then
//       TFormConTipo.CreateInstance;
//    FormConTipo.Show;
//end;

procedure TD2BridgeFormTemplate.ProcessHTML(Sender: TObject;
  var AHTMLText: string);
begin
 //Intercep HTML Code

end;

procedure TD2BridgeFormTemplate.ProcessTagHTML(const TagString: string;
  var ReplaceTag: string);
begin
 //Process TAGs HTML {{TAGNAME}}
 if TagString = 'UserName' then
 begin
  ReplaceTag := 'Name of User';
 end;

end;

end.
