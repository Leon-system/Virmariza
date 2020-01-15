unit Articulos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListBox, FMX.Layouts, FMX.Edit, FMX.Objects, FMX.Controls.Presentation,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,System.math;

type
  TfArticulos = class(TForm)
    Line1: TLine;
    EditNombre: TEdit;
    ComboBoxLinea: TComboBox;
    Label1: TLabel;
    EditCantidad: TEdit;
    EditCosto: TEdit;
    EditPrecio: TEdit;
    EditPrecioMayoreo: TEdit;
    EditBolero: TEdit;
    Layout2: TLayout;
    Layout3: TLayout;
    EditPrecioEspecial: TEdit;
    btnBorrar: TButton;
    BtnPorcentaje: TButton;
    BtnInsertar: TButton;
    Layout5: TLayout;
    Layout6: TLayout;
    EditFlete: TEdit;
    chkIva: TCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    lblRecalc: TLabel;
    MainLayout1: TLayout;
    VertScrollBox1: TVertScrollBox;
    lytBtn: TLayout;
    procedure BtnBuscarClick(Sender: TObject);
    procedure btnBorrarClick(Sender: TObject);
    Function InsertarArticulo:Boolean;
    procedure BuscarArticulo;
    procedure BuscarLinea;
    Function ActualizarArticulo:Boolean;
    Function BorrarArticulo:Boolean;
    procedure ObtenerPorcetaje;
    procedure Limpiar;
    function Validar:Boolean;
    procedure BtnInsertarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnPorcentajeClick(Sender: TObject);
    procedure EditNombreKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EditCantidadKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EditPrecioKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EditCostoKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EditBoleroKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EditPrecioMayoreoKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EditPrecioEspecialKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure Image1Click(Sender: TObject);
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormFocusChanged(Sender: TObject);

  private
  TecladoActivo: Boolean;
  Combo_Seleccionado:Boolean;
  Prcje_Publico:Double;
  Prcje_Bolero:Double;
  Prcje_Mayoreo:Double;
  Prcje_Especial:Double;
  Costo:string;
  private
    { Private declarations }
  FKBBounds: TRectF;
  FNeedOffset: Boolean;
  procedure UpdateKBBounds;
  procedure RestorePosition;
  procedure CalcContentBoundsProc(Sender: TObject;
  var ContentBounds: TRectF);
  public
  ID:Integer;
    { Public declarations }
  end;

var
  fArticulos: TfArticulos;

implementation

{$R *.fmx}

uses Main, FGX.Toasts, FGX.Toasts.Android, Funciones_Android;

Function TfArticulos.ActualizarArticulo:Boolean;
var
IVA:Integer;
begin
  try
   if chkIva.IsChecked then IVA:=1
   else IVA:=0;
    with MainForm.FDQueryInsertar,SQL do
    begin
      Clear;
      Add('Update articulo set Nombre='+''''+EditNombre.Text+''''+',Linea='+''''+ComboBoxLinea.Selected.Text+''''+',Cantidad='+''''+EditCantidad.Text+''''+',Costo='+''''+EditCosto.Text+''''+',Publico='+''''+EditPrecio.Text+'''');
      Add(',Mayoreo='+''''+EditPrecioMayoreo.Text+''''+',Bolero='+''''+EditBolero.text+''''+',Especial='+''''+EditPrecioEspecial.text+'''');
      Add(',IVA='+IVA.ToString+',Flete='+EditFlete.text+',Costo_Rec='+''''+Costo+'''');
      Add(' Where rowid='+ID.ToString);
      MainForm.FDQueryInsertar.ExecSQL;
      Result:=True;
    end;
  except
    on E:exception do
    begin
      ShowMessage('No se pudo actualizar el artículo '+e.Message);
      Result:=False;
    end;

  end;
end;

function TfArticulos.BorrarArticulo:Boolean;
begin
  try
    with MainForm.FDQueryInsertar,SQL do
    begin
      Clear;
      Add('Delete from articulo where rowid='+ID.ToString);
      MainForm.FDQueryInsertar.ExecSQL;
      Result:=True;
    end;
  except
    on E:exception do
    begin
      ShowMessage('No se pudo borrar el artículo '+e.Message);
      Result:=False;
    end;

  end;
end;


procedure TfArticulos.btnBorrarClick(Sender: TObject);
begin
   begin
       MessageDlg('¿Desea eliminar el articulo seleccionado? ', System.UITypes.TMsgDlgType.mtInformation,
      [System.UITypes.TMsgDlgBtn.mbOK,System.UITypes.TMsgDlgBtn.mbNo], 0, procedure(const AResult: System.UITypes.TModalResult)
      begin
        case AResult of
          mrOk:
          begin
           if  BorrarArticulo then
           begin
             Limpiar;
             ToastImagen('Articulo eliminado correctamente',false,MainForm.LogoVirma.Bitmap,$FFFFFF,$FF000000);
             MainForm.LlenarTabla;
           end;
          end;
          mrNo:
        end;
      end);
   end;
end;

procedure TfArticulos.BtnBuscarClick(Sender: TObject);
begin
  BuscarArticulo;
end;
procedure TfArticulos.BtnInsertarClick(Sender: TObject);
begin
  ObtenerPorcetaje;
  if validar then
  if ID>0 then
  begin

    if InsertarArticulo then
    begin
      Limpiar;
      OcultarTeclado;
      MainForm.LlenarTabla;
      ToastImagen('Artículo actualizado correctamente',false,MainForm.LogoVirma.Bitmap,$FFFFFF,$FF000000);
    end;
  end
  else
  begin
    if ActualizarArticulo then
    begin
      Limpiar;
      OcultarTeclado;
      MainForm.LlenarTabla;
      ToastImagen('Artículo actualizado correctamente',false,MainForm.LogoVirma.Bitmap,$FFFFFF,$FF000000);
    end;
  end;
end;

procedure TfArticulos.BtnPorcentajeClick(Sender: TObject);
begin
  ObtenerPorcetaje;
  ShowMessage('Porcentaje ganancia publico:'+(FormatFloat('#.##',Prcje_Publico ))+'%'+sLineBreak
  +'Porcentaje ganancia Bolero:'+(FormatFloat('#.##',Prcje_Bolero ))+'%' +sLineBreak
  +'Porcentaje ganancia mayoreo:'+(FormatFloat('#.##',Prcje_Mayoreo ))+'%' +sLineBreak
  +'Porcentaje ganancia especial:'+(FormatFloat('#.##',Prcje_Especial ))+'%' +sLineBreak );
end;

procedure TfArticulos.BuscarArticulo;
begin
   try
    with MainForm.FDQueryBuscar,SQL do
    begin
      Active :=  False;
      Clear;
      Add('select Nombre,Cantidad,Costo,Publico,Bolero,Mayoreo,Especial,Iva,Flete,Costo_Rec from Articulo where rowid='+id.ToString);
      //Add('');
      Close;
      Open;
      EditNombre.Text:=Fields[0].AsString;
      EditCantidad.Text:=Fields[1].AsString;
      EditCosto.Text:=Fields[2].AsString;
      EditPrecio.Text:=Fields[3].AsString;
      EditBolero.Text:=Fields[4].AsString;
      EditPrecioMayoreo.Text:=Fields[5].AsString;
      EditPrecioEspecial.Text:=Fields[6].AsString;
      if Fields[7].AsInteger=1 then chkIva.IsChecked:=True else chkIva.IsChecked:=False;
      EditFlete.Text:=Fields[8].AsString;
      lblRecalc.Text:=Fields[8].AsString;
     end;
  except
    on E:exception do
     showmessage(e.Message);
  end;
end;

procedure TfArticulos.BuscarLinea;
begin
   try
    with MainForm.FDQueryBuscar,SQL do
    begin
      ComboBoxLinea.Clear;
      Active :=  False;
      Clear;
      Add('Select Nombre From Linea');
      Close;
      Open;
      while not eof do
      begin
        try
          begin
            ComboBoxLinea.Items.Add(Fields[0].AsString);
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

procedure TfArticulos.CalcContentBoundsProc(Sender: TObject;
  var ContentBounds: TRectF);
begin
   if FNeedOffset and (FKBBounds.Top > 0) then
  begin
    ContentBounds.Bottom := Max(ContentBounds.Bottom,
                                30 * ClientHeight - FKBBounds.Top);
  end;
end;

procedure TfArticulos.EditBoleroKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
 if Key = vkReturn then EditPrecioMayoreo.SetFocus;
end;

procedure TfArticulos.EditCantidadKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then EditCosto.SetFocus;
end;

procedure TfArticulos.EditCostoKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
   if Key = vkReturn then EditPrecio.SetFocus;
end;

procedure TfArticulos.EditNombreKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then EditCantidad.SetFocus;
end;

procedure TfArticulos.EditPrecioEspecialKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
   if Key = vkReturn then BtnInsertarClick(Nil);
end;

procedure TfArticulos.EditPrecioKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
   if Key = vkReturn then EditBolero.SetFocus;
end;

procedure TfArticulos.EditPrecioMayoreoKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
   if Key = vkReturn then EditPrecioEspecial.SetFocus;
end;

procedure TfArticulos.FormFocusChanged(Sender: TObject);
begin
  UpdateKBBounds;
end;

procedure TfArticulos.FormShow(Sender: TObject);
begin
  BuscarLinea;
  EditFlete.Text:=MainForm.Flete.ToString;
end;

procedure TfArticulos.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  TecladoActivo:=False;
  FKBBounds.Create(0, 0, 0, 0);
  FNeedOffset := False;
  RestorePosition;
  //Layout1.Align := TAlignLayout.Bottom;
end;

procedure TfArticulos.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  TecladoActivo:=True;
  FKBBounds := TRectF.Create(Bounds);
  FKBBounds.TopLeft := ScreenToClient(FKBBounds.TopLeft);
  FKBBounds.BottomRight := ScreenToClient(FKBBounds.BottomRight);
  UpdateKBBounds;
end;

procedure TfArticulos.Image1Click(Sender: TObject);
begin
  if TecladoActivo then OcultarTeclado else MainForm.Show;
end;

function TfArticulos.InsertarArticulo:Boolean;
var
Nombre:string;
IVA:Integer;
Cancelo:Boolean;
begin
   if chkIva.IsChecked then IVA:=1
   else IVA:=0;
  try
    with MainForm.FDQueryInsertar,SQL do
    begin
      Clear;
      Add('Select Nombre from articulo where Nombre='+''''+EditNombre.Text+'''');
      Close;
      Open;
      Nombre:=(Fields[0].AsString);
      if Nombre=('') then
       begin
        Clear;
        Add('Insert into articulo (Nombre,Linea,Cantidad,Costo,Publico,Mayoreo,Bolero,Especial,IVA,Flete,Costo_Rec) ');
        Add('Values ('+''''+EditNombre.Text+''''+','+''''+ComboBoxLinea.Selected.Text+''''+','+''''+EditCantidad.Text+''''+',');
        Add(''''+EditCosto.Text+''''+','+''''+EditPrecio.Text+''''+','+''''+EditPrecioMayoreo.Text+''''+','+''''+EditBolero.text+''''+',');
        Add(''''+EditPrecioEspecial.text+''''+','+IVA.ToString+','+EditFlete.text+','+''''+Costo+''''+')');
        MainForm.FDQueryInsertar.ExecSQL;
       end
      else
      begin
        MessageDlg('Ya existe un articulo con el mismo nombre ¿Desea insertarlo nuevamente? ', System.UITypes.TMsgDlgType.mtInformation,
        [System.UITypes.TMsgDlgBtn.mbOK,System.UITypes.TMsgDlgBtn.mbNo], 0, procedure(const AResult: System.UITypes.TModalResult)
        begin
          case AResult of
            mrOk:
            begin
              Clear;
              Add('Insert into articulo (Nombre,Linea,Cantidad,Costo,Publico,Mayoreo,Bolero,Especial,IVA,Flete,Costo_Rec) ');
              Add('Values ('+''''+EditNombre.Text+''''+','+''''+ComboBoxLinea.Selected.Text+''''+','+''''+EditCantidad.Text+''''+',');
              Add(''''+EditCosto.Text+''''+','+''''+EditPrecio.Text+''''+','+''''+EditPrecioMayoreo.Text+''''+','+''''+EditBolero.text+''''+',');
              Add(''''+EditPrecioEspecial.text+''''+','+IVA.ToString+','+EditFlete.text+','+''''+Costo+''''+')');
              MainForm.FDQueryInsertar.ExecSQL;
            end;
            mrNo:
            Cancelo:=True;
          end;
        end);
      end;
    end;
    if not Cancelo then
    Result:=True;
  except
    on E:exception do
    begin
       ShowMessage('No se pudo insertar el artículo '+e.Message);
       Result:=False;
    end;
  end;
end;

procedure TfArticulos.Limpiar;
begin
  ID:=0;
  EditNombre.Text:='';
  EditCantidad.Text:='';
  EditCosto.Text:='';
  EditPrecio.Text:='';
  EditBolero.Text:='';
  EditPrecioMayoreo.Text:='';
  EditPrecioEspecial.Text:='';
  EditFlete.Text:='';
  chkIva.IsChecked:=False;
  EditFlete.Text:=MainForm.Flete.ToString;
  ComboBoxLinea.ItemIndex:=-1;
end;

procedure TfArticulos.ObtenerPorcetaje;
var
  Precio,Bolero,Mayoreo,Especial : string;
begin
 { Costo  := StringReplace(EditCosto.Text, '.',',',
    [rfReplaceAll, rfIgnoreCase]);
  Precio  := StringReplace(EditPrecio.Text, '.',',',
    [rfReplaceAll, rfIgnoreCase]);
  Bolero  := StringReplace(EditBolero.Text, '.',',',
    [rfReplaceAll, rfIgnoreCase]);
  Mayoreo  := StringReplace(EditPrecioMayoreo.Text, '.',',',
    [rfReplaceAll, rfIgnoreCase]);
  Especial  := StringReplace(EditPrecioEspecial.Text, '.',',',
    [rfReplaceAll, rfIgnoreCase]); }
  Costo  := EditCosto.Text;
  Precio  := EditPrecio.Text;
  Bolero  := EditBolero.Text;
  Mayoreo := EditPrecioMayoreo.Text;
  Especial:= EditPrecioEspecial.Text;
  //Asigna impuestos y flete
  if not ((Editflete.Text.ToInteger=0) or (Editflete.Text.Equals('')))  then
  Costo:=(StrToFloat(Costo)*(((StrToFloat(Editflete.Text))*0.01)+1)).ToString;
  if chkIva.IsChecked then
  Costo:=(StrToFloat(Costo)*1.16).ToString;
  lblRecalc.Text:=Costo;
  if Editprecio.Text<>('') then Prcje_Publico:=(100*(( -StrToFloat(Costo)+ StrToFloat(precio))/Costo.ToDouble));
  //ShowMessage(Prcje_Publico.ToString);
  if EditBolero.Text<>('') then Prcje_Bolero:=(100*((-costo.ToDouble+Bolero.ToDouble)/Costo.ToDouble));
  // ShowMessage(Prcje_Bolero.ToString);
  if EditprecioMayoreo.Text<>('') then Prcje_Mayoreo:=(100*((-costo.ToDouble+Mayoreo.ToDouble)/Costo.ToDouble));
   // ShowMessage(Prcje_Mayoreo.ToString);
  if EditprecioEspecial.Text<>('') then Prcje_Especial:=(100*((-costo.ToDouble+Especial.ToDouble)/Costo.ToDouble));
    //ShowMessage(Prcje_Especial.ToString);
  end;

procedure TfArticulos.RestorePosition;
begin
  VertScrollBox1.ViewportPosition := PointF(VertScrollBox1.ViewportPosition.X, 0);
  MainLayout1.Align := TAlignLayout.Client;
  VertScrollBox1.RealignContent;
end;

procedure TfArticulos.UpdateKBBounds;
 var
  LFocused : TControl;
  LFocusRect: TRectF;
begin
   FNeedOffset := False;
  if Assigned(Focused) then
  begin
    LFocused := TControl(Focused.GetObject);
    LFocusRect := LFocused.AbsoluteRect;
    LFocusRect.Offset(VertScrollBox1.ViewportPosition);
    if (LFocusRect.IntersectsWith(TRectF.Create(FKBBounds))) and (LFocusRect.Bottom > FKBBounds.Top)
    then
    begin
      FNeedOffset := True;
      MainLayout1.Align := TAlignLayout.Horizontal;
      VertScrollBox1.RealignContent;
      Application.ProcessMessages;
      VertScrollBox1.ViewportPosition :=
      PointF(VertScrollBox1.ViewportPosition.X,
      LFocusRect.Bottom - FKBBounds.Top);
    end;
  end;
  if not FNeedOffset then
    RestorePosition;
end;

function TfArticulos.Validar: Boolean;
begin
  if EditNombre.Text.Equals('')  then
  begin
    ShowMessage('Ingrese un nombre para el artículo');
    EditNombre.SetFocus;
    Result:=False;
    Exit;
  end;
  if EditCosto.Text.Equals('')  then
  begin
    ShowMessage('Ingrese un costo');
    EditCosto.SetFocus;
    Result:=False;
    Exit;
  end;

  if EditPrecio.Text.Equals('') then
  begin
    ShowMessage('Ingrese un precio');
    EditPrecio.SetFocus;
    Result:=False;
    Exit;
  end;
  if ComboBoxLinea.ItemIndex=-1 then
  begin
    ShowMessage('Seleccione una linea');
    ComboBoxLinea.SetFocus;
    Result:=False;
    Exit;
  end;
  if  Prcje_Publico<=0 then
  begin
    MessageDlg('¿El porcentaje de ganancia al público en general es igual o menor a cero, ¿Desea continuar guardando el artículo con pérdidas? ', System.UITypes.TMsgDlgType.mtInformation,
    [System.UITypes.TMsgDlgBtn.mbOK,System.UITypes.TMsgDlgBtn.mbNo], 0, procedure(const AResult: System.UITypes.TModalResult)
    begin
      case AResult of
        mrOk:
        begin
         Exit
        end;
        mrNo:
      end;
    end);
    EditPrecio.SetFocus;
    Result:=False;
    Exit;
  end;
   if  Prcje_Bolero<=0 then
  begin
    MessageDlg('¿El porcentaje de ganancia para bolero es igual o menor a cero, ¿Desea continuar guardando el artículo con pérdidas? ', System.UITypes.TMsgDlgType.mtInformation,
    [System.UITypes.TMsgDlgBtn.mbOK,System.UITypes.TMsgDlgBtn.mbNo], 0, procedure(const AResult: System.UITypes.TModalResult)
    begin
      case AResult of
        mrOk:
        begin
         Exit
        end;
        mrNo:
      end;
    end);
    EditBolero.SetFocus;
    Result:=False;
    Exit;
  end;
   if  Prcje_Mayoreo<=0 then
  begin
    MessageDlg('¿El porcentaje de ganancia de mayoreo es igual o menor a cero, ¿Desea continuar guardando el artículo con pérdidas? ', System.UITypes.TMsgDlgType.mtInformation,
    [System.UITypes.TMsgDlgBtn.mbOK,System.UITypes.TMsgDlgBtn.mbNo], 0, procedure(const AResult: System.UITypes.TModalResult)
    begin
      case AResult of
        mrOk:
        begin
         Exit
        end;
        mrNo:
      end;
    end);
    EditPrecioMayoreo.SetFocus;
    Result:=False;
    Exit;
  end;
  Result:=True;
end;

end.
