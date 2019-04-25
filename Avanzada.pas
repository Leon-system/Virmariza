unit Avanzada;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, FMX.Layouts;

type
  TFAvanzada = class(TForm)
    Layout1: TLayout;
    lbl1: TLabel;
    EdtDias: TEdit;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    Label1: TLabel;
    Layout5: TLayout;
    CheckArt: TCheckBox;
    CheckLyE: TCheckBox;
    CheckRep: TCheckBox;
    btnGuardar: TButton;
    procedure btnGuardarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAvanzada: TFAvanzada;

implementation

uses
  Main, Funciones_Android;

{$R *.fmx}

procedure TFAvanzada.btnGuardarClick(Sender: TObject);
var
Articulos,LyE,Reparacion:Integer;
begin
  if CheckArt.IsChecked then Articulos:=1 else Articulos:=0;
  if CheckLyE.IsChecked then LyE:=1 else LyE:=0;
  if CheckRep.IsChecked then Reparacion:=1 else Reparacion:=0;
   try
    with MainForm.FDQueryInsertar,SQL do
    begin
      Active :=  False;
        Clear;
        Add('Update Configuracion ');
        Add('set Dias_Eliminar=:Dias_Eliminar ,C_Articulos=:C_Articulos,C_Empleados=:C_Empleados,C_Reparacion=:C_Reparacion');
        Params[0].AsString:=edtDias.Text;
        Params[1].AsInteger:=Articulos;
        Params[2].AsInteger:=LyE;
        Params[3].AsInteger:=Reparacion;
        ExecSQL;
        ToastImagen('Configuracion guardada correctamente',false,MainForm.LogoVirma.Bitmap,$FFFFFF,$FF000000);
        MainForm.CargaConfiguracion;
      end;
    except
    on E:exception do
    showmessage(e.Message);
  end;
end;

end.
