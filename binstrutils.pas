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
  len: integer;
begin
  Result := '';
  case binspacer of
    bsNone: spacer := CHR_NONE;
    bsSpace: spacer := CHR_SPACE;
    bsPipe: spacer := CHR_PIPE;
  end;
  len:= Length(s);
  for i := 1 to len do begin
    t := Ord(s[i]);
    schar := '';
    for k := 1 to 8 * SizeOf(AnsiChar) do begin
      schar := SBits[t mod 2] + schar;
      t := t div 2
    end;
    if i = len then // skip last space
      Result := Result + schar
    else
      Result := Result + schar + spacer;
  end;
end;

end.
