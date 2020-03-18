unit binstrutils;

interface

type
  TBinSpacer = (bsNone, bsSpace, bsPipe);

const
  CHR_SPACE = ' ';
  CHR_PIPE = '|';
  CHR_NONE = '';

function AnsiStringToBinaryString(const s: AnsiString; binspacer: TBinSpacer): String;


implementation

function AnsiStringToBinaryString(const s: AnsiString; binspacer: TBinSpacer): String;
const
  SBits: array[0..1] of string = ('0', '1');
var
  i, k, t: Integer;
  schar: string;
  spacer: string;
begin
  Result := '';
  case binspacer of
    bsNone: spacer := CHR_NONE;
    bsSpace: spacer := CHR_SPACE;
    bsPipe: spacer := CHR_PIPE;
  end;

  for i := 1 to Length(s) do begin
    t := Ord(s[i]);
    schar := '';
    for k := 1 to 8 * SizeOf(AnsiChar) do begin
      schar := SBits[t mod 2] + schar;
      t := t div 2
    end;
    Result := Result + schar + spacer;
  end;
end;

end.
