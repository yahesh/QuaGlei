unit HinweisF;

interface

uses
  Forms, Classes, Controls, StdCtrls, Buttons;

type
  THinweisForm = class(TForm)
    Hinweis1Label         : TLabel;
    HinweisMemo           : TMemo;
    SchliessenSpeedButton : TSpeedButton;

    procedure ButtonBeenden(Sender : TObject);
    procedure MemoBeenden(Sender : TObject; var Key : Char);
  private
    { Private-Deklarationen }
  protected
    { Protected-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  HinweisForm : THinweisForm;

implementation

{$R *.DFM}

procedure THinweisForm.ButtonBeenden(Sender : TObject);
begin
  Close;
end;

procedure THinweisForm.MemoBeenden(Sender : TObject; var Key : Char);
begin
  Close;
end;

end.
