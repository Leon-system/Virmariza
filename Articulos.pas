unit Articulos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListBox, FMX.Layouts, FMX.Edit, FMX.Objects, FMX.Controls.Presentation;

type
  TfArticulos = class(TForm)
    ToolBar1: TToolBar;
    Line1: TLine;
    editId: TEdit;
    Layout1: TLayout;
    BtnBuscar: TButton;
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
    Layout4: TLayout;
    btnBorrar: TButton;
    btnActualizar: TButton;
    BtnPorcentaje: TButton;
    BtnInsertar: TButton;
    Layout5: TLayout;
    Layout6: TLayout;
    EditFlete: TEdit;
    chkIva: TCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    lblRecalc: TLabel;
    procedure BtnBuscarClick(Sender: TObject);
    procedure btnBorrarClick(Sender: TObject);
    procedure InsertarArticulo;
    procedure BuscarArticulo;
    procedure BuscarLinea;
    procedure ActualizarArticulo;
    procedure BorrarArticulo;
    procedure ObtenerPorcetaje;
    procedure Limpiar;
    procedure btnActualizarClick(Sender: TObject);
    procedure BtnInsertarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnPorcentajeClick(Sender: TObject);
    procedure ComboBoxLineaChange(Sender: TObject);
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

  private
  Combo_Seleccionado:Boolean;
  Prcje_Publico:Double;
  Prcje_Bolero:Double;
  Prcje_Mayoreo:Double;
  Prcje_Especial:Double;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  fArticulos: TfArticulos;

implementation

{$R *.fmx}

uses Main, FGX.Toasts, FGX.Toasts.Android, Funciones_Android;

procedure TfArticulos.ActualizarArticulo;
begin
     try
    with MainForm.FDQueryInsertar,SQL do
    begin
      Clear;
      {Add('Update articulo set Nombre='+''''+EditNombre.Text+''''+',Linea='+''''+ComboBoxLinea.Selected.Text+''''+',Cantidad='+''''+EditCantidad.Text+''''+',Costo='+''''+EditCosto.Text+''''+',Publico='+''''+EditPrecio.Text+'''');
      Add('Mayoreo='+''''+EditPrecioMayoreo.Text+''''',Bolero='+''''+EditBolero.text+''''+',Especial='+''''+EditPrecioEspecial.text+''''+',P_Publico='+Prcje_Publico.ToString+',P_Mayoreo='+Prcje_Mayoreo.ToString+',P_Bolero='+Prcje_Bolero.ToString+',P_Especial='+Prcje_Especial.ToString+')');}
      Add('Update articulo set Nombre=:Nombre,Linea=:Linea,Cantidad=:Cantidad,Publico=:Publico,Mayoreo=:Mayoreo');
      Add('Bolero=:Bolero,Especial=:Especial,Iva:=Iva,Flete:=Flete');
      Add('Where rowid='+''''+Editid.Text+'''');
      Params[0].AsString:=EditNombre.Text;
      Params[1].AsString:=ComboBoxLinea.Selected.Text;
      Params[2].AsString:=EditCantidad.Text;
      Params[3].AsString:=EditPrecio.Text;
      Params[4].AsString:=EditPrecioMayoreo.Text;
      Params[5].AsString:=EditBolero.text;
      Params[6].AsString:=EditPrecioEspecial.text;
      if chkIva.IsChecked then Params[7].AsInteger:=1
      else Params[7].AsInteger:=0;
      Params[8].AsInteger:=EditFlete.text.ToInteger;
      MainForm.FDQueryInsertar.ExecSQL;
      Limpiar;
      ToastImagen('Artículo actualizado correctamente',false,MainForm.LogoVirma.Bitmap,$FFFFFF,$FF000000);
    end;
  except
    on E:exception do
      ShowMessage('No se pudo actualizar el artículo '+e.Message);
  end;
end;

procedure TfArticulos.BorrarArticulo;
begin
  try
    with MainForm.FDQueryInsertar,SQL do
    begin
      Clear;
      Add('Delete from articulo where rowid='+''''+Editid.Text+'''');
      MainForm.FDQueryInsertar.ExecSQL;
      Limpiar;
      ToastImagen('Articulo eliminado correctamente',false,MainForm.LogoVirma.Bitmap,$FFFFFF,$FF000000);
    end;
  except
    on E:exception do
    ShowMessage('No se pudo borrar el artículo '+e.Message);
  end;
end;

procedure TfArticulos.btnActualizarClick(Sender: TObject);
begin
   if editId.Text.Equals('') then ShowMessage('Ingrese el id del artículo a actualizar')
   else
   begin
       MessageDlg('¿Desea actualizar el articulo seleccionado? ', System.UITypes.TMsgDlgType.mtInformation,
      [System.UITypes.TMsgDlgBtn.mbOK,System.UITypes.TMsgDlgBtn.mbNo], 0, procedure(const AResult: System.UITypes.TModalResult)
      begin
        case AResult of
          mrOk:
          begin
            if EditNombre.Text.Equals('') or EditCosto.Text.Equals('') or EditPrecio.Text.Equals('') or Combo_Seleccionado.ToString.Equals('False')  then ShowMessage('Para ingresar un articulo se requiere al menos: nombre,cantidad,linea,costo y precio')
            else
            begin
              ObtenerPorcetaje;
              ActualizarArticulo;
            end;
          end;
          mrNo:
        end;
      end);
   end;
end;

procedure TfArticulos.btnBorrarClick(Sender: TObject);
begin
   if not Combo_Seleccionado then ShowMessage('Ingrese el id del artículo a eliminar')
   else
   begin
       MessageDlg('¿Desea eliminar el articulo seleccionado? ', System.UITypes.TMsgDlgType.mtInformation,
      [System.UITypes.TMsgDlgBtn.mbOK,System.UITypes.TMsgDlgBtn.mbNo], 0, procedure(const AResult: System.UITypes.TModalResult)
      begin
        case AResult of
          mrOk:
          begin
            BorrarArticulo;
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
  if EditNombre.Text.Equals('') or EditCosto.Text.Equals('') or EditPrecio.Text.Equals('') or Combo_Seleccionado.ToString.Equals('False')  then ShowMessage('Para ingresar un articulo se requiere al menos: nombre,cantidad,linea,costo y precio')
  else
  begin
    ObtenerPorcetaje;
    InsertarArticulo;
  end;
end;

procedure TfArticulos.BtnPorcentajeClick(Sender: TObject);
begin
  ObtenerPorcetaje;
  ShowMessage('Porcentaje ganancia publico:'+Prcje_Publico.ToString+'%'+sLineBreak
  +'Porcentaje ganancia Bolero:'+Prcje_Bolero.ToString+'%' +sLineBreak
  +'Porcentaje ganancia mayoreo:'+Prcje_Mayoreo.ToString+'%' +sLineBreak
  +'Porcentaje ganancia especial:'+Prcje_Especial.ToString+'%' +sLineBreak );
end;

procedure TfArticulos.BuscarArticulo;
begin
   try
    with MainForm.FDQueryBuscar,SQL do
    begin
      Active :=  False;
      Clear;
      Add('select Nombre,Cantidad,Costo,Publico,Bolero,Mayoreo,Especial,Iva,Flete from Articulo where rowid='+''''+Editid.Text+'''');
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

procedure TfArticulos.ComboBoxLineaChange(Sender: TObject);
begin
  Combo_Seleccionado:=True;
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

procedure TfArticulos.FormShow(Sender: TObject);
begin
  BuscarLinea;
end;

procedure TfArticulos.InsertarArticulo;
var
Nombre:string;
begin
    try
    with MainForm.FDQueryInsertar,SQL do
    begin
      Clear;
      Add('Select Nombre from articulo where Nombre='+''''+EditNombre.Text+'''');
      Close;
      Open;
      Nombre:=(Fields[0].AsString);
      if Nombre.Equals('') then
      begin
        Clear;
        Add('Insert into articulo (Nombre,Linea,Cantidad,Costo,Publico,Mayoreo,Bolero,Especial,IVA,Flete) ');
        Add('Values (:Nombre,:Linea,:Cantidad,:Costo,:Publico,:Mayoreo,:Bolero,:Especial,:IVA,:Flete)');
        Params[0].AsString:=EditNombre.Text;
        Params[1].AsString:=ComboBoxLinea.Selected.Text;
        Params[2].AsString:=EditCantidad.Text;
        Params[3].AsString:=EditPrecio.Text;
        Params[4].AsString:=EditPrecioMayoreo.Text;
        Params[5].AsString:=EditBolero.text;
        Params[6].AsString:=EditPrecioEspecial.text;
        if chkIva.IsChecked then Params[7].AsInteger:=1
        else Params[7].AsInteger:=0;
        Params[8].AsInteger:=EditFlete.text.ToInteger;
        MainForm.FDQueryInsertar.ExecSQL;
        ToastImagen('Artículo insertado exitosamente',false,MainForm.LogoVirma.Bitmap,$FFFFFF,$FF000000);
      end
      else
      begin
        MessageDlg('Ya existe un articulo con el mismo nombre ¿Desea insertarlo? ', System.UITypes.TMsgDlgType.mtInformation,
        [System.UITypes.TMsgDlgBtn.mbOK,System.UITypes.TMsgDlgBtn.mbNo], 0, procedure(const AResult: System.UITypes.TModalResult)
        begin
          case AResult of
            mrOk:
            begin
              Clear;
              Add('Insert into articulo (Nombre,Linea,Cantidad,Costo,Publico,Mayoreo,Bolero,Especial,IVA,Flete) ');
              Add('Values (:Nombre,:Linea,:Cantidad,:Costo,:Publico,:Mayoreo,:Bolero,:Especial,:IVA,:Flete)');
              Params[0].AsString:=EditNombre.Text;
              Params[1].AsString:=ComboBoxLinea.Selected.Text;
              Params[2].AsString:=EditCantidad.Text;
              Params[3].AsString:=EditPrecio.Text;
              Params[4].AsString:=EditPrecioMayoreo.Text;
              Params[5].AsString:=EditBolero.text;
              Params[6].AsString:=EditPrecioEspecial.text;
              if chkIva.IsChecked then Params[7].AsInteger:=1
              else Params[7].AsInteger:=0;
              Params[8].AsInteger:=EditFlete.text.ToInteger;
              MainForm.FDQueryInsertar.ExecSQL;
              ToastImagen('Artículo insertado exitosamente',false,MainForm.LogoVirma.Bitmap,$FFFFFF,$FF000000);
            end;
            mrNo:
          end;
        end);
      end;
    end;
  except
    on E:exception do
      ShowMessage('No se pudo insertar el artículo '+e.Message);
  end;
end;

procedure TfArticulos.Limpiar;
begin
  editId.Text:='';
  EditNombre.Text:='';
  EditCantidad.Text:='';
  EditCosto.Text:='';
  EditPrecio.Text:='';
  EditBolero.Text:='';
  EditPrecioMayoreo.Text:='';
  EditPrecioEspecial.Text:='';
  EditFlete.Text:='';
  chkIva.IsChecked:=False;
end;

procedure TfArticulos.ObtenerPorcetaje;
var
  Costo,Precio,Bolero,Mayoreo,Especial : string;
begin
  Costo  := StringReplace(EditCosto.Text, '.',',',
    [rfReplaceAll, rfIgnoreCase]);
  Precio  := StringReplace(EditPrecio.Text, '.',',',
    [rfReplaceAll, rfIgnoreCase]);
  Bolero  := StringReplace(EditBolero.Text, '.',',',
    [rfReplaceAll, rfIgnoreCase]);
  Mayoreo  := StringReplace(EditPrecioMayoreo.Text, '.',',',
    [rfReplaceAll, rfIgnoreCase]);
  Especial  := StringReplace(EditPrecioEspecial.Text, '.',',',
    [rfReplaceAll, rfIgnoreCase]);
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

end.
