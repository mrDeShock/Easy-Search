program FES_P;

uses
  Forms,
  FES_U in 'FES_U.pas' {Form1},
  FES_U2 in 'FES_U2.pas' {Form2},
  FES_U3 in 'FES_U3.pas' {Form3},
  FES_U4 in 'FES_U4.pas' {Form4},
  FES_U5 in 'FES_U5.pas' {Form5};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Easy Search';
  Application.HelpFile := '';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
