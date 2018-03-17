unit QuaGleiU;

// DON'T DELETE THIS COMMENT !!!

{--------------------------------------------}
{ Unit :     QuaGleiU.pas                    }
{ Version:   1.87                            }
{                                            }
{ Coder:     Yahe <hello@yahe.sh>            }
{                                            }
{ I'm NOT Liable For Damages Of ANY Kind !!! }
{--------------------------------------------}

// DON'T DELETE THIS COMMENT !!!

interface

uses
  SysUtils;

type
  TQGStringRecord = record
    X1 : String;
    X2 : String;
  end;

  TQGResult = record
    Calculation : TQGStringRecord;
    Result      : TQGStringRecord;
  end;

function GetQGResultNew(  P, Q : Extended) : TQGResult;
function GetQGResultExNew(P, Q : Extended; Decimals : Integer) : TQGResult;

procedure GetQGResultOld(P, Q : Extended; var ReturnValue : TQGResult);

function QGResult(FCalculation : TQGStringRecord; FResult : TQGStringRecord) : TQGResult;
function QGStringRecord(FX1 : String; FX2 : String) : TQGStringRecord;

implementation

function GetQGResultNew(P : Extended; Q : Extended) : TQGResult;
begin
  try
    Result := GetQGResultExNew(P, Q, 2);
  except
  end;
end;

function GetQGResultExNew(P : Extended; Q : Extended; Decimals : Integer) : TQGResult;
var
  NegResult : Extended;
begin
  try
    Result.Calculation := QGStringRecord((' - ( ' + FloatToStr(P) + ' / 2 ) + Sqr( ( ' + FloatToStr(P) + ' / 2 )² - ( ' + FloatToStr(Q) + ' ) )'),
                                         (' - ( ' + FloatToStr(P) + ' / 2 ) - Sqr( ( ' + FloatToStr(P) + ' / 2 )² - ( ' + FloatToStr(Q) + ' ) )'));
    Result.Result      := QGStringRecord((Format('%1.*n', [Decimals, (- (P / 2) + Sqrt(Sqr(P / 2) - Q))])),
                                         (Format('%1.*n', [Decimals, (- (P / 2) - Sqrt(Sqr(P / 2) - Q))])));
  except
    try
      NegResult := Sqrt(Abs(Sqr(P / 2) - Q));
      Result.Result := QGStringRecord((' - (' + Format('%1.*n', [Decimals, (P / 2)]) + ') + ( ' + Format('%1.*n', [Decimals, NegResult]) + ' * i )'),
                                      (' - (' + Format('%1.*n', [Decimals, (P / 2)]) + ') - ( ' + Format('%1.*n', [Decimals, NegResult]) + ' * i )'));
    except
      try
        Result.Calculation := QGStringRecord(('NOT SOLVABLE'),
                                             ('NOT SOLVABLE'));
        Result.Result      := QGStringRecord(('NOT SOLVABLE'),
                                             ('NOT SOLVABLE'));
      except
      end;
    end;
  end;
end;

procedure GetQGResultOld(P, Q : extended; var ReturnValue : TQGResult);
var
  NegResult : Extended;
begin
  try
    ReturnValue.Calculation := QGStringRecord((' - ( ' + FloatToStr(P) + ' / 2 ) + Sqr( ( ' + FloatToStr(P) + ' / 2 )² - ( ' + FloatToStr(Q) + ' ) )'),
                                              (' - ( ' + FloatToStr(P) + ' / 2 ) - Sqr( ( ' + FloatToStr(P) + ' / 2 )² - ( ' + FloatToStr(Q) + ' ) )'));
    ReturnValue.Result      := QGStringRecord((FloatToStr(- (P / 2) + Sqrt(Sqr(P / 2) - Q))),
                                              (FloatToStr(- (P / 2) - Sqrt(Sqr(P / 2) - Q))));
  except
    try
      NegResult := Sqrt(Abs(Sqr(P / 2) - Q));
      ReturnValue.Result := QGStringRecord((' - (' + FloatToStr(P / 2) + ') + ( ' + FloatToStr(NegResult) + ' * i )'),
                                           (' - (' + FloatToStr(P / 2) + ') - ( ' + FloatToStr(NegResult) + ' * i )'));
    except
      try
        ReturnValue.Calculation := QGStringRecord(('NOT SOLVABLE'),
                                                  ('NOT SOLVABLE'));
        ReturnValue.Result      := QGStringRecord(('NOT SOLVABLE'),
                                                  ('NOT SOLVABLE'));
      except
      end;
    end;
  end;
end;

function QGResult(FCalculation : TQGStringRecord; FResult : TQGStringRecord) : TQGResult;
begin
  try
    Result.Calculation := FCalculation;
    Result.Result      := FResult;
  except
    try
      Result.Calculation := QGStringRecord('', '');
      Result.Result      := QGStringRecord('', '');
    except
      try
        Result.Calculation.X1 := '';
        Result.Calculation.X2 := '';
        Result.Result.X1      := '';
        Result.Result.X2      := '';
      except
      end;
    end;
  end;
end;

function QGStringRecord(FX1 : String; FX2 : String) : TQGStringRecord;
begin
  try
    Result.X1 := FX1;
    Result.X2 := FX2;
  except
    try
      Result.X1 := '';
      Result.X2 := '';
    except
    end;
  end;
end;

end.
