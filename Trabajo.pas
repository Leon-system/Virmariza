unit Trabajo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.ListBox, FMX.Layouts, FMX.Controls.Presentation, FMX.Edit;

type
  TReparacion = class(TForm)
    Layout2: TLayout;
    edtTrabajo: TEdit;
    edtinfo: TEdit;
    Layout3: TLayout;
    edtLimite: TEdit;
    edtTiempo: TEdit;
    Layout4: TLayout;
    BtnBorrarTrabajo: TButton;
    btnActualizar: TButton;
    BtnGuardarTrabajo: TButton;
    Layout5: TLayout;
    ComboTrabajo: TComboBox;
    Label1: TLabel;
    Line1: TLine;
    edtSeparacion: TEdit;
    procedure BtnGuardarTrabajoClick(Sender: TObject);
    procedure InsertarTrabajo;
    procedure BuscarTrabajo;
    procedure BorrarTrabajo;
    procedure ActualizarTrabajo;
    procedure BtnBorrarTrabajoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnActualizarClick(Sender: TObject);
    procedure Limpiar;
    procedure ComboTrabajoChange(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Reparacion: TReparacion;
  ComboSeleccionado:Boolean;
implementation

uses
  Main, Funciones_Android;

{$R *.fmx}

procedure TReparacion.ActualizarTrabajo;
begin
   try
    with MainForm.FDQueryInsertar,SQL do
    begin
      Clear;
      Add('UPDATE Trabajo');
      Add('SET Trabajo=:Trabajo,Informacion=:Informacion,Tiempo=:Tiempo,Limite=:Limite,Separacion=:Separacion');
      Add('Where Trabajo=:TrabajoOriginal');
      Params[0].AsString:=edtTrabajo.Text;
      Params[1].AsString:=edtInfo.Text;
      Params[2].AsInteger:=edtTiempo.Text.ToInteger;
      Params[3].AsInteger:=edtLimite.Text.ToInteger;
      Params[4].AsInteger:=edtSeparacion.Text.ToInteger;
      Params[5].AsString:=ComboTrabajo.Selected.Text;
      MainForm.FDQueryInsertar.ExecSQL;
      ToastImagen('Trabajo editado',false,MainForm.LogoVirma.Bitmap,$FFFFFF,$FF000000);
    end;
  except
    on E:exception do
      ShowMessage('No se pudo actualizar el trabajo '+e.Message);
  end;
end;

procedure TReparacion.BorrarTrabajo;
begin
    try
    with MainForm.FDQueryInsertar,SQL do
    begin
      Clear;
      Add('Delete from Trabajo where Trabajo='+''''+ComboTrabajo.Selected.Text+'''');
      MainForm.FDQueryInsertar.ExecSQL;
      BuscarTrabajo;
      ToastImagen('Trabajo eliminado',false,MainForm.LogoVirma.Bitmap,$FFFFFF,$FF000000);
    end;
    except
    on E:exception do
    ShowMessage('No se pudo borrar la linea '+e.Message);
  end;
end;

procedure TReparacion.btnActualizarClick(Sender: TObject);
begin
   if not ComboSeleccionado then ShowMessage('Seleccione el tipo de trabajo a actualizar')
   else
   begin
       MessageDlg('¿Desea actualizar el trabajo seleccionado? ', System.UITypes.TMsgDlgType.mtInformation,
      [System.UITypes.TMsgDlgBtn.mbOK,System.UITypes.TMsgDlgBtn.mbNo], 0, procedure(const AResult: System.UITypes.TModalResult)
      begin
        case AResult of
          mrOk:
          begin
            if EdtTrabajo.Text.Equals('') or Edtinfo.Text.Equals('') or Edtlimite.Text.Equals('') or edtTiempo.Text.Equals('')
            then ShowMessage('Ingrese nombre,información,limite y tiempo')
            else
            begin
              ActualizarTrabajo;
              Limpiar;
              OcultarTeclado;
              ComboTrabajo.Clear;
              BuscarTrabajo;
              MainForm.ObtenerTipoTrabajo;
            end;
          end;
          mrNo:
        end;
      end);
   end;
end;

procedure TReparacion.BtnBorrarTrabajoClick(Sender: TObject);
begin
  begin
        MessageDlg('¿Desea eliminar el tipo de trabajo seleccionado? ', System.UITypes.TMsgDlgType.mtInformation,
    [System.UITypes.TMsgDlgBtn.mbOK,System.UITypes.TMsgDlgBtn.mbNo], 0, procedure(const AResult: System.UITypes.TModalResult)
    begin
      case AResult of
        mrOk:
        begin
          BorrarTrabajo;
          ComboTrabajo.Clear;
          BuscarTrabajo;
          MainForm.ObtenerTipoTrabajo;
        end;
        mrNo:
      end;
    end);
  end;
end;

procedure TReparacion.BtnGuardarTrabajoClick(Sender: TObject);
begin
  if EdtTrabajo.Text.Equals('') or Edtinfo.Text.Equals('') or Edtlimite.Text.Equals('') or edtTiempo.Text.Equals('')  or edtSeparacion.Text.Equals('')
  then ShowMessage('Ingrese nombre,información,limite de trabajo por dia,tiempo de espera y cantidad de dias de separacion entre un dia y otro ')
  else
  begin
    InsertarTrabajo;
    OcultarTeclado;
    Limpiar;
    ComboTrabajo.Clear;
    BuscarTrabajo;
    MainForm.ObtenerTipoTrabajo;
  end;
end;

procedure TReparacion.BuscarTrabajo;
begin
  try
    with MainForm.FDQueryBuscar,SQL do
    begin
      ComboTrabajo.Clear;
      Active :=  False;
      Clear;
      Add('Select Trabajo From Trabajo');
      Close;
      Open;
      while not eof do
      begin
        try
          begin
            ComboTrabajo.Items.Add(Fields[0].AsString);
            Next;
          end;
          except
          on e: Exception do
          begin
            ShowMessage(e.Message);
          end;
        end;
      end;

    end;
  except
    on E:exception do
    showmessage(e.Message);
  end;
end;

procedure TReparacion.ComboTrabajoChange(Sender: TObject);
begin
  ComboSeleccionado:=True;
end;

procedure TReparacion.FormCreate(Sender: TObject);
begin
  BuscarTrabajo;
end;

procedure TReparacion.Image1Click(Sender: TObject);
begin
    MainForm.Show;
end;

procedure TReparacion.InsertarTrabajo;
begin
   try
    with MainForm.FDQueryInsertar,SQL do
    begin
      Clear;
      Add('insert into Trabajo (Trabajo,Informacion,Tiempo,Limite,Separacion)');
      Add('values (:Trabajo,:Informacion,:Tiempo,:Limite,:Separacion)');
      Params[0].AsString:=EdtTrabajo.Text;
      Params[1].AsString:=EdtInfo.Text;
      Params[2].AsString:=edtTiempo.Text;
      Params[3].AsString:=edtLimite.Text;
      Params[4].AsString:=edtSeparacion.Text;
      MainForm.FDQueryInsertar.ExecSQL;
      EdtTrabajo.Text:='';
      EdtInfo.Text:='';
      ToastImagen('Trabajo insertado exitosamente',false,MainForm.LogoVirma.Bitmap,$FFFFFF,$FF000000);
    end;
  except
    on E:exception do
      ShowMessage('No se pudo insertar el trabajo '+e.Message);
  end;
end;

procedure TReparacion.Limpiar;
begin
  edtTiempo.Text:='';
  edtTrabajo.Text:='';
  edtinfo.Text:='';
  edtLimite.Text:='';
end;

end.
