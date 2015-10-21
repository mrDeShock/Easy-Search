unit FES_U2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Forms, XPMan,// ����������� ������
  Dialogs, // ������ ��� �������� (showmessage)
  Controls, StdCtrls, // ������ ��� TLabel, TButton, TEdit
  DB, ADODB, Menus; // ������ ��� ����������� � ��

type
  TForm2 = class(TForm)
    EFileName: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Label4: TLabel;
    Label5: TLabel;
    ADOConnection1: TADOConnection;
    Label6: TLabel;
    MainMenu1: TMainMenu;
    Selectfile1: TMenuItem;
    Open1: TMenuItem;
    Close1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    Memo2: TMemo;
    Memo3: TMemo;
    CheckBox1: TCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses FES_U5;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var
  a:array [0..127] of byte; // ������ ������ ��� ������ �� �����
  s_hex:string; // ������ ��� �������������� �� ������� ^^^ � ����������������� ��� ��� ������� � ��
  i:Integer; // ���������� ��� �����
  pth:string; //������ ��� ������ ����� �� ���������
  ext:string; // ������ � ����������� �����
begin
pth := ExtractFileDir(Application.ExeName);
if pth[Length(pth)] <> '\' then
pth := pth + '\';
try
ADOConnection1.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+pth+'extension.mdb;Persist Security Info=False';
ADOConnection1.Connected := True; // ������������ � ��
except
// ����������� try ... except ... end ��� ��������� ������
end;

// ��������� ���������� �� ��. ���� ��� - �������
if not ADOConnection1.Connected then
  begin
  ShowMessage('Base isn`t connected');
  Exit;
  end;

EFileName.Clear; // ������ ���� � ������ �����

with TOpenDialog.Create(nil) do // ������� ������ ������ �����
  begin
  if Execute then // ���� ���� ������ ��...
    EFileName.Text := FileName; // ...��������� ��� �����
  Free; // "�������" ������ ������ �����
  end;

if EFileName.Text = EmptyStr then // ���� �����...
  Exit; // ...�������

with TFileStream.Create(EFileName.Text, fmOpenRead or fmShareDenyNone) do // ������� ����� ��� �������� �����
  begin
  ReadBuffer(a, SizeOf(a)); // ������ � ������ ������ 128 ����
  Free; // "�������" �������� �����
  end;

for i := Low(a) to High(a) do // ����� �� ������� �� ������� �� ���������� ��������
  s_hex := s_hex + IntToHex(a[i], 2); // ��������� ������ ������������������ ���������� �� �������

with TADOQuery.Create(nil) do // ������� ������ ��� ��������� ������ �� ��
  begin
  Connection := ADOConnection1; // ��������� ����� ������������ ������������
  SQL.Text := 'select * from File_Extension where :hex like hex+"%"'; // ������ � ������� ��� ��������� ������
  Parameters.ParamByName('hex').Value := s_hex; // �������� �������� ��� �������
  Open; // ���������
  First; // ���������� �� ������ ������
  if CheckBox1.Checked = True then // ���� � checkbox ����� �������, �� ��������� ����� �� Hex
  if not Eof then // ���� ���� ���� ���� ������, �� Eof �� ����� �����. ������ ���� � ��� ��������
    begin // ����� ��� �������
    Label6.Caption := 'due to Hex';
    Label6.Visible:=true;
    Memo2.Lines.Text := FieldByName('Program').AsString;
    Memo2.Visible:=true;
    Label4.Visible:=true;
    Memo3.Lines.Text := FieldByName('Description').AsString;
    Memo3.Visible:=true;
    Label5.Visible:=true;
    ext:= ExtractFileExt(EFileName.Text); //������ ���������� � ext
    if ext = '' then //���� ���������� � ����� ���
    begin
    Label2.Caption := FieldByName('Extension').AsString;
    Label3.Visible:=true;
    end
    else
    end
  else // ���� �� checkbox ��� ������� � ���� �� ��������
  else // ���� ������ �� ���� �������...
    begin // ... ���� �� ����������
    SQL.Text := 'select * from File_Extension where Extension=:ext';
    Parameters.ParamByName('ext').Value := ExtractFileExt(EFileName.Text);
    Open;
    First;
    if not Eof then
      begin // ����� ��� �������
      Label6.Caption := 'due to Ext';
      Label6.Visible:=true;
      Memo2.Lines.Text := FieldByName('Program').AsString;
      Memo2.Visible:=true;
      Label4.Visible:=true;
      Memo3.Lines.Text := FieldByName('Description').AsString;
      Memo3.Visible:=true;
      Label5.Visible:=true;
      end
    else // ���� � ��� ������ �� �������...
      begin // ...����� ��� �� �������
      Label6.Caption := 'Not found. Upload please this file to my e-mail: mrDeShock@yandex.ua';
      Label6.Visible:=true;
      Memo2.Lines.Text := EmptyStr;
      Memo3.Lines.Text := EmptyStr;
      end;
    end;
  Free;
  end;

ADOConnection1.Connected := False;
end;


procedure TForm2.Close1Click(Sender: TObject);
begin
Form2.Close;
end;

procedure TForm2.About1Click(Sender: TObject);
begin
Form5.Show;
end;

end.
