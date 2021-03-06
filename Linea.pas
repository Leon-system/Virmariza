unit Linea;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox,
  FMX.StdCtrls, FMX.Layouts, FMX.Edit, FMX.Controls.Presentation, FMX.Objects,
  System.Rtti, FMX.Grid.Style, FMX.ScrollBox, FMX.Grid, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TLineas = class(TForm)
    LayoutEmp: TLayout;
    Layout3: TLayout;
    EditLinea: TEdit;
    BtnGuardarEmp: TButton;
    BtnBorrarEmp: TButton;
    StringGridEmp: TStringGrid;
    FDMemLista: TFDMemTable;
    FDMemListaNombre: TStringField;
    FDMemListaPorcentajedeGanancia: TStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    FDMemListaID: TIntegerField;
    procedure InsertarLinea;
    procedure BorrarLinea;
    procedure BuscarEmp;
    procedure FormShow(Sender: TObject);
    procedure BtnGuardarEmpClick(Sender: TObject);
    procedure BtnBorrarEmpClick(Sender: TObject);
    procedure btnbackClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
    Trabajo,Linea:Boolean;
  public
    { Public declarations }
  end;

var
  Lineas: TLineas;

implementation

{$R *.fmx}
{$R *.LgXhdpiTb.fmx ANDROID}

uses Main, Androidapi.JNI.Toasts, FGX.Toasts, FGX.Toasts.Android, Funciones_Android;

{ TLineas }


procedure TLineas.BorrarLinea;
begin
   try
    with MainForm.FDQueryInsertar,SQL do
    begin
      Clear;
      Add('Delete from Linea where Rowid=:ID');
      Params[0].AsInteger:=FDMemListaID.AsInteger;
      MainForm.FDQueryInsertar.ExecSQL;
      BuscarEmp;
      ToastImagen('Linea eliminada',false,MainForm.LogoVirma.Bitmap,$FFFFFF,$FF000000);
    end;
    except
    on E:exception do
    ShowMessage('No se pudo borrar la linea '+e.Message);
  end;
end;

procedure TLineas.btnbackClick(Sender: TObject);
begin
  MainForm.Show;
end;

procedure TLineas.BtnBorrarEmpClick(Sender: TObject);
begin
  begin
     MessageDlg('�Desea eliminar el empleado seleccionado? ', System.UITypes.TMsgDlgType.mtInformation,
    [System.UITypes.TMsgDlgBtn.mbOK,System.UITypes.TMsgDlgBtn.mbNo], 0, procedure(const AResult: System.UITypes.TModalResult)
    begin
      case AResult of
        mrOk:
        begin
          BorrarLinea;
        end;
        mrNo:
      end;
    end);
  end;
end;

procedure TLineas.BuscarEmp;
begin
  try
    FDMemLista.DisableControls;
    FDMemLista.Close;
    FDMemLista.Open;
    with MainForm.FDQueryBuscar,SQL do
    begin
      Active :=  False;
      Clear;
      Add('Select Rowid,Nombre From Linea');
      close;
      Open;
      while not Eof do
      begin
        FDMemLista.Append;
        (FDMemLista.FieldByName('ID') as TIntegerField).AsInteger:= Fields[0].AsInteger;
        (FDMemLista.FieldByName('Nombre') as TStringField).AsString:= Fields[1].AsString;
        //(FDMemLista.FieldByName('Porcentaje de Ganancia') as TStringField).AsString:= Fields[2].AsString+'%';
        FDMemLista.Post;
        Next;
      end;
    end;
    FDMemLista.EnableControls;
  except
    on E:Exception do
    showmessage(E.Message);
  end;
end;

procedure TLineas.BtnGuardarEmpClick(Sender: TObject);
begin
   if EditLinea.Text.Equals('') then ShowMessage('Inserte una linea') else
  begin
    InsertarLinea;
    MainForm.ObtenerLineas;
    BuscarEmp;
  end;
end;


procedure TLineas.FormShow(Sender: TObject);
begin
  BuscarEmp;
end;

procedure TLineas.Image1Click(Sender: TObject);
begin
  MainForm.Show;
end;



procedure TLineas.InsertarLinea;
begin
  try
    with MainForm.FDQueryInsertar,SQL do
    begin
      Clear;
      Add('insert into linea (Nombre) values ('+''''+EditLinea.Text+''''+')');
      MainForm.FDQueryInsertar.ExecSQL;
      EditLinea.Text:='';
      OcultarTeclado;
      ToastImagen('Linea insertada exitosamente',false,MainForm.LogoVirma.Bitmap,$FFFFFF,$FF000000);
    end;
  except
    on E:exception do
      ShowMessage('No se pudo insertar la linea '+e.Message);
  end;
end;

end.
