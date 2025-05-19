unit uFormGrupo;

{ Copyright 2024 / 2025 D2Bridge Framework by Talis Jonatas Gomes }

interface

uses
  Classes, SysUtils, Controls, Graphics, Dialogs, StdCtrls, DBCtrls,  
  unit_formcrudtemplate, D2Bridge.Forms, DB;

type

  { TFormGrupo }

  TFormGrupo = class(TFormCrudTemplate)
    Crud_Querycodigo: TLongintField;
    Crud_Querydescricao: TStringField;
    Crud_Queryid: TLongintField;
    Crud_Querytipo: TStringField;
    DBComboBox1: TDBComboBox;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure Crud_ButtonSearchClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure ExportD2Bridge; override;
    procedure InitControlsD2Bridge(const PrismControl: TPrismControl); override;
    procedure RenderD2Bridge(const PrismControl: TPrismControl; var HTMLControl: string); override;
    //CRUD Events
    procedure CrudOnOpen; override;
    procedure CrudOnSearch(AText: string); override;
    function CrudOnEdit: boolean; override;
    function CrudOnInsert: boolean; override;
    function CrudOnSave: boolean; override;
    function CrudOnDelete: boolean; override;
    function CrudOnBack: boolean; override;
    function CrudOnClose: boolean; override;		
  end;

function FormGrupo: TFormGrupo;

implementation

uses
  ContasWebLazWebApp;

{$R *.lfm}

function FormGrupo: TFormGrupo;
begin
  result:= (TFormGrupo.GetInstance as TFormGrupo);
end;

procedure TFormGrupo.Crud_ButtonSearchClick(Sender: TObject);
begin
  inherited;
end;

procedure TFormGrupo.FormShow(Sender: TObject);
begin
  inherited;
    CrudOperation(OPBack);

end;

procedure TFormGrupo.ExportD2Bridge;
begin
  inherited;

  Title:= 'Cadastro de Grupos';
  SubTitle:= '';

  Crud_PanelTitle.Caption:= '';
  Crud_PanelSubTitle.Caption:= '';

  //TemplateClassForm:= TD2BridgeFormTemplate;
  //D2Bridge.FrameworkExportType.TemplateMasterHTMLFile := '';
  //D2Bridge.FrameworkExportType.TemplatePageHTMLFile := '';

  with Crud_CardData.Items.Add do
  begin
    FormGroup(label1.Caption, CSSClass.Col.colsize4).AddVCLObj(DBEdit1);
    FormGroup(label2.Caption, CSSClass.Col.colsize12).AddVCLObj(dbedit2);
    FormGroup(label3.Caption, CSSClass.Col.colsize6).AddVCLObj(DBComboBox1);

    { Yours components of tab "Data" }
  end;

  with Crud_CardData.Footer.Items.Add do
  begin
    { Aditional buttons in Footer }
  end;
end;

procedure TFormGrupo.InitControlsD2Bridge(const PrismControl: TPrismControl);
begin
  inherited;

  //Change CRUD Component property
  {
  if PrismControl.VCLComponent = Crud_DBGrid_Search then
  begin
    with PrismControl.AsDBGrid do
    begin
    with Columns.ColumnByIndex(0) do
    begin
      //Example button EDIT invisible
      ButtonFromButtonModel(TButtonModel.Edit).Visible:= false;
      //Example button EDIT disabled
      ButtonFromButtonModel(TButtonModel.Edit).Enabled:= false;

      //Example Add new Button
      Width:= 105;
      with Buttons.Add do
      begin
      ButtonModel:= TButtonModel.Options;
      Caption:= '';
      end;
    end;
    end;
  end;
  }
end;

procedure TFormGrupo.RenderD2Bridge(const PrismControl: TPrismControl;
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

procedure TFormGrupo.CrudOnOpen;
begin
  inherited;

  CrudOperation(OpSearch);
end;

procedure TFormGrupo.CrudOnSearch(AText: string);
begin
  inherited;
  Crud_Query.Close;
  Crud_query.sql.Text:='select * from grupoconta where descricao like '+ QuotedStr( '%'+ Crud_EditSearch.Text +'%') ;
  Crud_Query.Open;
  {
  //Example1
  Crud_Query.Close;
  Crud_Query.Parameters.ParamByName('Field').Value:= '%' + AText + '%';
  Crud_Query.Open;

  //Example2
    CrudDefaultSearch('TableName', 'FieldName', Crud_EditSearch.Text, 'FiedOrder');

  //Example3
  CrudDefaultSearch(
    'TableName',
    ['FieldOne', 'FieldTwo'], //Search in two fields example
    Crud_EditSearch.Text,
    ['FieldTree = 1', 'FieldFour = ''X'''],
    ['FieldOrder1', 'FieldOrder2']
  );
  }
end;

function TFormGrupo.CrudOnEdit: boolean;
begin
  result:= inherited;

  Crud_Query.Edit;
end;

function TFormGrupo.CrudOnInsert: boolean;
begin
  result:= inherited;


  if not Crud_Query.IsEmpty then
  begin
    Crud_Query.Insert;
  end;
  Crud_Query.Edit;

end;

function TFormGrupo.CrudOnSave: boolean;
begin
  result:= inherited;

  Crud_Query.Edit;
  Crud_Query.Post;
end;

function TFormGrupo.CrudOnDelete: boolean;
begin
  result:= inherited;

  Crud_Query.Edit;
  Crud_Query.Delete;
end;

function TFormGrupo.CrudOnBack: boolean;
begin
  result:= inherited;

end;

function TFormGrupo.CrudOnClose: boolean;
begin
  result:= inherited;

  Crud_Query.Close;
end;

end.
