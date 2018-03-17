unit MainF;

interface

uses
  Windows, Messages, SysUtils, Graphics, Forms, ShellAPI, QuaGleiU, Classes,
  Controls, Dialogs, StdCtrls, ExtCtrls, Buttons, Menus, ImgList;

const
  WM_TaskBarEvent = WM_User + 1;

type
  TMainForm = class(TForm)
    aEdit                         : TEdit;
    aLabel                        : TLabel;
    AllesMarkierenMenuItem        : TMenuItem;
    AusschneidenMenuItem          : TMenuItem;
    BearbeitenMenuItem            : TMenuItem;
    BearbeitenTrennstrichMenuItem : TMenuItem;
    bEdit                         : TEdit;
    BeendenMenuItem               : TMenuItem;
    BeendenPopupMenuItem          : TMenuItem;
    BerechnenBitBtn               : TBitBtn;
    bLabel                        : TLabel;
    cEdit                         : TEdit;
    DateiMenuItem                 : TMenuItem;
    DateiTrennMinimizeMenuItem    : TMenuItem;
    DateiTrennNewMenuItem         : TMenuItem;
    DateiTrennSaveAsMenuItem      : TMenuItem;
    DrawFunctionMenuItem          : TMenuItem;
    EinfuegenMenuItem             : TMenuItem;
    ExtrasMenuItem                : TMenuItem;
    GetYSchnittstelleMenuItem     : TMenuItem;
    GetScheitelpunktMenuItem      : TMenuItem;
    HilfeMenuItem                 : TMenuItem;
    HilfeTrennstrichMenuItem      : TMenuItem;
    HinweisMenuItem               : TMenuItem;
    HinweisPopupMenuItem          : TMenuItem;
    ImageList                     : TImageList;
    InfoMenuItem                  : TMenuItem;
    InfoPopupMenuItem             : TMenuItem;
    IstGleichEdit                 : TEdit;
    IstGleichLabel                : TLabel;
    KopierenMenuItem              : TMenuItem;
    LoeschenMenuItem              : TMenuItem;
    LoesungSaveDialog             : TSaveDialog;
    MainFormBevel                 : TBevel;
    MainMenu                      : TMainMenu;
    MinimierenMenuItem            : TMenuItem;
    NeuMenuItem                   : TMenuItem;
    ObenTrennstrichMenuItem       : TMenuItem;
    OptionenPopupMenu             : TPopupMenu;
    SpeichernMenuItem             : TMenuItem;
    SpeichernUnterMenuItem        : TMenuItem;
    UntenTrennstrichPopupMenuItem : TMenuItem;
    MaximierenPopupMenuItem       : TMenuItem;
    X1Edit                        : TEdit;
    X1GleichLabel                 : TLabel;
    X1LoesungEdit                 : TEdit;
    X1WegLabel                    : TLabel;
    X2Edit                        : TEdit;
    X2LoesungEdit                 : TEdit;
    X2GleichLabel                 : TLabel;
    X2WegLabel                    : TLabel;

    procedure AllesMarkieren(Sender : TObject);
    procedure AllesNeu(Sender : TObject);
    procedure Ausschneiden(Sender : TObject);
    procedure BearbeitenPruefen(Sender : TObject);
    procedure Beenden(Sender : TObject);
    procedure BerechnenBitBtnClick(Sender : TObject);
    procedure DateiSchreiben(Sender: TObject);
    procedure DrawFunctionMenuItemClick(Sender : TObject);
    procedure EditChange(Sender : TObject);
    procedure EditEnter(Sender : TObject);
    procedure EditExit(Sender : TObject);
    procedure Einfuegen(Sender : TObject);
    procedure FormCreate(Sender : TObject);
    procedure GetScheitelpunktMenuItemClick(Sender : TObject);
    procedure GetYSchnittstelleMenuItemClick(Sender : TObject);
    procedure Hinweis(Sender : TObject);
    procedure IconAusTaskBar(Sender : TObject);
    procedure IconInTaskBar(Sender : TObject);
    procedure Info(Sender : TObject);
    procedure Kopieren(Sender : TObject);
    procedure Loeschen(Sender : TObject);
    procedure NurTabMitEnter(Sender : TObject; var Key : Char);
    procedure Speichern(Sender : TObject);
  private
    { Private-Deklarationen }
  protected
    { Protected-Deklarationen }
    Datei     : TextFile;
    Dateiname : String;
    FEdit     : TObject;
    Loesung   : TQGResult;

    procedure TaskBarEvents(var AMessage : TMessage); message WM_TaskBarEvent;
  public
    { Public-Deklarationen }
  end;

var
  AHandle  : THandle;
  MainForm : TMainForm;

implementation

uses
  InfoF, HinweisF, ViewF;

{$R *.DFM}

procedure TMainForm.AllesMarkieren(Sender : TObject);
begin
  try
    if (FEdit.ClassType = TEdit) then
      TEdit(FEdit).SelectAll;
  except
  end;
end;

procedure TMainForm.AllesNeu(Sender : TObject);
begin
  try
    aEdit.Color   := clWindow;
    aEdit.Enabled := true;
    aEdit.Text    := '1';

    bEdit.Color             := clWindow;
    bEdit.Enabled           := true;
    bEdit.Text              := '0';
    BerechnenBitBtn.Visible := true;

    cEdit.Color   := clWindow;
    cEdit.Enabled := true;
    cEdit.Text    := '0';

    EinfuegenMenuItem.Enabled := true;

    IstGleichEdit.Color   := clWindow;
    IstGleichEdit.Enabled := true;
    IstGleichEdit.Text    := '0';

    SpeichernMenuItem.Enabled      := false;
    SpeichernUnterMenuItem.Enabled := false;

    X1Edit.Text           := '';
    X1Edit.Visible        := false;
    X1GleichLabel.Caption := 'x2=';
    X1GleichLabel.Visible := false;
    X1LoesungEdit.Text    := '';
    X1LoesungEdit.Visible := false;
    X1WegLabel.Visible    := false;
    X2Edit.Text           := '';
    X2Edit.Visible        := false;
    X2GleichLabel.Visible := false;
    X2LoesungEdit.Text    := '';
    X2LoesungEdit.Visible := false;
    X2WegLabel.Caption    := 'x2=';
    X2WegLabel.Visible    := false;

    aEdit.SetFocus;
  except
  end;
end;

procedure TMainForm.Ausschneiden(Sender : TObject);
begin
  try
    if (FEdit.ClassType = TEdit) then
      TEdit(FEdit).CutToClipboard;
  except
  end;
end;

procedure TMainForm.BearbeitenPruefen(Sender : TObject);
begin
  if (Sender.ClassType = TEdit) then
  begin
    if TEdit(Sender).ReadOnly then
    begin
      if (TEdit(Sender).Text = '') then
      begin
        AllesMarkierenMenuItem.Enabled := false;
        AusschneidenMenuItem.Enabled   := false;
        EinfuegenMenuItem.Enabled      := false;
        KopierenMenuItem.Enabled       := false;
        LoeschenMenuItem.Enabled       := false;
      end
      else
      begin
        AllesMarkierenMenuItem.Enabled := true;
        AusschneidenMenuItem.Enabled   := false;
        EinfuegenMenuItem.Enabled      := false;
        KopierenMenuItem.Enabled       := true;
        LoeschenMenuItem.Enabled       := false;
      end;
    end
    else
    begin
      if not(TEdit(Sender).ReadOnly) then
      begin
        if (TEdit(Sender).Text = '') then
        begin
          AllesMarkierenMenuItem.Enabled := false;
          AusschneidenMenuItem.Enabled   := false;
          EinfuegenMenuItem.Enabled      := true;
          KopierenMenuItem.Enabled       := false;
          LoeschenMenuItem.Enabled       := false;
        end
        else
        begin
          AllesMarkierenMenuItem.Enabled := true;
          AusschneidenMenuItem.Enabled   := true;
          EinfuegenMenuItem.Enabled      := true;
          KopierenMenuItem.Enabled       := true;
          LoeschenMenuItem.Enabled       := true;
        end;
      end;
    end;
  end
  else
  begin
    KopierenMenuItem.Enabled       := false;
    EinfuegenMenuItem.Enabled      := false;
    AusschneidenMenuItem.Enabled   := false;
    LoeschenMenuItem.Enabled       := false;
    AllesMarkierenMenuItem.Enabled := false;
  end;
end;

procedure TMainForm.Beenden(Sender : TObject);
begin
  try
    IconAusTaskBar(nil);
  except
  end;

  Close;
end;

procedure TMainForm.BerechnenBitBtnClick(Sender : TObject);
var
  A : Extended;
  B : Extended;
  C : Extended;
  D : Extended;
  P : Extended;
  Q : Extended;
begin
  try
    try
      A := StrToFloat(aEdit.Text);
      B := StrToFloat(bEdit.Text);
      C := StrToFloat(cEdit.Text);
      D := StrToFloat(IstGleichEdit.Text);
    except
      MessageDlg('Bitte geben sie in jedem Feld eine gültige Gleitkommazahl ein!',
                 mtError,
                 [mbOK],
                 0);

      Exit;
    end;

    if (A <> 0) then
    begin
      P := B / A;
      Q := (C - D) / A;

      GetQGResultOld(P, Q, Loesung);

      X1Edit.Text           := Loesung.Result.X1;
      X1GleichLabel.Caption := 'x1=';
      X1LoesungEdit.Text    := Loesung.Calculation.X1;
      X1LoesungEdit.Visible := true;
      X1WegLabel.Visible    := true;
      X2Edit.Text           := Loesung.Result.X2;
      X2Edit.Visible        := true;
      X2GleichLabel.Visible := true;
      X2LoesungEdit.Text    := Loesung.Calculation.X2;
      X2WegLabel.Caption    := 'x2=';
    end
    else
    begin
      if MessageDlg('Die von ihnen angegebene Gleichung ist keine quadratischen Gleichung!' +
                    #13#10 +
                    'Allerdings kann die Gleichung als lineare Gleichung behandelt und berechnet werden!' +
                    #13#10 +
                    #13#10 +
                    'Soll dies getan werden?',
                    mtConfirmation,
                    [mbYes, mbNo],
                    0) = mrYes then
      begin
        P := B;
        Q := (D - C);

        if (P <> 0) then
        begin
          X1Edit.Text           := ' ' + FloatToStr(Q / P);
          X1GleichLabel.Caption := ' x=';
          X2LoesungEdit.Text    := ' ' + FloatToStr(Q) + ' / ' + FloatToStr(P);
          X2WegLabel.Caption    := ' x=';
        end
        else
        begin
          MessageDlg('Bitte geben sie für b(''x'') einen Wert <> 0 ein!', mtError, [mbOK], 0);

          Exit;
        end;
      end
      else
        Exit;
    end;

    aEdit.Color   := clBtnFace;
    aEdit.Enabled := false;

    bEdit.Color             := clBtnFace;
    bEdit.Enabled           := false;
    BerechnenBitBtn.Visible := false;

    cEdit.Color   := clBtnFace;
    cEdit.Enabled := false;

    IstGleichEdit.Color   := clBtnFace;
    IstGleichEdit.Enabled := false;

    SpeichernUnterMenuItem.Enabled := true;

    X1Edit.Visible        := true;
    X1GleichLabel.Visible := true;
    X2LoesungEdit.Visible := true;
    X2WegLabel.Visible    := true;

    if LoesungSaveDialog.FileName = '' then
      SpeichernMenuItem.Enabled := false
    else
      SpeichernMenuItem.Enabled := true;

    X1Edit.SetFocus;
  except
    MessageDlg('Unknown Error.', mtError, [mbOK], 0);
  end;
end;

procedure TMainForm.DateiSchreiben(Sender : TObject);
begin
  try
    AssignFile(Datei, DateiName);

    try
      Append(Datei);
    except
      ReWrite(Datei);
    end;

    WriteLn(Datei, '----------');
    WriteLn(Datei, '');
    WriteLn(Datei, 'Berechnet am: ''' + DateToStr(Date) + ''' um: ''' + TimeToStr(Time) + ''' Uhr');
    WriteLn(Datei, '');
    WriteLn(Datei, '');
    WriteLn(Datei, '(' + aEdit.Text + 'x²) + (' + bEdit.Text + 'x) + (' + cEdit.Text + ') = (' + IstGleichEdit.Text + ')');
    WriteLn(Datei, '');

    if (X2WegLabel.Caption = 'x2=') then
    begin
      WriteLn(Datei, 'x1 = ' + Loesung.Calculation.X1);
      WriteLn(Datei, 'x2 = ' + Loesung.Calculation.X2);
      WriteLn(Datei, '');
      WriteLn(Datei, 'x1 = ' + Loesung.Result.X1);
      WriteLn(Datei, 'x2 = ' + Loesung.Result.X2);
    end
    else
    begin
      WriteLn(Datei, 'x = ' + X2LoesungEdit.Text);
      WriteLn(Datei, '');
      WriteLn(Datei, 'x = ' + X1Edit.Text);
    end;

    WriteLn(Datei, '');
    WriteLn(Datei, '');
    WriteLn(Datei, 'vom "| Shorei | - Quadratische Gleichungen - Berechner"');
    WriteLn(Datei, '');
    WriteLn(Datei, '----------');

    SpeichernMenuItem.Enabled  := true;
  finally
    CloseFile(Datei);
  end;
end;

procedure TMainForm.DrawFunctionMenuItemClick(Sender : TObject);
begin
  ViewForm.EnterFunction(StrToFloat(AEdit.Text),
                         StrToFloat(BEdit.Text),
                         StrToFloat(CEdit.Text),
                         StrToFloat(IstGleichEdit.Text));

  ViewForm.Show;
  ViewForm.Draw;
end;

procedure TMainForm.EditChange(Sender : TObject);
var
  Index : Integer;
  Text  : String;
begin
  try
    if (FEdit.ClassType = TEdit) then
    begin
      Text := TEdit(FEdit).Text;

      for Index := 1 to Length(Text) do
      begin
        if not(Text[Index] in [#8, #43..#45, #48..#57, #69, #101]) then
          Delete(Text, Index, 1);
      end;

      TEdit(FEdit).Text := Text;

      BearbeitenPruefen(FEdit);
    end;
  except
  end;
end;

procedure TMainForm.EditEnter(Sender : TObject);
begin
  try
    FEdit := Sender;

    BearbeitenPruefen(FEdit);
  except
  end;
end;

procedure TMainForm.EditExit(Sender : TObject);
begin
  try
    FEdit := nil;
  except
  end;
end;

procedure TMainForm.Einfuegen(Sender : TObject);
begin
  try
    if (FEdit.ClassType = TEdit) then
      TEdit(FEdit).PasteFromClipboard;
  except
  end;
end;

procedure TMainForm.FormCreate(Sender : TObject);
begin
  try
    DoubleBuffered := true;
  except
  end;
end;

procedure TMainForm.GetScheitelpunktMenuItemClick(Sender : TObject);
var
  A : Extended;
  B : Extended;
  C : Extended;
  D : Extended;
  X : Extended;
  Y : Extended;
begin
  try
    A := StrToFloat(aEdit.Text);
    B := StrToFloat(bEdit.Text);
    C := StrToFloat(cEdit.Text);
    D := StrToFloat(IstGleichEdit.Text);
  except
    MessageDlg('Bitte geben sie in jedem Feld eine gültige Gleitkommazahl ein!',
               mtError, [mbOK], 0);

    Exit;
  end;

  if (A <> 0) then
  begin
    X := - ((B / A) / 2);
    Y := - ((Sqr(X) * A) - (C - D));

    MessageDlg('Der Scheitelpunkt dieser Funktion liegt bei:' +
               #13#10 +
               #10#10 +
               '  X = ' + FloatToStr(X) +
               #13#10 +
               '  Y = ' + FloatToStr(Y),
               mtInformation, [mbOK], 0);
  end
  else
    MessageDlg('Diese Funktion ist eine lineare Funktion und besitzt deswegen keinen Scheitelpunkt!',
               mtError, [mbOK], 0);
end;

procedure TMainForm.GetYSchnittstelleMenuItemClick(Sender : TObject);
var
  C : Extended;
  D : Extended;
begin
  try
    C := StrToFloat(cEdit.Text);
    D := StrToFloat(IstGleichEdit.Text);
  except
    MessageDlg('Bitte geben sie in jedem Feld eine gültige Gleitkommazahl ein!',
               mtError, [mbOK], 0);

    Exit;
  end;

  MessageDlg('Die Y-Achsen-Schnittstelle dieser Funktion liegt bei:' +
             #13#10 +
             #10#10 +
             '  Y = ' + FloatToStr(C - D),
             mtInformation, [mbOK], 0);
end;

procedure TMainForm.Hinweis(Sender : TObject);
begin
  try
    HinweisForm.ShowModal;
  except
  end;
end;

procedure TMainForm.IconAusTaskBar(Sender : TObject);
var
  ANotifyIconData : TNotifyIconData;
begin
  try
    ANotifyIconData.cbSize := SizeOf(TNotifyIconData);
    ANotifyIconData.Wnd    := Handle;
    ANotifyIconData.uID    := 1;

    PopupMenu := nil;

    Shell_NotifyIcon(Nim_Delete, @ANotifyIconData);

    HinweisForm.Close;
    InfoForm.Close;

    Show;
  except
  end;
end;

procedure TMainForm.IconInTaskBar(Sender : TObject);
var
  ANotifyIconData : TNotifyIconData;
begin
  try
    ANotifyIconData.cbSize           := SizeOf(TNotifyIconData);
    ANotifyIconData.Wnd              := Handle;
    ANotifyIconData.uID              := 1;
    ANotifyIconData.uFlags           := Nif_Message or Nif_Icon or Nif_Tip;
    ANotifyIconData.uCallbackMessage := WM_TaskBarEvent;
    ANotifyIconData.hIcon            := Icon.Handle;

    PopupMenu := OptionenPopupMenu;

    StrCopy(ANotifyIconData.szTip, '| Shorei | - Quadratische Gleichungen - Berechner');
    Shell_NotifyIcon(Nim_Add, @ANotifyIconData);

    Hide;
  except
  end;
end;

procedure TMainForm.Info(Sender : TObject);
begin
  try
    InfoForm.ShowModal;
  except
  end;
end;

procedure TMainForm.Kopieren(Sender : TObject);
begin
  try
    if (FEdit.ClassType = TEdit) then
      TEdit(FEdit).CopyToClipboard;
  except
  end;
end;

procedure TMainForm.Loeschen(Sender : TObject);
begin
  try
    if (FEdit.ClassType = TEdit) then
      TEdit(FEdit).Clear;
  except
  end;
end;

procedure TMainForm.NurTabMitEnter(Sender : TObject; var Key : Char);
begin
  try
    if Key = #13 then
    begin
      Self.Perform(wm_NextDlgCtl, 0, 0);
      Key := #0;
    end;
  except
  end;
end;

procedure TMainForm.Speichern(Sender : TObject);
begin
  try
    if LoesungSaveDialog.Execute then
    begin
      DateiName := LoesungSaveDialog.FileName;

      DateiSchreiben(nil);
    end;
  except
  end;
end;

procedure TMainForm.TaskBarEvents(var AMessage : TMessage);
var
  APoint : TPoint;
begin
  try
    case AMessage.LParamLo of
      WM_LButtonDblClk :
      begin
        if HinweisForm.Visible = false then
        begin
          if InfoForm.Visible = false then
            IconAusTaskBar(nil);
        end;
      end;

      WM_RButtonDown :
      begin
        if HinweisForm.Visible = false then
        begin
          if InfoForm.Visible = false then
          begin
            GetCursorPos(APoint);
            OptionenPopupMenu.Popup(APoint.X, APoint.Y);
          end;
        end;
      end;
    end;
  except
  end;
end;

initialization
  AHandle := CreateMutex(nil, true, '| Shorei | - Quadratische Gleichungen - Berechner');

  if GetLastError = Error_Already_Exists then
    Halt;

finalization
  if AHandle <> 0 then
    CloseHandle(AHandle)

end.
