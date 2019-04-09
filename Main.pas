unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.Gestures, System.Actions, FMX.ActnList, System.Rtti, FMX.Grid.Style,
  FMX.ScrollBox, FMX.Grid, FMX.Edit, FMX.Layouts, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.FMXUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FMX.ListBox, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.DBScope, Data.Bind.Grid, FMX.DateTimeCtrls, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  FMX.Objects,System.IOUtils;

type
  TMainForm = class(TForm)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    GestureManager1: TGestureManager;
    ActionList1: TActionList;
    NextTabAction1: TNextTabAction;
    PreviousTabAction1: TPreviousTabAction;
    LayoutIngresar: TLayout;
    EditFolio: TEdit;
    EditPrecio: TEdit;
    editCantidad: TEdit;
    btnIngresar: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Cantidad: TLabel;
    StringGridTrabajos: TStringGrid;
    Layout1: TLayout;
    EditDesc: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    btnLinea: TSpeedButton;
    btnReparacion: TSpeedButton;
    btnArticulos: TSpeedButton;
    Conexion: TFDConnection;
    FDQueryBuscar: TFDQuery;
    FDQueryInsertar: TFDQuery;
    FDQueryActualizar: TFDQuery;
    FdMemArt: TFDMemTable;
    FdMemArtID: TIntegerField;
    FdMemArtNombre: TStringField;
    FdMemArtUnidadMedida: TStringField;
    ComboBoxLinea: TComboBox;
    BindingsList1: TBindingsList;
    BindSourceDB1: TBindSourceDB;
    StringGrid2: TStringGrid;
    LinkGridToDataSourceBindSourceDB12: TLinkGridToDataSource;
    FdMemArtCosto: TStringField;
    FdMemArtPrecio: TStringField;
    FdMemArtMayoreo: TStringField;
    FdMemArtBolero: TStringField;
    FdMemArtEspecial: TStringField;
    FdMemArtP_Precio: TStringField;
    FdMemArtP_Mayoreo: TStringField;
    FdMemArtP_Bolero: TStringField;
    FdMemArtP_Especial: TStringField;
    TimerPresentacion: TTimer;
    Layout2: TLayout;
    Label5: TLabel;
    FechaTrabajos: TDateEdit;
    ComboEmpleado: TComboBox;
    FechaLista: TDateEdit;
    StringGridLista: TStringGrid;
    ComboEmpleadosLista: TComboBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListView1: TListView;
    FDQuery1: TFDQuery;
    FDMemFilaTrabajo: TFDMemTable;
    FDMemTrabajos: TFDMemTable;
    FDMemTrabajosDescripcion: TStringField;
    BindSourceDB3: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB3: TLinkGridToDataSource;
    FDMemFilaTrabajoTrabajo: TStringField;
    FDMemFilaTrabajoCantidad: TIntegerField;
    BindSourceDB4: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB4: TLinkGridToDataSource;
    logoVirma: TImage;
    FDMemTrabajosPrecio: TStringField;
    FDMemTrabajosFolio: TIntegerField;
    FDMemTrabajosCantidad: TIntegerField;
    LinkListControlToField1: TLinkListControlToField;
    FDMemLista: TFDMemTable;
    FDMemTable1Trabajo: TStringField;
    FDMemTable1Informacion: TStringField;
    FDMemTable1Tiempo: TStringField;
    BindSourceDB2: TBindSourceDB;
    Cliente: TLabel;
    Empleado: TLabel;
    FondoOscuro: TRectangle;
    LayoutMensaje: TLayout;
    Layout8: TLayout;
    mensaje: TPanel;
    lytBotones: TLayout;
    btnAccept: TImage;
    btnBack: TImage;
    edtpass: TEdit;
    btnChangePass: TSpeedButton;
    LayoutChange: TLayout;
    Layout4: TLayout;
    MensajeCh: TPanel;
    Layout5: TLayout;
    btnch: TImage;
    btnRegresar: TImage;
    edtPass1: TEdit;
    edtNewPass: TEdit;
    Button1: TButton;
    procedure GestureDone(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure ConexionBeforeConnect(Sender: TObject);
    procedure ConexionAfterConnect(Sender: TObject);
    procedure btnLineaClick(Sender: TObject);
    procedure btnArticulosClick(Sender: TObject);
    procedure LlenarTabla;
    procedure LlenarLista;
    procedure ObtenerLineas;
    procedure ObtenerEmpleadosTrabajo;
    //Lista
    procedure ObtenerLista;
    procedure ObtenerEmpleadosLista;
    procedure InsertarTrabajo;
    procedure InsertarLista;
    procedure SumarLista;
    procedure RestarLista;
    procedure BuscarLista;
    procedure DiaInicioEntrega;
    Function Limite:Boolean;
    procedure ComboBoxLineaChange(Sender: TObject);
    //Otro
    procedure TimerPresentacionTimer(Sender: TObject);
    procedure StringGrid2CellClick(const Column: TColumn; const Row: Integer);
    procedure SpeedButton2Click(Sender: TObject);
    procedure ComboEmpleadoChange(Sender: TObject);
    procedure btnIngresarClick(Sender: TObject);
    procedure ObtenerFilaTrabajos;
    procedure ObtenerTrabajos;
    procedure ObtenerTipoTrabajo;
    procedure DateEdit2Change(Sender: TObject);
    procedure ComboEmpleadosListaChange(Sender: TObject);
    procedure FechaTrabajosChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FechaListaChange(Sender: TObject);
    procedure btnReparacionClick(Sender: TObject);
    function Contrase�aCorrecta:Boolean;
    function Contrase�aCorrecta2:Boolean;
    procedure btnBackClick(Sender: TObject);
    procedure btnAcceptClick(Sender: TObject);
    procedure btnchClick(Sender: TObject);
    procedure btnChangePassClick(Sender: TObject);
    procedure InsertarPass;
    procedure ListView1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
   Hoy :TDateTime;
   ComboEmpSelected:Boolean;
   ComboEmpListaSelected:Boolean;
   CantidadTrabajo:Integer;
   CantidadLimite:Integer;
   Tiempo:Integer;
    { Private declarations }
  public
  IDROW_SELECCIONADO:string;
  Linea,Art,Repa:Boolean;
  S:String;//La cantidad que regresa
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  Linea, Articulos, Presentacion, Funciones_Android, Trabajo;

{$R *.fmx}
{$R *.LgXhdpiTb.fmx ANDROID}

procedure TMainForm.btnAcceptClick(Sender: TObject);
begin
  if Contrase�aCorrecta then
  begin
    if Art then
    begin
      Farticulos:=TFarticulos.Create(nil);
      try
        Farticulos.Show;
        mensaje.Visible:=false;
        FondoOscuro.Visible:=False;
        OcultarTeclado;
      finally
        Farticulos.Free;
      end;
    end
    else if Linea then
    begin
      Lineas:=TLineas.Create(nil);
      try
        Lineas.Show;
        mensaje.Visible:=false;
        FondoOscuro.Visible:=False;
        OcultarTeclado;
      finally
        Lineas.Free;
      end;
    end
    else if Repa then
    begin
      Reparacion:=TReparacion.Create(nil);
      try
        Reparacion.Show;
        mensaje.Visible:=false;
        FondoOscuro.Visible:=False;
        OcultarTeclado;
      finally
        Reparacion.Free;
      end;
    end
  end
  else ShowMessage('Contrase�a incorrecta');
end;

procedure TMainForm.btnArticulosClick(Sender: TObject);
begin
  Art:=True;
  Repa:=False;
  Linea:=False;
  FondoOscuro.Visible:=True;
  Mensaje.Visible:=True;
  Edtpass.SetFocus;
end;

procedure TMainForm.btnBackClick(Sender: TObject);
begin
   mensajech.Visible:=false;
   FondoOscuro.Visible:=False;
   OcultarTeclado;
end;

procedure TMainForm.btnChangePassClick(Sender: TObject);
begin
  FondoOscuro.Visible:=True;
  Mensajech.Visible:=True;
  Edtpass1.SetFocus;
end;

procedure TMainForm.btnchClick(Sender: TObject);
begin
  if Contrase�aCorrecta2 then
  begin
  try
    with MainForm.FDQueryInsertar,SQL do
    begin
      Clear;
      Add('Update Seguridad set Pass=:Pass');
      Params[0].AsString:=edtNewPass.Text;
      MainForm.FDQueryInsertar.ExecSQL;
    end;
    ToastImagen('Contrase�a cambiada satisfactoriamente',false,MainForm.LogoVirma.Bitmap,$FFFFFF,$FF000000);
    mensajech.Visible:=false;
    FondoOscuro.Visible:=False;
    OcultarTeclado;
  except
    on E:exception do
    ShowMessage('No se pudo actualizar la contrase�a '+e.Message);
  end;
  end
  else ShowMessage('La contrase�a original es incorrecta');
end;

procedure TMainForm.btnReparacionClick(Sender: TObject);
begin
  Art:=False;
  Repa:=True;
  Linea:=False;
  FondoOscuro.Visible:=True;
  Mensaje.Visible:=True;
  Edtpass.SetFocus;
end;

procedure TMainForm.btnIngresarClick(Sender: TObject);
begin
  if ComboEmpSelected then
  begin
    if (EditFolio.Text.Equals('') and EditDesc.Text.Equals('')) or EditPrecio.Text.Equals('') or editCantidad.Text.Equals('') then
    ShowMessage('Debe ingresar un folio o descripcion del trabajo,con su respectivo precio y cantidad') else
    InsertarTrabajo;
    ObtenerTrabajos;
  end
  else ShowMessage('Debe seleccionar un empleado');
end;

procedure TMainForm.btnLineaClick(Sender: TObject);
begin
  Art:=False;
  Repa:=False;
  Linea:=True;
  FondoOscuro.Visible:=True;
  Mensaje.Visible:=True;
  Edtpass.SetFocus;
end;

procedure TMainForm.BuscarLista;
var
Fecha:TDateTime;
begin
   try
    with FDQueryBuscar,SQL do
    begin
      Fecha:=strtodate(Fechalista.Data.ToString);
      Active:=False;
      Clear;
      Add('Select Cantidad from Lista where Empleado=:Empleado and Fecha=:Fecha and Trabajo=:Trabajo');
      Params[0].AsString:=ComboEmpleadosLista.Selected.Text;
      Params[1].AsDate:=FechaLista.Date;
      Params[2].AsString:=TListViewItem(ListView1.Selected).Text;
      Close;
      Open;
      S:=Fields[0].AsString;
    end;
    except
    on E:exception do
    showmessage(e.Message);
  end;
end;



procedure TMainForm.Button1Click(Sender: TObject);
begin
  ObtenerTipoTrabajo;
end;

procedure TMainForm.ComboBoxLineaChange(Sender: TObject);
begin
   LlenarTabla;
end;
 procedure TMainForm.ComboEmpleadoChange(Sender: TObject);
begin
   ComboEmpSelected:=True;
   ObtenerTrabajos;
end;

procedure TMainForm.ComboEmpleadosListaChange(Sender: TObject);
begin
  ComboEmpListaSelected:=True;
  ObtenerLista;
end;

//Crea las tablas en la inicializacion
procedure TMainForm.ConexionAfterConnect(Sender: TObject);
begin
  Conexion.ExecSQL('CREATE TABLE IF NOT EXISTS ARTICULO(NOMBRE TEXT NOT NULL,LINEA TEXT NOT NULL,CANTIDAD TEXT NOT NULL,COSTO TEXT,PUBLICO TEXT,MAYOREO TEXT,BOLERO TEXT,ESPECIAL TEXT,P_PUBLICO TEXT,P_MAYOREO TEXT,P_BOLERO TEXT, P_ESPECIAL TEXT)');
  Conexion.ExecSQL('CREATE TABLE IF NOT EXISTS Linea(Nombre TEXT NOT NULL)');
  Conexion.ExecSQL('CREATE TABLE IF NOT EXISTS Empleado(Nombre TEXT,Ganancia TEXT)');
  Conexion.ExecSQL('CREATE TABLE IF NOT EXISTS Reparacion(Empleado TEXT,Folio INTEGER,Precio TEXT,Cantidad INTEGER,Descripcion TEXT,Fecha TEXT,Fecha_Hora TEXT)');
  Conexion.ExecSQL('CREATE TABLE IF NOT EXISTS Trabajo(Trabajo TEXT,Informacion TEXT,Tiempo INTEGER,Limite Integer)');
  Conexion.ExecSQL('CREATE TABLE IF NOT EXISTS Lista(Trabajo TEXT,Empleado TEXT,Cantidad TEXT,Fecha DATE)');
  Conexion.ExecSQL('CREATE TABLE IF NOT EXISTS Seguridad(Pass TEXT)');
 end;
//Antes de conectar identifica la base de datos
procedure TMainForm.ConexionBeforeConnect(Sender: TObject);
begin
  {$IF DEFINED(iOS) or DEFINED(ANDROID)}
  Conexion.Params.Values['Database'] :=
  TPath.Combine(TPath.GetDocumentsPath, 'Virmariza.s3db');
  {$ENDIF}
end;

function TMainForm.Contrase�aCorrecta: Boolean;
begin
   try
    with FDQueryBuscar,SQL do
    begin
      Active :=  False;
      Clear;
      Add('SELECT Pass ');
      Add('FROM Seguridad ');
      Close;
      Open;
      if Fields[0].AsString.Equals(edtpass.Text) then result:=true else result:=false;
    end;
    except
    on E:exception do
    showmessage(e.Message);
  end;
end;

function TMainForm.Contrase�aCorrecta2: Boolean;
begin
    try
    with FDQueryBuscar,SQL do
    begin
      Active :=  False;
      Clear;
      Add('SELECT Pass ');
      Add('FROM Seguridad ');
      Close;
      Open;
      if Fields[0].AsString.Equals(edtpass1.Text) then result:=true else result:=false;
      ShowMessage(Fields[0].AsString);
    end;
    except
    on E:exception do
    showmessage(e.Message);
  end;
end;

procedure TMainForm.DateEdit2Change(Sender: TObject);
begin
  ObtenerTrabajos;
end;


procedure TMainForm.DiaInicioEntrega;
begin
  //Muestra el dia de inicio para el trabajo
  if not Limite then
  begin
    try
      with FDQueryBuscar,SQL do
      begin
        Active :=  False;
        Clear;
       // Add('SELECT date (Fecha,''+'+Tiempo.ToString+'day'') ');
        Add('SELECT date (Fecha,'+''''+'+'+Tiempo.ToString+'day'+''''+')');
        Add('FROM lista  where Empleado=:Empleado and Trabajo=:Trabajo ');
        Add(' ORDER by Fecha desc LIMIT 1');
        //Params[0].AsInteger:=(Tiempo);
        Params[0].AsString:=ComboEmpleadosLista.Selected.Text;
        Params[1].AsString:=TListViewItem(ListView1.Selected).Text;
        Close;
        Open;
        Cliente.Text:=Fields[0].AsString;
        Showmessage('Primero'+Fields[0].AsString  );
        Clear;
        Add('SELECT fecha');
        Add('FROM lista  where Empleado=:Empleado and Trabajo=:Trabajo ');
        Add(' ORDER by Fecha desc LIMIT 1');
        Params[0].AsString:=ComboEmpleadosLista.Selected.Text;;
        Params[1].AsString:=TListViewItem(ListView1.Selected).Text;
        Close;
        Open;
        Empleado.Text:=Fields[0].AsString ;
        Showmessage('2'+Fields[0].AsString);
      end
      except
      on E:exception do
      showmessage(e.Message);
    end
  end
  else
  begin
     try
      with FDQueryBuscar,SQL do
      begin
        Active :=  False;
        Clear;
        Add('SELECT date (Fecha,:Dias) ');
        Add('FROM lista  where Empleado=:Empleado and Trabajo=:Trabajo ');
        Add(' ORDER by Fecha desc LIMIT 1');
        Params[0].AsString:=('+'+(Tiempo +1).ToString+' day');
        Params[1].AsString:=ComboEmpleadosLista.Selected.Text;
        Params[2].AsString:=TListViewItem(ListView1.Selected).Text;
        Close;
        Open;
        Cliente.Text:=Fields[0].AsString;
        Clear;
        Add('SELECT fecha (Fecha,+1 day)');
        Add('FROM lista  where Empleado=:Empleado and Trabajo=:Trabajo ');
        Add(' ORDER by Fecha desc LIMIT 1');
        Params[0].AsString:=ComboEmpleadosLista.Selected.Text;
        Params[1].AsString:=TListViewItem(ListView1.Selected).Text;
        Close;
        Open;
        Empleado.Text:=Fields[0].AsString
      end
      except
      on E:exception do
      showmessage(e.Message);
    end
  end;
end;

procedure TMainForm.FechaListaChange(Sender: TObject);
begin
   if ComboEmpListaSelected then  ObtenerLista;
end;

procedure TMainForm.FechaTrabajosChange(Sender: TObject);
begin
  if ComboEmpSelected then   ObtenerTrabajos;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
Fecha:string;
begin
  Hoy:=Now;
  { This defines the default active tab at runtime }
  TabControl1.ActiveTab := TabItem1;
  //Establece la fecha de hoy en los buscadores de fecha
  Fecha:=(formatdatetime('d/m/y', Hoy));
  FechaLista.Date:=Hoy;
  FechaTrabajos.Date:=Hoy;
  //Obtiene todos los datos nesesarios
  ObtenerLineas;
  ObtenerEmpleadosLista;
  ObtenerEmpleadosTrabajo;
  ObtenerTipoTrabajo;
  InsertarPass;
end;

procedure TMainForm.GestureDone(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  case EventInfo.GestureID of
    sgiLeft:
      begin
        if TabControl1.ActiveTab <> TabControl1.Tabs[TabControl1.TabCount - 1] then
          TabControl1.ActiveTab := TabControl1.Tabs[TabControl1.TabIndex + 1];
        Handled := True;
      end;

    sgiRight:
      begin
        if TabControl1.ActiveTab <> TabControl1.Tabs[0] then
          TabControl1.ActiveTab := TabControl1.Tabs[TabControl1.TabIndex - 1];
        Handled := True;
      end;
  end;
end;
//Pendiente
Procedure TMainForm.InsertarLista;
begin
   try
    with FDQueryInsertar,SQL do
    begin
      Active :=  False;
      Clear;
      Add('Insert into Lista(Trabajo,Empleado,Cantidad,Fecha) values (:Trabajo,:Empleado,:Cantidad,:Fecha)');
      Params[0].AsString:=TListViewItem(ListView1.Selected).Text;
      Params[1].AsString:=ComboEmpleadosLista.Selected.Text;
      Params[2].AsString:='1';
      Params[3].AsDate:=FechaLista.Date;
      FDQueryInsertar.ExecSQL;
    end;
   // Result:=True;
    except
    on E:Exception do
    begin
      showmessage(E.Message);
     // Result:=False;
    end;
  end;
end;

procedure TMainForm.InsertarPass;
begin
  try
    FDMemLista.Close;
    FDMemLista.Open;
    with FDQueryBuscar,SQL do
    begin
      Active :=  False;
      Clear;
      Add('Select Pass from Seguridad');
      close;
      Open;
      if Fields[0].AsString.Equals('') then
      begin
        try
           with FDQueryInsertar,SQL do
           begin
              Clear;
              Add('Insert into Seguridad  ');
              Add('(Pass)');
              Add(' values (:Pass)');
              Params[0].AsString:='973';
              FDQueryInsertar.ExecSQL
           end
        except
          on E:Exception do
          showmessage(E.Message);
        end;
      end;
    end;
    except
    on E:Exception do
    showmessage(E.Message);
  end;
end;

procedure TMainForm.InsertarTrabajo;
var
Folio:Integer;
Fecha,Fecha_Hora:string;
Empleado:string;
begin
      try
    with FDQueryInsertar,SQL do
    begin
      Clear;
      Add('Select Folio,Fecha,Empleado from Reparacion where Folio='+''''+EditFolio.Text+'''');
      Close;
      Open;
      Folio:=(Fields[0].AsInteger);
      Fecha:=(Fields[1].AsString);
      Empleado:=(Fields[2].AsString);
      if Folio=0 then
      begin
        Hoy:=Now;
        Fecha:=(formatdatetime('d/m/y', Hoy));
        Fecha_Hora:=((formatdatetime('d/m/y', Hoy))+(FormatDATETime(' hh:mm', Hoy)));
        Clear;
        Add('Insert into Reparacion  ');
        Add('(Cantidad,Descripcion,Empleado,Fecha,Fecha_Hora,Folio,Precio)');
        Add(' values (:Cantidad,:Descripcion,:Empleado,:Fecha,:Fecha_Hora,:Folio,:Precio)');
        Params[0].AsString:=editCantidad.Text;
        Params[1].AsString:=editDesc.Text;
        Params[2].AsString:=ComboEmpleado.Selected.Text;
        Params[3].AsString:=Fecha;
        Params[4].AsString:=Fecha_Hora;
        Params[5].AsString:=EditFolio.Text;
        Params[6].AsString:=EditPrecio.Text;
        FDQueryInsertar.ExecSQL
      end
      else
      begin
        MessageDlg('Ya existe un registro con el mismo folio del empleado '+Empleado+' ingresado  el '+Fecha+' �Desea insertarlo igualmente? ', System.UITypes.TMsgDlgType.mtInformation,
        [System.UITypes.TMsgDlgBtn.mbOK,System.UITypes.TMsgDlgBtn.mbNo], 0, procedure(const AResult: System.UITypes.TModalResult)
        begin
          case AResult of
            mrOk:
            begin
              Hoy:=Now;
              Fecha:=(formatdatetime('d/m/y', Hoy));
              Fecha_Hora:=((formatdatetime('d/m/y', Hoy))+(FormatDATETime(' hh:mm', Hoy)));
              Clear;
              Add('Insert into Reparacion  ');
              Add('(Cantidad,Descripcion,Empleado,Fecha,Fecha_Hora,Folio,Precio)');
              Add(' values (:Cantidad,:Descripcion,:Empleado,:Fecha,:Fecha_Hora,:Folio,:Precio)');
              Params[0].AsString:=editCantidad.Text;
              Params[1].AsString:=editDesc.Text;
              Params[2].AsString:=ComboEmpleado.Selected.Text;
              Params[3].AsString:=Fecha;
              Params[4].AsString:=Fecha_Hora;
              Params[5].AsString:=EditFolio.Text;
              Params[6].AsString:=EditPrecio.Text;
              FDQueryInsertar.ExecSQL
            end;
            mrNo:
          end;
        end);
      end;
    end;
  except
    on E:exception do
      ShowMessage('No se pudo insertar el art�culo '+e.Message);
  end;
end;
//Llena la lista de trabajos
function TMainForm.Limite: Boolean;
var
UltimaFecha:String;
begin
   try
    with FDQueryBuscar,SQL do
    begin
      {Busca la ultima fecha que tiene registros de ese usuario
      y de ese trabajo}
      Active :=  False;
      Clear;
      Add('SELECT Limite,Tiempo ');
      Add('FROM Trabajo  where  Trabajo=:Trabajo ');
      Params[0].AsString:=TListViewItem(ListView1.Selected).Text;
      close;
      Open;
      CantidadLimite:=Fields[0].AsInteger;
      Tiempo:=Fields[1].AsInteger;
      Clear;
      Add('SELECT fecha  ');
      Add('FROM lista  where Empleado=:Empleado and Trabajo=:Trabajo ');
      Add(' ORDER by Fecha desc LIMIT 1');
      Params[0].AsString:=ComboEmpleadosLista.Selected.Text;
      Params[1].AsString:=TListViewItem(ListView1.Selected).Text;
      close;
      Open;
      UltimaFecha:=Fields[0].AsString;
      Clear;
      Add('SELECT count (*)');
      Add('FROM lista ');
      Add('WHERE empleado=:Empleado and Trabajo=:Trabajo  and Fecha=:Fecha');
      Params[0].AsString:=ComboEmpleadosLista.Selected.Text;
      Params[1].AsString:=TListViewItem(ListView1.Selected).Text;
      Params[2].AsString:=UltimaFecha;
      close;
      Open;
      if Fields[0].asInteger >= CantidadLimite then Result:=True else Result:=False;
      //Cantidad:=Fields[0].AsInteger;
    end;
    except
    on E:Exception do
    showmessage(E.Message);
  end;
end;

Procedure TMainForm.ListView1Change(Sender: TObject);
begin
  DiaInicioEntrega;
end;

procedure TMainForm.LlenarLista;
begin
  try
    FDMemLista.Close;
    FDMemLista.Open;
    with FDQueryBuscar,SQL do
    begin
      Active :=  False;
      Clear;
      Add('Select Nombre,Informacion,Tiempo from Trabajo');
      close;
      Open;
      while not Eof do
      begin
        FDMemLista.Append;
        (FDMemLista.FieldByName('Nombre') as TIntegerField).AsInteger:= Fields[0].AsInteger;
        (FDMemLista.FieldByName('Informacion') as TStringField).AsString:= Fields[1].AsString;
        (FDMemLista.FieldByName('Tiempo') as TStringField).AsString:= Fields[2].AsString;
         FDMemLista.Post;
        Next;
      end;
    end;
    except
    on E:Exception do
    showmessage(E.Message);
  end;
end;

procedure TMainForm.LlenarTabla;
begin
 try
    FDMemART.Close;
    FDMemArT.Open;
    with FDQueryBuscar,SQL do
    begin
      Active :=  False;
      Clear;
      Add('Select rowid,Nombre,Cantidad,Costo,Publico,Mayoreo,Bolero,Especial,P_Publico,P_Mayoreo,P_Bolero,P_Especial from Articulo where Linea='+''''+ComboBoxLinea.Selected.Text+'''');
      close;
      Open;
      while not Eof do
      begin
        FDMemART.Append;
        (FDMemART.FieldByName('ID') as TIntegerField).AsInteger:= Fields[0].AsInteger;
        (FDMemART.FieldByName('Nombre') as TStringField).AsString:= Fields[1].AsString;
        (FDMemART.FieldByName('Unidad Medida') as TStringField).AsString:= Fields[2].AsString;
        (FDMemART.FieldByName('Costo') as TStringField).AsString:= Fields[3].AsString;
        (FDMemART.FieldByName('Precio') as TStringField).AsString:= Fields[4].AsString;
        (FDMemART.FieldByName('Mayoreo') as TStringField).AsString:= Fields[5].AsString;
        (FDMemART.FieldByName('Bolero') as TStringField).AsString:= Fields[6].AsString;
        (FDMemART.FieldByName('Especial') as TStringField).AsString:= Fields[7].AsString;
        (FDMemART.FieldByName('P_Precio') as TStringField).AsString:= Fields[8].AsString;
        (FDMemART.FieldByName('P_Mayoreo') as TStringField).AsString:= Fields[9].AsString;
        (FDMemART.FieldByName('P_Bolero') as TStringField).AsString:= Fields[10].AsString;
        (FDMemART.FieldByName('P_Especial') as TStringField).AsString:= Fields[11].AsString;
        FDMemART.Post;
        Next;
      end;
    end;
    except
    on E:Exception do
    showmessage(E.Message);
  end;
end;
//Obtiene las lineas y las agrega en el combobox
procedure TMainForm.ObtenerEmpleadosLista;
begin
   try
    with MainForm.FDQueryBuscar,SQL do
    begin
      ComboEmpleado.Clear;
      Active :=  False;
      Clear;
      Add('Select Nombre From Empleado');
      Close;
      Open;
      while not eof do
      begin
        try
          begin
            ComboEmpleadosLista.Items.Add(Fields[0].AsString);
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

procedure TMainForm.ObtenerEmpleadosTrabajo;
begin
   try
    with MainForm.FDQueryBuscar,SQL do
    begin
      ComboEmpleado.Clear;
      Active :=  False;
      Clear;
      Add('Select Nombre From Empleado');
      Close;
      Open;
      while not eof do
      begin
        try
          begin
            ComboEmpleado.Items.Add(Fields[0].AsString);
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

procedure TMainForm.ObtenerFilaTrabajos;
begin
     try
    with FDQueryBuscar,SQL do
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

procedure TMainForm.ObtenerLineas;
begin
    try
    with FDQueryBuscar,SQL do
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
procedure TMainForm.ObtenerLista;
var
Fecha:TDateTime;
begin
  try
    Fecha:=strtodate(Fechalista.Data.ToString);
    FDMemFilaTrabajo.Close;
    FDMemFilaTrabajo.Open;
    with FDQueryBuscar,SQL do
    begin
      Active :=  False;
      Clear;
      Add('Select Trabajo,Cantidad,Fecha from Lista where Empleado=:Empleado and Fecha=:Fecha');
      Params[0].AsString:=ComboEmpleadosLista.Selected.Text;
      Params[1].AsDate:=FechaLista.Date;
      close;
      Open;
      while not Eof do
      begin
        FDMemFilaTrabajo.Append;
        (FDMemFilaTrabajo.FieldByName('Trabajo') as TStringField).AsString:= Fields[0].AsString;
        (FDMemFilaTrabajo.FieldByName('Cantidad') as TIntegerField).AsInteger:= Fields[1].AsInteger;
        FDMemFilaTrabajo.Post;
        Next;
      end;

    end;
    except
    on E:Exception do
    showmessage(E.Message);
  end;
end;

procedure TMainForm.ObtenerTipoTrabajo;
begin
  try
    FDMemLista.Close;
    FDMemLista.Open;
    with FDQueryBuscar,SQL do
    begin
      Active :=  False;
      Clear;
      Add('Select Trabajo,Informacion from Trabajo ');
      close;
      Open;
      while not Eof do
      begin
        FDMemLista.Append;
        (FDMemLista.FieldByName('Trabajo') as TStringField).AsString:= Fields[0].AsString;
        (FDMemLista.FieldByName('Informacion') as TStringField).AsString:= Fields[1].AsString;
         FDMemLista.Post;
        Next;
      end;
    end;
    except
    on E:Exception do
    showmessage(E.Message);
  end;
end;

procedure TMainForm.ObtenerTrabajos;
begin
  try
    FDMemTrabajos.Close;
    FDMemTrabajos.Open;
    with FDQueryBuscar,SQL do
    begin
      Active :=  False;
      Clear;
      Add('Select Folio,Precio,Descripcion,Cantidad from Reparacion where Empleado=:Empleado and Fecha=:Fecha');
      Params[0].AsString:=ComboEmpleado.Selected.Text;
      Params[1].AsDate:=FechaTrabajos.Date;
      close;
      Open;
      while not Eof do
      begin
        FDMemTrabajos.Append;
        (FDMemTrabajos.FieldByName('Folio') as TIntegerField).AsInteger:= Fields[0].AsInteger;
        (FDMemTrabajos.FieldByName('Precio') as TStringField).AsString:= Fields[1].AsString;
        (FDMemTrabajos.FieldByName('Descripcion') as TStringField).AsString:= Fields[2].AsString;
        (FDMemTrabajos.FieldByName('Cantidad') as TIntegerField).AsInteger:= Fields[3].AsInteger;
        FDMemTrabajos.Post;
        Next;
      end;
    end;
    except
    on E:Exception do
    showmessage(E.Message);
  end;
end;

procedure TMainForm.RestarLista;
begin
    try
    FDMemART.Close;
    FDMemArT.Open;
    with FDQueryInsertar,SQL do
    begin
      Active :=  False;
      Clear;
      Add('Update Lista set Cantidad=Cantidad -1 where Empleado=:Empleado and Fecha=:Fecha and Trabajo=:Trabajo ');
      Params[0].AsString:=ComboEmpleadosLista.Selected.Text;
      Params[1].AsDate:=FechaLista.Date;
      Params[2].AsString:=TListViewItem(ListView1.Selected).Text;
      FDQueryInsertar.ExecSQL
    end;
    except
    on E:Exception do
    begin
      showmessage(E.Message);
    end;
  end;
end;

//Acciones realizadas al momento de oprimir una celda en el grid
procedure TMainForm.SpeedButton1Click(Sender: TObject);
begin
 if ComboEmpListaSelected then
 begin

  BuscarLista;
  if S.Equals('') then InsertarLista
  else SumarLista;
  ObtenerLista;
 end
 else ShowMessage('Seleccione un empleado');
end;

procedure TMainForm.SpeedButton2Click(Sender: TObject);
begin
  if ComboEmpListaSelected then
 begin
  BuscarLista;
  if S.Equals('') then ShowMessage('No existe registro de este trabajo aun')
  else if S.Equals('0') then ShowMessage('La cantidad de trabajo ya es cero')
  else RestarLista;
  ObtenerLista;
 end
 else ShowMessage('Seleccione un empleado');

end;

procedure TMainForm.StringGrid2CellClick(const Column: TColumn;
  const Row: Integer);
begin
  IDROW_SELECCIONADO:=FDMemART.FieldByName('ID').AsString;
end;
procedure TMainForm.SumarLista;
begin
    try
    with FDQueryInsertar,SQL do
    begin
      Active :=  False;
      Clear;
      Add('Update Lista set Cantidad=Cantidad +1 where Empleado=:Empleado and Fecha=:Fecha and Trabajo=:Trabajo');
      Params[0].AsString:=ComboEmpleadosLista.Selected.Text;
      Params[1].AsDate:=FechaLista.Date;
      Params[2].AsString:=TListViewItem(ListView1.Selected).Text;
      FDQueryInsertar.ExecSQL
    end;
    except
    on E:Exception do
    begin
      showmessage(E.Message);
    end;
  end;
end;

//Abre la forma de la presentacion de la empresa
procedure TMainForm.TimerPresentacionTimer(Sender: TObject);
begin
  fPresentacion:=TfPresentacion.Create(nil);
  try
    fPresentacion.Show;
  finally
    fPresentacion.Free;
  end;
end;

end.



