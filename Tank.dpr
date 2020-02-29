program Tank;

uses
  Forms,
  U_T in 'U_T.pas' {mf},
  U_T2 in 'U_T2.pas' {mf2};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(Tmf2, mf2);
  Application.CreateForm(Tmf, mf);
  Application.Run;
end.
