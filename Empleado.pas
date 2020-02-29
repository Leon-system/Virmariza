unit Empleado;

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
  TEmpleados = class(TForm)
    LayoutEmp: TLayout;
    Layout3: TLayout;
    EditEmp: TEdit;
    BtnGuardarEmp: TButton;
    BtnBorrarEmp: TButton;
    EdtGanancia: TEdit;
    StringGridEmp: TStringGrid;
    FDMemLista: TFDMemTable;
    FDMemListaNombre: TStringField;
    FDMemListaPorcentajedeGanancia: TStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    FDMemListaID: TIntegerField;
    procedure InsertarEmpleado;
    procedure BorrarEmpleado;
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
  Empleados: TEmpleados;

implementation

{$R *.fmx}
{$R *.LgXhdpiTb.fmx ANDROID}

uses Main, Androidapi.JNI.Toasts, FGX.Toasts, FGX.Toasts.Android, Funciones_Android;

{ TLineas }

procedure TEmpleados.BorrarEmpleado;
begin
   try
    with MainForm.FDQueryInsertar,SQL do
    begin
      Clear;
      Add('Delete from Empleado where rowid=:ID');
      Params[0].AsInteger:=FDMemListaID.AsInteger;
      MainForm.FDQueryInsertar.ExecSQL;
      BuscarEmp;
      ToastImagen('Empleado eliminado',false,MainForm.LogoVirma.Bitmap,$FFFFFF,$FF000000);
    end;
    except
    on E:exception do
    ShowMessage('No se pudo borrar el empleado '+e.Message);
  end;
end;

procedure TEmpleados.btnbackClick(Sender: TObject);
begin
  MainForm.Show;
end;

procedure TEmpleados.BtnBorrarEmpClick(Sender: TObject);
begin
  begin
     MessageDlg('¿Desea eliminar el empleado seleccionado? ', System.UITypes.TMsgDlgType.mtInformation,
    [System.UITypes.TMsgDlgBtn.mbOK,System.UITypes.TMsgDlgBtn.mbNo], 0, procedure(const AResult: System.UITypes.TModalResult)
    begin
      case AResult of
        mrOk:
        begin
          BorrarEmpleado;
        end;
        mrNo:
      end;
    end);
  end;
end;

procedure TEmpleados.BuscarEmp;
begin
  try
    FDMemLista.DisableControls;
    FDMemLista.Close;
    FDMemLista.Open;
    with MainForm.FDQueryBuscar,SQL do
    begin
      Active :=  False;
      Clear;
      Add('Select Rowid,Nombre,Ganancia From Empleado');
      close;
      Open;
      while not Eof do
      begin
        FDMemLista.Append;
        (FDMemLista.FieldByName('ID') as TIntegerField).AsInteger:= Fields[0].AsInteger;
        (FDMemLista.FieldByName('Nombre') as TStringField).AsString:= Fields[1].AsString;
        (FDMemLista.FieldByName('Porcentaje de Ganancia') as TStringField).AsString:= Fields[2].AsString+'%';
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

procedure TEmpleados.BtnGuardarEmpClick(Sender: TObject);
begin
  if EditEmp.Text.Equals('') or EdtGanancia.Text.Equals('') then ShowMessage('Inserte nombre y ganancia del empleado') else
  begin
    InsertarEmpleado;
    BuscarEmp;
  end;

  MainForm.ObtenerEmpleadosLista;
  MainForm.ObtenerEmpleadosTrabajo;
end;


procedure TEmpleados.FormShow(Sender: TObject);
begin
  BuscarEmp;
end;

procedure TEmpleados.Image1Click(Sender: TObject);
begin
  MainForm.Show;
end;

procedure TEmpleados.InsertarEmpleado;
begin
  try
    with MainForm.FDQueryInsertar,SQL do
    begin
      Clear;
      Add('insert into Empleado (Nombre,Ganancia) ');
      Add('values (:Nombre,:Ganancia)');
      Params[0].AsString:=EditEmp.Text;
      Params[1].AsString:=EdtGanancia.Text;
      MainForm.FDQueryInsertar.ExecSQL;
      EditEmp.Text:='';
      EdtGanancia.Text:='';
      OcultarTeclado;
      ToastImagen('Empleado insertado exitosamente',false,MainForm.LogoVirma.Bitmap,$FFFFFF,$FF000000);
    end;
  except
    on E:exception do
      ShowMessage('No se pudo insertar el empleado '+e.Message);
  end;
end;

end.
