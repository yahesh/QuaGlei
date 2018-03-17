unit ViewF;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Menus, ExtDlgs, FunctU, StdCtrls;

type
  TViewForm = class(TForm)
    ViewImage: TImage;
    MainMenu: TMainMenu;
    DateiMenuItem: TMenuItem;
    SpeichernMenuItem: TMenuItem;
    SavePictureDialog: TSavePictureDialog;
    OptionsPanel: TPanel;
    DrawLinesCheckBox: TCheckBox;
    XIncZoomButton: TButton;
    XDecZoomButton: TButton;
    YIncZoomButton: TButton;
    YDecZoomButton: TButton;
    XZoomLabel: TLabel;
    YZoomLabel: TLabel;
    XMoveLabel: TLabel;
    XDecMoveButton: TButton;
    XIncMoveButton: TButton;
    YMoveLabel: TLabel;
    YIncMoveButton: TButton;
    YDecMoveButton: TButton;
    DrawAxesCheckBox: TCheckBox;
    XMoveEdit: TEdit;
    YMoveEdit: TEdit;
    DrawMoveCheckBox: TCheckBox;
    DrawZoomCheckBox: TCheckBox;
    DrawFunctionCheckBox: TCheckBox;
    XZoomEdit: TEdit;
    YZoomEdit: TEdit;
    InfoLabel: TLabel;
    
    procedure SpeichernMenuItemClick(Sender: TObject);
    procedure XIncZoomButtonClick(Sender: TObject);
    procedure XDecZoomButtonClick(Sender: TObject);
    procedure YIncZoomButtonClick(Sender: TObject);
    procedure YDecZoomButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure XDecMoveButtonClick(Sender: TObject);
    procedure XIncMoveButtonClick(Sender: TObject);
    procedure YIncMoveButtonClick(Sender: TObject);
    procedure YDecMoveButtonClick(Sender: TObject);
    procedure DrawAxesCheckBoxClick(Sender: TObject);
    procedure XMoveEditChange(Sender: TObject);
    procedure YMoveEditChange(Sender: TObject);
    procedure XZoomEditChange(Sender: TObject);
    procedure YZoomEditChange(Sender: TObject);
    procedure GetKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GetRenewed(Sender : TObject);
  private
    { Private-Deklarationen }
    FActivateDraw : Boolean;
    FFunction     : TFunctionValueRecordArray;
    FXLinesCount  : Integer;
    FXMovePixels  : Integer;
    FYLinesCount  : Integer;
    FYMovePixels  : Integer;

    function LineSpace : TPoint;
    function ImageMiddlePos : TPoint;

    procedure ClearImage;
    procedure DrawFunction(AFunction : TFunctionValueRecordArray);
    procedure DrawInformation;
    procedure DrawLine(AStart : TPoint; AEnd : TPoint); overload;
    procedure DrawLine(AStartX : Integer; AStartY : Integer; AEndX : Integer; AEndY : Integer); overload;
    procedure DrawLines;
  public
    { Public-Deklarationen }
    procedure Draw;
    procedure EnterFunction(AA : Extended; AB : Extended; AC : Extended; AD : Extended);
  end;

var
  ViewForm: TViewForm;

implementation

{$R *.DFM}

procedure TViewForm.ClearImage;
begin
  ViewImage.Picture.Bitmap.Canvas.Pen.Color := clBlack;

  ViewImage.Picture.Bitmap.Height := ViewImage.Height;
  ViewImage.Picture.Bitmap.Width  := ViewImage.Width;

  ViewImage.Picture.Bitmap.Canvas.Rectangle(0, 0, ViewImage.Width, ViewImage.Height);
end;

procedure TViewForm.Draw;
begin
  if FActivateDraw then
  begin
    ClearImage;

    DrawInformation;
    DrawLines;
    DrawFunction(FFunction);
  end;
end;

procedure TViewForm.DrawFunction(AFunction : TFunctionValueRecordArray);
var
  Index             : Integer;
  MaxIndex          : Integer;
  MinIndex          : Integer;
  NegativePoint     : TPoint;
  NextNegativePoint : TPoint;
  NextPositivePoint : TPoint;
  PositivePoint     : TPoint;
begin
  ViewImage.Canvas.Pen.Color := clRed;

  MaxIndex := Succ(Abs(FXMovePixels) + ViewImage.Width);
  MinIndex := Abs(FXMovePixels) - ViewImage.Width;

  for Index := MinIndex to MaxIndex do
  begin
    if (FXMovePixels > - ImageMiddlePos.X) then
    begin
      NegativePoint.X := ImageMiddlePos.X - Index;
      NegativePoint.Y := ImageMiddlePos.Y - Trunc(CalculateFunction(AFunction, ((NegativePoint.X - ImageMiddlePos.X) / LineSpace.X)) * LineSpace.Y);

      NextNegativePoint.X := ImageMiddlePos.X - Succ(Index);
      NextNegativePoint.Y := ImageMiddlePos.Y - Trunc(CalculateFunction(AFunction, ((NextNegativePoint.X - ImageMiddlePos.X) / LineSpace.X)) * LineSpace.Y);

      ViewImage.Picture.Bitmap.Canvas.Pixels[NegativePoint.X + FXMovePixels, NegativePoint.Y + FYMovePixels] := clRed;
      ViewImage.Picture.Bitmap.Canvas.Pixels[NextNegativePoint.X + FXMovePixels, NextNegativePoint.Y + FYMovePixels] := clRed;

      DrawLine(NegativePoint.X + FXMovePixels, NegativePoint.Y + FYMovePixels,
               NextNegativePoint.X + FXMovePixels, NextNegativePoint.Y + FYMovePixels);
    end;

    if (FXMovePixels < ImageMiddlePos.X) then
    begin
      PositivePoint.X := ImageMiddlePos.X + Index;
      PositivePoint.Y := ImageMiddlePos.Y - Trunc(CalculateFunction(AFunction, ((PositivePoint.X - ImageMiddlePos.X) / LineSpace.X)) * LineSpace.Y);

      NextPositivePoint.X := ImageMiddlePos.X + Succ(Index);
      NextPositivePoint.Y := ImageMiddlePos.Y - Trunc(CalculateFunction(AFunction, ((NextPositivePoint.X - ImageMiddlePos.X) / LineSpace.X)) * LineSpace.Y);

      ViewImage.Picture.Bitmap.Canvas.Pixels[NextPositivePoint.X + FXMovePixels, NextPositivePoint.Y + FYMovePixels] := clRed;
      ViewImage.Picture.Bitmap.Canvas.Pixels[PositivePoint.X + FXMovePixels, PositivePoint.Y + FYMovePixels] := clRed;

      DrawLine(PositivePoint.X + FXMovePixels, PositivePoint.Y + FYMovePixels,
               NextPositivePoint.X + FXMovePixels, NextPositivePoint.Y + FYMovePixels);
    end;
  end;
end;

procedure TViewForm.DrawLine(AStart : TPoint; AEnd : TPoint);
begin
  ViewImage.Canvas.MoveTo(AStart.X, AStart.Y);
  ViewImage.Canvas.LineTo(AEnd.X, AEnd.Y);
end;

procedure TViewForm.DrawLines;
var
  Index      : Integer;
  LinesEnd   : TPoint;
  LinesStart : TPoint;
  MaxIndex   : Integer;
  MinIndex   : Integer;
begin
  ViewImage.Canvas.Pen.Color := clBlack;

  if (FXMovePixels < ImageMiddlePos.X) and DrawAxesCheckBox.Checked then
    DrawLine(Point(ImageMiddlePos.X + FXMovePixels, 0), Point(ImageMiddlePos.X + FXMovePixels, ViewImage.Height));
  if (FYMovePixels < ImageMiddlePos.Y) and DrawAxesCheckBox.Checked then
    DrawLine(Point(0, ImageMiddlePos.Y + FYMovePixels), Point(ViewImage.Width, ImageMiddlePos.Y + FYMovePixels));

  if (FXLinesCount > 0) and DrawLinesCheckBox.Checked and DrawAxesCheckBox.Checked then
  begin
    LinesEnd.Y   := ImageMiddlePos.Y + 5 + FYMovePixels;
    LinesStart.Y := ImageMiddlePos.Y - 5 + FYMovePixels;

    MaxIndex := Succ(Trunc((Abs(FXMovePixels) + ViewImage.Width) / LineSpace.X));
    MinIndex := Trunc((Abs(FXMovePixels) - ViewImage.Width) / LineSpace.Y);

    for Index := MinIndex to MaxIndex do
    begin
      if (FXMovePixels > - ImageMiddlePos.X) then
        DrawLine(ImageMiddlePos.X - (LineSpace.X * Index) + FXMovePixels, LinesStart.Y, ImageMiddlePos.X - (LineSpace.X * Index) + FXMovePixels, LinesEnd.Y);

      if (FXMovePixels < ImageMiddlePos.X) then
        DrawLine(ImageMiddlePos.X + (LineSpace.X * Index) + FXMovePixels, LinesStart.Y, ImageMiddlePos.X + (LineSpace.X * Index) + FXMovePixels, LinesEnd.Y);
    end;
  end;

  if (FYLinesCount > 0) and DrawLinesCheckBox.Checked and DrawAxesCheckBox.Checked then
  begin
    LinesEnd.X   := ImageMiddlePos.X + 5 + FXMovePixels;
    LinesStart.X := ImageMiddlePos.X - 5 + FXMovePixels;

    MaxIndex := Succ(Trunc((Abs(FYMovePixels) + ViewImage.Height) / LineSpace.Y));
    MinIndex := Trunc((Abs(FYMovePixels) - ViewImage.Height) / LineSpace.Y);

    for Index := MinIndex to MaxIndex do
    begin
      if (FYMovePixels > - ImageMiddlePos.Y) then
        DrawLine(LinesStart.X, ImageMiddlePos.Y - (LineSpace.Y * Index) + FYMovePixels, LinesEnd.X, ImageMiddlePos.Y - (LineSpace.Y * Index) + FYMovePixels);

      if (FYMovePixels < ImageMiddlePos.Y) then
        DrawLine(LinesStart.X, ImageMiddlePos.Y + (LineSpace.Y * Index) + FYMovePixels, LinesEnd.X, ImageMiddlePos.Y + (LineSpace.Y * Index) + FYMovePixels);
    end;
  end;
end;

function TViewForm.ImageMiddlePos : TPoint;
begin
  Result.X := Trunc(ViewImage.Width / 2);
  Result.Y := Trunc(ViewImage.Height / 2);
end;

procedure TViewForm.SpeichernMenuItemClick(Sender: TObject);
begin
  if SavePictureDialog.Execute then
  begin
    if not(ExtractFileExt(SavePictureDialog.FileName) = '.bmp') then
      SavePictureDialog.FileName := SavePictureDialog.FileName + '.bmp';

    ViewImage.Picture.Bitmap.SaveToFile(SavePictureDialog.FileName);
  end;
end;

procedure TViewForm.EnterFunction(AA : Extended; AB : Extended; AC : Extended; AD : Extended);
begin
  SetLength(FFunction, 4);

  FFunction[0].Exponent := 2;
  FFunction[0].Root     := false;
  FFunction[0].Value    := AA;
  FFunction[1].Exponent := 1;
  FFunction[1].Root     := false;
  FFunction[1].Value    := AB;
  FFunction[2].Exponent := 0;
  FFunction[2].Root     := false;
  FFunction[2].Value    := AC;
  FFunction[3].Exponent := 0;
  FFunction[3].Root     := false;
  FFunction[3].Value    := - AD;
end;

procedure TViewForm.XIncZoomButtonClick(Sender: TObject);
begin
  if (LineSpace.X > 1) then
  begin
    Inc(FXLinesCount);

    XZoomEdit.Text := IntToStr(FXLinesCount);

    Draw;

    XDecZoomButton.Enabled := true;
  end
  else
    XIncZoomButton.Enabled := false;
end;

procedure TViewForm.XDecZoomButtonClick(Sender: TObject);
begin
  if (FXLinesCount > 1) then
  begin
    Dec(FXLinesCount);

    XZoomEdit.Text := IntToStr(FXLinesCount);

    Draw;

    XIncZoomButton.Enabled := true;
  end
  else
    XDecZoomButton.Enabled := false;
end;

procedure TViewForm.YIncZoomButtonClick(Sender: TObject);
begin
  if (LineSpace.Y > 1) then
  begin
    Inc(FYLinesCount);

    YZoomEdit.Text := IntToStr(FYLinesCount);

    Draw;

    YDecZoomButton.Enabled := true;
  end
  else
    YIncZoomButton.Enabled := false;
end;

procedure TViewForm.YDecZoomButtonClick(Sender: TObject);
begin
  if (FYLinesCount > 1) then
  begin
    Dec(FYLinesCount);

    YZoomEdit.Text := IntToStr(FYLinesCount);

    Draw;

    YIncZoomButton.Enabled := true;
  end
  else
    YDecZoomButton.Enabled := false;
end;

procedure TViewForm.FormCreate(Sender: TObject);
begin
  FActivateDraw := false;

  FYLinesCount := 10;
  FXLinesCount := Succ(Trunc(ViewImage.Width / (ViewImage.Height / FYLinesCount)));

  FXMovePixels := 0;
  FYMovePixels := 0;

  XMoveEdit.Text := IntToStr(FXMovePixels);
  YMoveEdit.Text := IntToStr(FYMovePixels);

  XZoomEdit.Text := IntToStr(FXLinesCount);
  YZoomEdit.Text := IntToStr(FYLinesCount);

  FActivateDraw := true;
end;

procedure TViewForm.XDecMoveButtonClick(Sender: TObject);
begin
  Inc(FXMovePixels, 10);

  XMoveEdit.Text := IntToStr(- FXMovePixels);

  Draw;
end;

procedure TViewForm.XIncMoveButtonClick(Sender: TObject);
begin
  Dec(FXMovePixels, 10);

  XMoveEdit.Text := IntToStr(- FXMovePixels);

  Draw;
end;

procedure TViewForm.YIncMoveButtonClick(Sender: TObject);
begin
  Inc(FYMovePixels, 10);

  YMoveEdit.Text := IntToStr(FYMovePixels);

  Draw;
end;

procedure TViewForm.YDecMoveButtonClick(Sender: TObject);
begin
  Dec(FYMovePixels, 10);

  YMoveEdit.Text := IntToStr(FYMovePixels);

  Draw;
end;

procedure TViewForm.DrawAxesCheckBoxClick(Sender: TObject);
begin
  DrawLinesCheckBox.Enabled := DrawAxesCheckBox.Checked;

  Draw;
end;

procedure TViewForm.DrawLine(AStartX, AStartY, AEndX, AEndY: Integer);
begin
  DrawLine(Point(AStartX, AStartY), Point(AEndX, AEndY));
end;

function TViewForm.LineSpace : TPoint;
begin
  if (FXLinesCount > 0) then
    Result.X := Trunc(ImageMiddlePos.X / FXLinesCount)
  else
    Result.X := ImageMiddlePos.X;

  if (FYLinesCount > 0) then
    Result.Y := Trunc(ImageMiddlePos.Y / FYLinesCount)
  else
    Result.Y := ImageMiddlePos.Y;
end;

procedure TViewForm.XMoveEditChange(Sender: TObject);
var
  ErrorCode : Integer;
  Number    : Integer;
begin
  Val(XMoveEdit.Text, Number, ErrorCode);

  if (ErrorCode = 0) then
  begin
    FXMovePixels := - Number;

    Draw;
  end;
end;

procedure TViewForm.YMoveEditChange(Sender: TObject);
var
  ErrorCode : Integer;
  Number    : Integer;
begin
  Val(YMoveEdit.Text, Number, ErrorCode);

  if (ErrorCode = 0) then
  begin
    FYMovePixels := Number;

    Draw;
  end;
end;

procedure TViewForm.XZoomEditChange(Sender: TObject);
var
  ErrorCode : Integer;
  Number    : Integer;
begin
  Val(XZoomEdit.Text, Number, ErrorCode);

  if (ErrorCode = 0) then
  begin
    if (Number > 0) then
    begin
      if (Trunc((ImageMiddlePos.X div 2) / Number) >= 1) then
      begin
        FXLinesCount := Number;
        Draw;

        XDecZoomButton.Enabled := (FXLinesCount > 1);
        XIncZoomButton.Enabled := ((LineSpace.X > 1) and (Trunc(ImageMiddlePos.X / Number) >= 1));
      end
      else
      begin
        FXLinesCount := Succ(ImageMiddlePos.X div 2);
        XZoomEdit.Text := IntToStr(FXLinesCount);
        Draw;

        XDecZoomButton.Enabled := true;
        XIncZoomButton.Enabled := false;
      end;
    end
    else
    begin
      FXLinesCount := 1;
      XZoomEdit.Text := IntToStr(FXLinesCount);

      XDecZoomButton.Enabled := false;
      XIncZoomButton.Enabled := true;
    end;
  end
  else
  begin
    XDecZoomButton.Enabled := false;
    XIncZoomButton.Enabled := false;
  end;
end;

procedure TViewForm.YZoomEditChange(Sender: TObject);
var
  ErrorCode : Integer;
  Number    : Integer;
begin
  Val(YZoomEdit.Text, Number, ErrorCode);

  if (ErrorCode = 0) then
  begin
    if (Number > 0) then
    begin
      if (Trunc((ImageMiddlePos.Y div 2) / Number) >= 1) then
      begin
        FYLinesCount := Number;
        Draw;

        YDecZoomButton.Enabled := (FYLinesCount > 1);
        YIncZoomButton.Enabled := ((LineSpace.Y > 1) and (Trunc(ImageMiddlePos.Y / Number) >= 1));
      end
      else
      begin
        FYLinesCount := Succ(ImageMiddlePos.Y div 2);
        YZoomEdit.Text := IntToStr(FYLinesCount);
        Draw;

        YDecZoomButton.Enabled := true;
        YIncZoomButton.Enabled := false;
      end;
    end
    else
    begin
      FYLinesCount := 1;
      YZoomEdit.Text := IntToStr(FYLinesCount);

      XDecZoomButton.Enabled := false;
      XIncZoomButton.Enabled := true;
    end;
  end
  else
  begin
    YDecZoomButton.Enabled := false;
    YIncZoomButton.Enabled := false;
  end;
end;

procedure TViewForm.GetKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = vk_F5) then
  begin
    OptionsPanel.Visible := not(OptionsPanel.Visible);

    Draw;
  end;
end;

procedure TViewForm.GetRenewed(Sender: TObject);
begin
  Draw;

  XDecZoomButton.Enabled := (FXLinesCount > 1);
  XIncZoomButton.Enabled := (LineSpace.X > 1);
  YDecZoomButton.Enabled := (FYLinesCount > 1);
  YIncZoomButton.Enabled := (LineSpace.Y > 1);
end;

procedure TViewForm.DrawInformation;
var
  XPosition : Integer;
begin
  if DrawFunctionCheckBox.Checked then
  begin
    if (Length(FFunction) >= 4) then
    begin
      ViewImage.Picture.Bitmap.Canvas.TextOut(10,
                                              10,
                                              '(' +
                                              FloatToStr(FFunction[0].Value) +
                                              ')x² + (' +
                                              FloatToStr(FFunction[1].Value) +
                                              ')x + (' +
                                              FloatToStr(FFunction[2].Value) +
                                              ') = (' +
                                              FloatToStr(- FFunction[3].Value) +
                                              ')');
    end;
  end;

  if DrawMoveCheckBox.Checked then
  begin
    if (ViewImage.Picture.Bitmap.Canvas.TextWidth('X: Verschiebung um ' + IntToStr(- FXMovePixels) + ' Pixel') >
        ViewImage.Picture.Bitmap.Canvas.TextWidth('Y: Verschiebung um ' + IntToStr(- FYMovePixels) + ' Pixel')) then
      XPosition := (ViewImage.Width - 10 - ViewImage.Picture.Bitmap.Canvas.TextWidth('X: Verschiebung um ' + IntToStr(- FXMovePixels) + ' Pixel'))
    else
      XPosition := (ViewImage.Width - 10 - ViewImage.Picture.Bitmap.Canvas.TextWidth('Y: Verschiebung um ' + IntToStr(- FYMovePixels) + ' Pixel'));

    ViewImage.Picture.Bitmap.Canvas.TextOut(XPosition,
                                            ViewImage.Height - (2 * ViewImage.Picture.Bitmap.Canvas.TextHeight('X')) - 10,
                                            'X: Verschiebung um ' + IntToStr(- FXMovePixels) + ' Pixel');
    ViewImage.Picture.Bitmap.Canvas.TextOut(XPosition,
                                            ViewImage.Height - ViewImage.Picture.Bitmap.Canvas.TextHeight('Y') - 10,
                                            'Y: Verschiebung um ' + IntToStr(FYMovePixels) + ' Pixel');
  end;

  if DrawZoomCheckBox.Checked then
  begin
    ViewImage.Picture.Bitmap.Canvas.TextOut(10,
                                            ViewImage.Height - (2 * ViewImage.Picture.Bitmap.Canvas.TextHeight('Y')) - 10,
                                            'X: 1 Element entspricht ' + IntToStr(LineSpace.X) + ' Pixeln - (' + IntToStr(2 * FXLinesCount) + ' Einheiten werden angezeigt)');
    ViewImage.Picture.Bitmap.Canvas.TextOut(10,
                                            ViewImage.Height - ViewImage.Picture.Bitmap.Canvas.TextHeight('Y') - 10,
                                            'Y: 1 Element entspricht ' + IntToStr(LineSpace.Y) + ' Pixeln - (' + IntToStr(2 * FYLinesCount) + ' Einheiten werden angezeigt)');
  end;
end;

end.
