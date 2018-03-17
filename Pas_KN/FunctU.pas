unit FunctU;

// DON'T DELETE THIS COMMENT !!!

{--------------------------------------------}
{ Unit :     FunctU.pas                      }
{ Version:   1.13                            }
{                                            }
{ Coder:     Yahe <hello@yahe.sh>            }
{                                            }
{ I'm NOT Liable For Damages Of ANY Kind !!! }
{--------------------------------------------}

// DON'T DELETE THIS COMMENT !!!

interface

uses
  Math;

type
  TFunctionValueRecord = record
    Exponent : Extended;
    Root     : Boolean;
    Value    : Extended;
  end;
  TFunctionValueRecordArray = array of TFunctionValueRecord;

function CalculateFunction(aFunctionValues : TFunctionValueRecordArray; aX : Extended) : Extended;

implementation

function CalculateFunction(aFunctionValues : TFunctionValueRecordArray; aX : Extended) : Extended;
var
  Index : Integer;
begin
  Result := 0;

  for Index := Low(aFunctionValues) to High(aFunctionValues) do
  begin
    if aFunctionValues[Index].Root then
      Result := Result + (aFunctionValues[Index].Value * Power(aX, (1 / aFunctionValues[Index].Exponent)))
    else
      Result := Result + (aFunctionValues[Index].Value * Power(aX, aFunctionValues[Index].Exponent));
  end;
end;

end.
