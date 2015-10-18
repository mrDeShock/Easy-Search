unit FES_U2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Forms, XPMan,// стандартные модули
  Dialogs, // модуль для диалогов (showmessage)
  Controls, StdCtrls, // модули для TLabel, TButton, TEdit
  DB, ADODB; // модули для подключения к БД

type
  TForm2 = class(TForm)
    EFileName: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ADOConnection1: TADOConnection;
    Label6: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var
  a:array [0..127] of byte; // массив байтов для чтения из файла
  s_hex:string; // строка для преобразования из массива ^^^ в шестнадцатеричный вид для запроса к БД
  i:Integer; // переменная для цикла
  pth:string;
begin
pth := ExtractFileDir(Application.ExeName);
if pth[Length(pth)] <> '\' then
pth := pth + '\';
try
ADOConnection1.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+pth+'extension.mdb;Persist Security Info=False';
ADOConnection1.Connected := True; // подключаемся к БД
except
// конструкция try ... except ... end для обработки ошибок
end;

// проверяем подключена ли БД. если нет - выходим
if not ADOConnection1.Connected then
  begin
  ShowMessage('Base isn`t connected');
  Exit;
  end;

EFileName.Clear; // чистим поле с именем файла

with TOpenDialog.Create(nil) do // создаем диалог выбора файла
  begin
  if Execute then // если файл выбран то...
    EFileName.Text := FileName; // ...сохраняем имя файла
  Free; // "удаляем" диалог выбора файла
  end;

if EFileName.Text = EmptyStr then // если пусто...
  Exit; // ...выходим

with TFileStream.Create(EFileName.Text, fmOpenRead or fmShareDenyNone) do // создаем поток для открытия файла
  begin
  ReadBuffer(a, SizeOf(a)); // читаем в массив первые 128 байт
  Free; // "удаляем" файловый поток
  end;

for i := Low(a) to High(a) do // бежим по массиву от первого до последнего элемента
  s_hex := s_hex + IntToHex(a[i], 2); // заполняем строку шестнадцатеричными значениями из массива

with TADOQuery.Create(nil) do // создаем объект для получения данных из БД
  begin
  Connection := ADOConnection1; // указываем каким пользоваться подключением
  SQL.Text := 'select * from File_Extension where :hex like hex+"%"'; // запрос к таблице для получения данных
  Parameters.ParamByName('hex').Value := s_hex; // передаем параметр для запроса
  Open; // открываем
  First; // становимся на первую запись
  if not Eof then // если есть хоть одна строка, то Eof не будет ложью. значит есть с чем работать
    begin // пишем что найдено
    Label6.Caption := 'due to Hex';
    Label6.Visible:=true;
    Label2.Caption := FieldByName('Program').AsString;
    Label2.Visible:=true;
    Label4.Visible:=true;
    Label3.Caption := FieldByName('Description').AsString;
    Label3.Visible:=true;
    Label5.Visible:=true;
    end
  else // если ничего не было найдено...
    begin // ... ищем по расширению
    SQL.Text := 'select * from File_Extension where Extension=:ext';
    Parameters.ParamByName('ext').Value := ExtractFileExt(EFileName.Text);
    Open;
    First;
    if not Eof then
      begin // пишем что найдено
      Label6.Caption := 'due to Ext';
      Label6.Visible:=true;
      Label2.Caption := FieldByName('Program').AsString;
      Label2.Visible:=true;
      Label4.Visible:=true;
      Label3.Caption := FieldByName('Description').AsString;
      Label3.Visible:=true;
      Label5.Visible:=true;
      end
    else // если и тут ничего не найдено...
      begin // ...пишем что НЕ найдено
      Label6.Caption := 'Not found. Upload please this file to my e-mail: mrDeShock@yandex.ua';
      Label6.Visible:=true;
      Label2.Caption := EmptyStr;
      Label3.Caption := EmptyStr;
      end;
    end;
  Free;
  end;

ADOConnection1.Connected := False;
end;


end.
