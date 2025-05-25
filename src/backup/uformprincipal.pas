unit uFormPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Controls, Graphics, Dialogs, Menus, StdCtrls, Forms,
  D2Bridge.Forms;

type

  { TFormPrincipal }

  TFormPrincipal = class(TD2BridgeForm)
    AppModule21: TMenuItem;
    Button1: TButton;
    Label1: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure Module11Click(Sender: TObject);
  private

  protected
    procedure ExportD2Bridge; override;
    procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
    procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;

  public

  end;

function FormPrincipal: TFormPrincipal;

implementation

uses
  uConTipo, D2BridgeFormTemplate;

  {$R *.lfm}

  { TFormPrincipal }

Function FormPrincipal: TFormPrincipal;
begin
   Result:= (TFormPrincipal.GetInstance as TFormPrincipal);
end;

procedure TFormPrincipal.ExportD2Bridge;
begin
  inherited;

  Title:= 'Contas Web Laz';
  SubTitle:= 'Sistema de Controle de Contas a Pagar e Receber';

  TemplateClassForm:= TD2BridgeFormTemplate;
  D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= 'template.html';
  D2Bridge.FrameworkExportType.TemplatePageHTMLFile := 'itemtemplate.html';

  //Export yours Controls
  with D2Bridge.Items.add do
  begin
  // SideMenu(MainMenu1);
   //with MainMenu(MainMenu1) do
   //begin
   // Color:= $00E2445B;
   // Title:= 'Contas a Pagar e Receber';
   // TitleColor:=$009CAA4A ;
   //end;

   LCLObj(Label1);
   LCLObj(Button1);

  end;
end;

procedure TFormPrincipal.InitControlsD2Bridge(const PrismControl: TPrismControl);
begin
  inherited;

  //Menu example
  {
   if PrismControl.VCLComponent = MainMenu1 then
    PrismControl.AsMainMenu.Title:= 'AppTeste'; //or in SideMenu use asSideMenu

   if PrismControl.VCLComponent = MainMenu1 then
    PrismControl.AsMainMenu.Image.URL:= 'https://d2bridge.com.br/images/LogoD2BridgeTransp.png'; //or in SideMenu use asSideMenu

   //GroupIndex example
   if PrismControl.VCLComponent = MainMenu1 then
    with PrismControl.AsMainMenu do  //or in SideMenu use asSideMenu
    begin
     MenuGroups[0].Caption:= 'Principal';
     MenuGroups[1].Caption:= 'Services';
     MenuGroups[2].Caption:= 'Items';
    end;

   //Chance Icon and Propertys MODE 1 *Using MenuItem component
   PrismControl.AsMainMenu.MenuItemFromVCLComponent(Abrout1).Icon:= 'fa-solid fa-rocket';

   //Chance Icon and Propertys MODE 2 *Using MenuItem name
   PrismControl.AsMainMenu.MenuItemFromName('Abrout1').Icon:= 'fa-solid fa-rocket';
  }

  //Change Init Property of Prism Controls
  {
   if PrismControl.VCLComponent = Edit1 then
    PrismControl.AsEdit.DataType:= TPrismFieldType.PrismFieldTypeInteger;

   if PrismControl.IsDBGrid then
   begin
    PrismControl.AsDBGrid.RecordsPerPage:= 10;
    PrismControl.AsDBGrid.MaxRecords:= 2000;
   end;
  }
end;

procedure TFormPrincipal.RenderD2Bridge(const PrismControl: TPrismControl;
  var HTMLControl: string);
begin
  inherited;

  //Intercept HTML
  {
   if PrismControl.VCLComponent = Edit1 then
   begin
    HTMLControl:= '</>';
   end;
  }
end;


procedure TFormPrincipal.Module11Click(Sender: TObject);
begin
  FormPrincipal.Show;
end;

procedure TFormPrincipal.MenuItem2Click(Sender: TObject);
begin
  //if FormGrupo = nil then
  //  TFormGrupo.CreateInstance ;
  //FormGrupo.show;
end;

procedure TFormPrincipal.MenuItem3Click(Sender: TObject);
begin
   FormPrincipal.show;
end;

procedure TFormPrincipal.MenuItem1Click(Sender: TObject);
begin
  if FormConTipo = nil then
    TFormConTipo.CreateInstance;
  FormConTipo.show;

end;



end.
