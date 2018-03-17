program QuaGlei;

uses
  Forms,
  MainF in 'MainF.pas' {MainForm},
  ViewF in 'ViewF.pas' {ViewForm},
  InfoF in 'InfoF.pas' {InfoForm},
  HinweisF in 'HinweisF.pas' {HinweisForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := '| Shorei | Quadratische Gleichungen - Berechner';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TViewForm, ViewForm);
  Application.CreateForm(TInfoForm, InfoForm);
  Application.CreateForm(THinweisForm, HinweisForm);
  Application.Run;
end.
