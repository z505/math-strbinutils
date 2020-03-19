unit binstrutils;

interface

uses
  SysUtils,
  Dialogs; // showmessage, remove later

type
  TBinSpacer = (bsNone, bsSpace, bsPipe);

const
  CHR_SPACE = ' ';
  CHR_PIPE = '|';
  CHR_NONE = '';

function AnsiStringToBinaryString(const s: AnsiString; binspacer: TBinSpacer): AnsiString;
function BinStrToStr(input: AnsiString; BinSpacer: TBinSpacer; var err: integer): AnsiString;

function GetBit(const aValue: Cardinal; const Bit: Byte): Boolean;
function SetBit(const aValue: Cardinal; const Bit: Byte): Cardinal;
function ClearBit(const aValue: Cardinal; const Bit: Byte): Cardinal;

function CharToBinStr(const s: AnsiString): AnsiString;


implementation

function CharToBinStr(const s: AnsiString): AnsiString;
begin
  result := '';

end;

function AnsiStringToBinaryString(const s: AnsiString; binspacer: TBinSpacer): AnsiString;
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

//get if a bit is 1  Note: counting starts from last bit position, zero based
function GetBit(const aValue: Cardinal; const Bit: Byte): Boolean;
begin
  Result := (aValue and (1 shl Bit)) <> 0;
end;

// set a bit as 1  Note: zero based, starts from last bit   0 0 0 0 0 0 0 0
//                                                          7 6 5 4 3 2 1 0
function SetBit(const aValue: Cardinal; const Bit: Byte): Cardinal;
begin
  Result := aValue or (1 shl Bit);
end;

//set a bit as 0
function ClearBit(const aValue: Cardinal; const Bit: Byte): Cardinal;
begin
  Result := aValue and not (1 shl Bit);
end;

{
  if length(input) mod 8 > 0 then begin // see if there is a remainder
    err := 3; // invalid string length (must be divisible by 8 characters)
    exit;
  end;
}

function BinStrToStr(input: AnsiString; BinSpacer: TBinSpacer; var err: integer): AnsiString;
var
  done: boolean;
  i: integer;
  prev, eight: ansistring;
  b: byte;
  bitpos: integer;  // every byte has 8 bit positions
begin
  err := 0;
  bitpos := 7;
  b := 0;
  result := '';
  eight := '';
  done := false;
  if length(input) < 8 then begin
    err := 1; // invalid string (must be greater than 8 characters)
    exit;
  end;

  i := 1;
  while not done do begin
    if (input[i] <> '1') xor (input[i] <> '0') xor (input[i] <> ' ') then begin
      err := 2; // invalid string (must contain 0 and 1's only)
      result := '';
      exit;
    end;
    prev := ansichar(input[i]);
    eight := eight + prev;
    showmessage('eight: ' + eight);
    if input[i] = ' ' then begin
      inc(i, 1);
      bitpos := 7;
      // b := 0;
      eight := '';
      continue;
    end;

    // binary 0 state
    if input[i] = '0' then begin
      b := ClearBit(b, bitpos);
    end;
    // binary 1 state
    if input[i] = '1' then begin
      b := SetBit(b, bitpos);
    end;

    if bitpos = 0 then begin
      showmessage('b: '+ inttostr(b));
      result := result + ansichar(b);
      b := 0; // clears entire byte to 00000000
    end;

    dec(bitpos); // 0 0 0 0 0 0 0 0
                 // 7 6 5 4 3 2 1 0   position
    inc(i, 1);
    if i > length(input) then begin
      done := true;
    end;

  end;

end;

{ TODO: bytestr: 8 character string with 1's and 0's }

end.
