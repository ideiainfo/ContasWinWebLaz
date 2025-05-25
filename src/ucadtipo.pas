unit ucadtipo;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,
  D2Bridge.Forms, D2BridgeFormTemplate;

type

  { TFormCadTipo }

  TFormCadTipo = class(TD2BridgeForm)
    btnCancelar: TButton;
    btnGravar: TButton;
    DBCTipo: TDBComboBox;
    DBECodigo: TDBEdit;
    DBEDescricao: TDBEdit;
    DBLGrupo: TDBLookupComboBox;
    lblCodigo: TLabel;
    lblDescicao: TLabel;
    lblGrupo: TLabel;
    lblTipo: TLabel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    procedure ExportD2Bridge; override;
    procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
    procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;

  public

  end;



Function FormCadTipo: TFormCadTipo;

implementation

uses ucontipo;

{$R *.lfm}

{ TFormCadTipo }

Function FormCadTipo: TFormCadTipo;
begin
   Result:= (TFormCadTipo.GetInstance as TFormCadTipo);
end;

procedure TFormCadTipo.ExportD2Bridge;
begin
  inherited;

  Title:= '';
  SubTitle:= '';

TemplateClassForm:= TD2BridgeFormTemplate;
D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= '';
D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

  //Export yours Controls
  with D2Bridge.Items.add do
  begin
    with row.Items.Add do
         with FormGroup(lblcodigo.Caption) do
           AddVCLObj(DBECodigo);

     with row.Items.Add do
         with FormGroup(lblDescicao.Caption,CSSClass.Col.colsize12) do
           AddVCLObj(DBEDescricao);

     with row.Items.Add do
       begin
         with FormGroup(lblgrupo.Caption,CSSClass.Col.colsize6) do
           AddVCLObj(DBLGrupo);
         with FormGroup(lbltipo.Caption, CSSClass.Col.colsize6) do
           AddVCLObj(DBCTipo);
       end;

     with row.Items.Add do
      begin
        with HTMLDIV(CSSClass.DivHtml.Align_Right+ ' mt-5 mb-4' ).Items.Add do
         begin
           with FormGroup do
             AddVCLObj(btnGravar,CSSClass.Button.save);

           with FormGroup do
             AddVCLObj(btnCancelar, CSSClass.Button.cancel);
        end;
      end;
  end;
end;

procedure TFormCadTipo.InitControlsD2Bridge(const PrismControl: TPrismControl);
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

procedure TFormCadTipo.RenderD2Bridge(const PrismControl: TPrismControl;
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


procedure TFormCadTipo.btnCancelarClick(Sender: TObject);
begin
  close;
end;

procedure TFormCadTipo.btnGravarClick(Sender: TObject);
begin
  FormConTipo.qrTipo.post;
  close;
end;

end.

