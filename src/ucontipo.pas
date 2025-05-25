unit ucontipo;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  ZDataset, ZAbstractRODataset, D2BridgeFormTemplate, ucadtipo, D2Bridge.Forms;

type

  { TFormConTipo }

  TFormConTipo = class(TD2BridgeForm)
    BtnEditar: TButton;
    BtnExcluir: TButton;
    BtnLocalizar: TButton;
    BtnNovo: TButton;
    btnFechar: TButton;
    DBGrid1: TDBGrid;
    desgrupo: TStringField;
    dsGrupo: TDataSource;
    dsTipo: TDataSource;
    EditLocalizar: TEdit;
    lblLocalizar: TLabel;
    qrGrupo: TZQuery;
    qrGrupocodigo: TZIntegerField;
    qrGrupodescricao: TZRawStringField;
    qrGrupoid: TZIntegerField;
    qrGrupotipo: TZRawStringField;
    qrTipo: TZQuery;
    descgrupo: TStringField;
    qrTipocodigo: TZIntegerField;
    qrTipodescricao: TZRawStringField;
    qrTipogrupo: TZIntegerField;
    qrTipoid: TZIntegerField;
    qrTipotipo: TZRawStringField;
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure BtnLocalizarClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure excluirregistro;
    procedure editarregistro;
    procedure FormCreate(Sender: TObject);
  private
    procedure ExportD2Bridge; override;
    procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
    procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;

  public

  end;



Function FormConTipo: TFormConTipo;



implementation
uses udm;
{$R *.lfm}

{ TFormConTipo }


Function FormConTipo: TFormConTipo;
begin
   Result:= (TFormConTipo.GetInstance as TFormConTipo);
end;

procedure TFormConTipo.ExportD2Bridge;
begin
  inherited;

  Title:= 'Contas Web Laz';
  SubTitle:= 'Cadastro de Tipos de Contas a Pagar e Receber';

//  TemplateClassForm:= TD2BridgeFormTemplate;
  D2Bridge.FrameworkExportType.TemplateMasterHTMLFile:= 'template.html';
  D2Bridge.FrameworkExportType.TemplatePageHTMLFile := 'itemtemplate.html';

  if FormCadTipo = nil then
    TFormCadTipo.CreateInstance;

  D2Bridge.AddNested(FormCadTipo);

  //Export yours Controls
  with D2Bridge.Items.add do
  begin
     with row.Items.Add do
     begin
          with FormGroup(lblLocalizar.Caption) do
           AddVCLObj(EditLocalizar);

          with FormGroup do
           AddVCLObj(BtnLocalizar,CSSClass.Button.search);

          with FormGroup do
            AddVCLObj(BtnNovo, CSSClass.Button.add);
     end;

     with row('mt-3').Items.Add do
        VCLObj(DBGrid1);

     with row.Items.Add do
        with FormGroup do
          AddVCLObj(btnFechar,CSSClass.Button.close);

     Popup('Popup'+FormCadTipo.Name, 'Tipo de Receita e Despesa',True, CSSClass.Popup.Large).Items.Add.Nested(formCadTipo.Name);
  end;
end;

procedure TFormConTipo.InitControlsD2Bridge(const PrismControl: TPrismControl);
begin
  inherited;

   if PrismControl.IsDBGrid then
    begin
       PrismControl.AsDBGrid.RecordsPerPage := 10;
       PrismControl.AsDBGrid.MaxRecords := 2000;

       with PrismControl.AsDBGrid do
       begin
         with Columns.Add do
         begin
            Title:= 'Ações';
            ColumnIndex :=0;
            Width := 50;
            With Buttons.Add do
              begin
               ButtonModel := TButtonModel.edit;
               Caption:='';
               Onclick := BtnEditarClick;
              end;


            With Buttons.Add do
              begin
               ButtonModel := TButtonModel.Delete;
               Caption:='';
               Onclick := BtnExcluirClick;
              end;
         end;

       end;
    end;

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

procedure TFormConTipo.RenderD2Bridge(const PrismControl: TPrismControl;
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

procedure TFormConTipo.BtnLocalizarClick(Sender: TObject);
begin
    try
     qrTipo.Connection.connected:=true;
     dsTipo.DataSet.close;
     dsGrupo.DataSet.Close;
     qrTipo.SQL.Text := 'Select * from conta Where descricao like '+ QuotedStr('%'+editLocalizar.Text+'%');
     dsTipo.DataSet.open;
     dsGrupo.DataSet.open;
    except on E:Exception  do
     begin
        ShowMessage(E.Message);
     end;
  end;
end;

procedure TFormConTipo.BtnNovoClick(Sender: TObject);
begin
  qrTipo.insert;
  if IsD2BridgeContext then
     ShowPopup('Popup'+formCadTipo.name)
   else
     FormCadTipo.showmodal;


end;

procedure TFormConTipo.DBGrid1DblClick(Sender: TObject);
begin
   editarregistro;
end;

procedure TFormConTipo.BtnEditarClick(Sender: TObject);
begin
    editarregistro;
end;

procedure TFormConTipo.BtnExcluirClick(Sender: TObject);
begin
    excluirregistro;
end;

procedure TFormConTipo.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFormConTipo.editarregistro;
begin
  dsTipo.DataSet.edit;

  if IsD2BridgeContext then
    ShowPopup('Popup'+formCadTipo.name)
  else
    FormCadTipo.showmodal;


end;

procedure TFormConTipo.FormCreate(Sender: TObject);
begin
  BtnLocalizarClick(Sender);
end;

procedure TFormConTipo.excluirregistro;
begin
   if messagedlg('Deseja Realmente excluir este registro?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
    qrTipo.Delete;

end;

end.

